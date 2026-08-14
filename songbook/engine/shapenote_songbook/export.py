from __future__ import annotations

import hashlib
import math
import os
import pathlib
import tempfile
from dataclasses import dataclass
from typing import Protocol, cast

import pymupdf

from .contract import (
    MIN_PAIR_SCALE,
    OUTER_MARGIN,
    PAGE_HEIGHT,
    PAGE_SIZE_TOLERANCE,
    PAGE_WIDTH,
    PAIR_GUTTER,
    ContractError,
    ExportResultV1,
    Rectangle,
    Rotation,
    rect,
    require_mapping,
    require_object,
)


class _RectView(Protocol):
    @property
    def x0(self) -> float: ...

    @property
    def y0(self) -> float: ...

    @property
    def x1(self) -> float: ...

    @property
    def y1(self) -> float: ...


class _SetRotation(Protocol):
    def __call__(self, rotation: int) -> None: ...


class _ShowPdfPage(Protocol):
    def __call__(
        self,
        rect: object,
        source: object,
        *,
        pno: int,
        clip: object,
        keep_proportion: bool,
        overlay: bool,
        rotate: int,
    ) -> int: ...


class _SetToc(Protocol):
    def __call__(self, toc: list[list[int | str]]) -> int: ...


class _SaveDocument(Protocol):
    def __call__(
        self,
        filename: object,
        *,
        garbage: int,
        deflate: bool,
    ) -> None: ...


@dataclass(frozen=True)
class ValidPlacement:
    song_id: str
    title: str
    path: pathlib.Path
    source_page: int
    source_page_count: int
    rotation: Rotation
    scale: float
    source_bounds: Rectangle
    clip: Rectangle
    target: Rectangle


def _safe_source(repo_root: pathlib.Path, value: object) -> pathlib.Path:
    if not isinstance(value, str) or not value or "\\" in value:
        raise ContractError("placement.sourcePath must be a repo-relative POSIX path")
    pure = pathlib.PurePosixPath(value)
    if pure.is_absolute() or ".." in pure.parts or pure.suffix.lower() != ".pdf":
        raise ContractError(f"unsafe source path: {value}")
    if pure.parts[:2] != ("compositions", "finished"):
        raise ContractError(f"source must be under compositions/finished: {value}")
    finished = (repo_root / "compositions" / "finished").resolve()
    path = (repo_root / pathlib.Path(*pure.parts)).resolve()
    try:
        _ = path.relative_to(finished)
    except ValueError as error:
        raise ContractError(f"source resolves outside compositions/finished: {value}") from error
    if not path.is_file():
        raise ContractError(f"source PDF does not exist: {value}")
    return path


def _validate_target(value: object, name: str) -> Rectangle:
    result = rect(value, name)
    if (
        result[0] < OUTER_MARGIN
        or result[1] < OUTER_MARGIN
        or result[2] > PAGE_WIDTH - OUTER_MARGIN
        or result[3] > PAGE_HEIGHT - OUTER_MARGIN
    ):
        raise ContractError(f"{name} lies outside the 24pt safe output area")
    return result


def _page_count(document: pymupdf.Document) -> int:
    return cast(int, document.page_count)


def _page_rotation(page: pymupdf.Page) -> Rotation:
    value = cast(int, page.rotation)
    if value not in (0, 90, 180, 270):
        raise ContractError(f"source page has unsupported rotation: {value}")
    return value


def _rect_list(value: pymupdf.Rect) -> Rectangle:
    bounds = cast(_RectView, value)
    return [float(bounds.x0), float(bounds.y0), float(bounds.x1), float(bounds.y1)]


def _number(value: object, name: str) -> float:
    if (
        not isinstance(value, (int, float))
        or isinstance(value, bool)
        or not math.isfinite(value)
    ):
        raise ContractError(f"{name} must be a number")
    return float(value)


def _validate_plan(repo_root: pathlib.Path, plan: object) -> list[list[ValidPlacement]]:
    raw_plan = require_object(plan, "plan")
    page_size_value = raw_plan.get("pageSize")
    if not isinstance(page_size_value, list):
        raise ContractError("plan.pageSize must contain width and height")
    page_size_items = cast(list[object], page_size_value)
    if len(page_size_items) != 2:
        raise ContractError("plan.pageSize must contain width and height")
    page_size = [
        _number(page_size_items[0], "plan.pageSize[0]"),
        _number(page_size_items[1], "plan.pageSize[1]"),
    ]
    if abs(page_size[0] - PAGE_WIDTH) > 0.01 or abs(page_size[1] - PAGE_HEIGHT) > 0.01:
        raise ContractError("plan.pageSize must be landscape A4")
    raw_pages_value = raw_plan.get("pages")
    if not isinstance(raw_pages_value, list):
        raise ContractError("plan.pages must be a non-empty array")
    raw_pages = cast(list[object], raw_pages_value)
    if not raw_pages:
        raise ContractError("plan.pages must be a non-empty array")

    open_documents: dict[pathlib.Path, pymupdf.Document] = {}
    result: list[list[ValidPlacement]] = []
    try:
        for page_index, raw_page_value in enumerate(raw_pages):
            raw_page = require_mapping(raw_page_value, f"plan.pages[{page_index}]")
            if raw_page.get("index") != page_index:
                raise ContractError(f"plan.pages[{page_index}] has an invalid index")
            placements_value = raw_page.get("placements")
            if not isinstance(placements_value, list):
                raise ContractError(
                    f"plan.pages[{page_index}] must have one or at most two placements"
                )
            placements = cast(list[object], placements_value)
            if not placements or len(placements) > 2:
                raise ContractError(
                    f"plan.pages[{page_index}] must have one or at most two placements"
                )
            validated_page: list[ValidPlacement] = []
            page_song_ids: set[str] = set()
            for placement_index, placement_value in enumerate(placements):
                name = f"plan.pages[{page_index}].placements[{placement_index}]"
                placement = require_mapping(placement_value, name)
                source_path = placement.get("sourcePath")
                song_id_value = placement.get("songId")
                if not isinstance(song_id_value, str) or song_id_value != source_path:
                    raise ContractError(f"{name}.songId must equal sourcePath")
                song_id = song_id_value
                if song_id in page_song_ids:
                    raise ContractError(f"{name} duplicates a song on one output page")
                page_song_ids.add(song_id)
                title_value = placement.get("title")
                if not isinstance(title_value, str) or not title_value.strip():
                    raise ContractError(f"{name}.title must be a non-empty string")
                title = title_value.strip()
                path = _safe_source(repo_root, source_path)
                fingerprint = placement.get("fingerprint")
                actual_fingerprint = hashlib.sha256(path.read_bytes()).hexdigest()
                if fingerprint != actual_fingerprint:
                    raise ContractError(f"stale fingerprint for {source_path}; rescan and replan")
                document = open_documents.get(path)
                if document is None:
                    try:
                        document = pymupdf.open(path)
                    except (RuntimeError, ValueError) as error:
                        raise ContractError(f"could not open source PDF {source_path}: {error}") from error
                    open_documents[path] = document
                source_page_value = placement.get("sourcePage")
                document_page_count = _page_count(document)
                if (
                    not isinstance(source_page_value, int)
                    or isinstance(source_page_value, bool)
                    or not 0 <= source_page_value < document_page_count
                ):
                    raise ContractError(f"bad source page index for {source_path}: {source_page_value}")
                source_page = source_page_value
                source = document[source_page]
                source_bounds = _rect_list(source.rect)
                if (
                    abs((source_bounds[2] - source_bounds[0]) - PAGE_WIDTH)
                    > PAGE_SIZE_TOLERANCE
                    or abs((source_bounds[3] - source_bounds[1]) - PAGE_HEIGHT)
                    > PAGE_SIZE_TOLERANCE
                ):
                    raise ContractError(
                        f"source page must be landscape A4: {source_path} page {source_page + 1}"
                    )
                rotation_value = placement.get("rotation", 0)
                if (
                    not isinstance(rotation_value, int)
                    or isinstance(rotation_value, bool)
                    or rotation_value not in (0, 90, 180, 270)
                    or rotation_value != _page_rotation(source)
                ):
                    raise ContractError(f"{name}.rotation must match the source page rotation")
                rotation = rotation_value
                clip = rect(placement.get("clip"), f"{name}.clip")
                derotated_bounds = _rect_list(source.rect * source.derotation_matrix)
                if (
                    clip[0] < derotated_bounds[0]
                    or clip[1] < derotated_bounds[1]
                    or clip[2] > derotated_bounds[2]
                    or clip[3] > derotated_bounds[3]
                ):
                    raise ContractError(f"{name}.clip lies outside the source page")
                target = _validate_target(placement.get("target"), f"{name}.target")
                source_width = clip[2] - clip[0]
                source_height = clip[3] - clip[1]
                display_width, display_height = (
                    (source_height, source_width)
                    if rotation in (90, 270)
                    else (source_width, source_height)
                )
                horizontal_scale = (target[2] - target[0]) / display_width
                vertical_scale = (target[3] - target[1]) / display_height
                declared_scale_value = placement.get("scale")
                if (
                    abs(horizontal_scale - vertical_scale) > 0.001
                    or horizontal_scale > 1.0001
                    or not isinstance(declared_scale_value, (int, float))
                    or isinstance(declared_scale_value, bool)
                    or not math.isfinite(declared_scale_value)
                    or abs(float(declared_scale_value) - horizontal_scale) > 0.001
                ):
                    raise ContractError(f"{name} must use one declared scale with no upscaling")
                validated_page.append(
                    ValidPlacement(
                        song_id,
                        title,
                        path,
                        source_page,
                        document_page_count,
                        rotation,
                        float(declared_scale_value),
                        derotated_bounds,
                        clip,
                        target,
                    )
                )
            if len(validated_page) == 2:
                for placement in validated_page:
                    if _page_count(open_documents[placement.path]) != 1 or placement.source_page != 0:
                        raise ContractError("paired placements must each be a one-page song")
                first, second = validated_page
                if abs(first.scale - second.scale) > 0.001:
                    raise ContractError("paired placements must use the same scale")
                if min(first.scale, second.scale) < MIN_PAIR_SCALE or max(first.scale, second.scale) > 1:
                    raise ContractError(
                        f"paired placements must use scale {MIN_PAIR_SCALE:.2f} through 1.00"
                    )
                horizontal_overlap = min(first.target[2], second.target[2]) - max(
                    first.target[0], second.target[0]
                )
                vertical_overlap = min(first.target[3], second.target[3]) - max(
                    first.target[1], second.target[1]
                )
                if horizontal_overlap > 0.001 and vertical_overlap > 0.001:
                    raise ContractError("paired placement targets must not overlap")
                if first.target[3] <= second.target[1]:
                    gutter = second.target[1] - first.target[3]
                elif second.target[3] <= first.target[1]:
                    gutter = first.target[1] - second.target[3]
                else:
                    raise ContractError("paired placements must be stacked vertically")
                if gutter < PAIR_GUTTER - 0.001:
                    raise ContractError(
                        f"paired placements must have at least a {PAIR_GUTTER:g}pt vertical gutter"
                    )
            result.append(validated_page)

        occurrences: dict[str, list[tuple[int, ValidPlacement, int]]] = {}
        for output_page, placements in enumerate(result):
            for placement in placements:
                occurrences.setdefault(placement.song_id, []).append(
                    (output_page, placement, len(placements))
                )
        for song_id, song_occurrences in occurrences.items():
            page_count = song_occurrences[0][1].source_page_count
            source_pages = [
                placement.source_page
                for _page, placement, _count in song_occurrences
            ]
            output_pages = [
                page for page, _placement, _count in song_occurrences
            ]
            if len(song_occurrences) != page_count or source_pages != list(range(page_count)):
                raise ContractError(
                    f"song must include every source page exactly once and in order: {song_id}"
                )
            if output_pages != list(
                range(output_pages[0], output_pages[0] + page_count)
            ):
                raise ContractError(
                    f"multi-page song must occupy consecutive output pages: {song_id}"
                )
            for _page, placement, placement_count in song_occurrences:
                full_source = all(
                    abs(left - right) <= 0.01
                    for left, right in zip(
                        placement.clip, placement.source_bounds, strict=True
                    )
                )
                if page_count > 1 and (placement_count != 1 or not full_source):
                    raise ContractError(
                        f"multi-page song pages must be full-page atomic placements: {song_id}"
                    )
                if page_count == 1 and placement_count == 1 and not full_source:
                    raise ContractError(
                        f"single-song output pages must use the whole source page: {song_id}"
                    )
    finally:
        for document in open_documents.values():
            document.close()
    return result


def export_plan(
    repo_root: pathlib.Path, plan: object, output_path: pathlib.Path
) -> ExportResultV1:
    root = repo_root.resolve()
    output = output_path if output_path.is_absolute() else root / output_path
    output = output.resolve()
    finished = (root / "compositions" / "finished").resolve()
    if output.is_relative_to(finished):
        raise ContractError("output path must not be beneath compositions/finished")
    pages = _validate_plan(root, plan)
    output.parent.mkdir(parents=True, exist_ok=True)

    source_documents: dict[pathlib.Path, pymupdf.Document] = {}
    destination = pymupdf.open()
    toc: list[list[int | str]] = []
    bookmarked: set[str] = set()
    temporary_path: pathlib.Path | None = None
    try:
        for page_index, placements in enumerate(pages):
            output_page = destination.new_page(width=PAGE_WIDTH, height=PAGE_HEIGHT)
            for placement in placements:
                source = source_documents.get(placement.path)
                if source is None:
                    source = pymupdf.open(placement.path)
                    source_documents[placement.path] = source
                source_page = source[placement.source_page]
                set_rotation = cast(_SetRotation, source_page.set_rotation)
                set_rotation(0)
                show_pdf_page = cast(_ShowPdfPage, output_page.show_pdf_page)
                _ = show_pdf_page(
                    pymupdf.Rect(placement.target),
                    source,
                    pno=placement.source_page,
                    clip=pymupdf.Rect(placement.clip),
                    keep_proportion=False,
                    overlay=True,
                    rotate=placement.rotation,
                )
                if placement.song_id not in bookmarked:
                    toc.append([1, placement.title, page_index + 1])
                    bookmarked.add(placement.song_id)
        if toc:
            set_toc = cast(_SetToc, destination.set_toc)
            _ = set_toc(toc)
        file_descriptor, temporary_name = tempfile.mkstemp(
            prefix=f".{output.name}.", suffix=".tmp", dir=output.parent
        )
        os.close(file_descriptor)
        temporary_path = pathlib.Path(temporary_name)
        save_document = cast(_SaveDocument, destination.save)
        save_document(temporary_path, garbage=4, deflate=True)
        os.replace(temporary_path, output)
        temporary_path = None
    except (OSError, RuntimeError, ValueError) as error:
        if isinstance(error, ContractError):
            raise
        raise ContractError(f"could not export {output}: {error}") from error
    finally:
        destination.close()
        for document in source_documents.values():
            document.close()
        if temporary_path is not None:
            temporary_path.unlink(missing_ok=True)

    return {
        "schemaVersion": 1,
        "output": output.relative_to(root).as_posix()
        if output.is_relative_to(root)
        else str(output),
        "pageCount": len(pages),
    }
