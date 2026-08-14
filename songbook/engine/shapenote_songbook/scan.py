from __future__ import annotations

import hashlib
import pathlib
import re
from typing import Protocol, cast

import pymupdf

from .contract import (
    PAGE_HEIGHT,
    PAGE_SIZE_TOLERANCE,
    PAGE_WIDTH,
    ContractError,
    Rotation,
    ScanV1,
    ScannedPageV1,
    SongV1,
    require_mapping,
)

ANALYSIS_SCALE = 2.0
WHITE_THRESHOLD = 245
_THRESHOLD_TABLE = bytes(1 if value < WHITE_THRESHOLD else 0 for value in range(256))


class _GetPixmap(Protocol):
    def __call__(
        self,
        *,
        matrix: object,
        colorspace: object,
        alpha: bool,
        annots: bool,
    ) -> object: ...


class _PixmapView(Protocol):
    @property
    def samples(self) -> bytes: ...

    @property
    def stride(self) -> int: ...

    @property
    def width(self) -> int: ...

    @property
    def height(self) -> int: ...


class _RectView(Protocol):
    @property
    def x0(self) -> float: ...

    @property
    def y0(self) -> float: ...

    @property
    def x1(self) -> float: ...

    @property
    def y1(self) -> float: ...



def _relative(path: pathlib.Path, root: pathlib.Path) -> str:
    try:
        return path.relative_to(root).as_posix()
    except ValueError as error:
        raise ContractError(f"path is outside repository: {path}") from error


def _ignored_paths(repo_root: pathlib.Path) -> set[str]:
    path = repo_root / ".pdfignore"
    if not path.is_file():
        return set()
    return {
        line
        for raw_line in path.read_text(encoding="utf-8", errors="strict").splitlines()
        if (line := raw_line.strip()) and not line.startswith("#")
    }


def discover_pdfs(repo_root: pathlib.Path) -> list[pathlib.Path]:
    root = repo_root.resolve()
    finished = (root / "compositions" / "finished").resolve()
    if not finished.is_dir():
        raise ContractError(f"finished compositions directory does not exist: {_relative(finished, root)}")
    ignored = _ignored_paths(root)
    result: list[pathlib.Path] = []
    for candidate in sorted(finished.rglob("*.pdf")):
        resolved = candidate.resolve()
        try:
            _ = resolved.relative_to(finished)
        except ValueError as error:
            raise ContractError(f"PDF resolves outside compositions/finished: {_relative(candidate, root)}") from error
        source_path = _relative(candidate, root)
        if source_path not in ignored and resolved.is_file():
            result.append(candidate)
    return result


def _visible_bounds(page: pymupdf.Page) -> list[float] | None:
    get_pixmap = cast(_GetPixmap, page.get_pixmap)
    pixmap = cast(
        _PixmapView,
        get_pixmap(
            matrix=pymupdf.Matrix(ANALYSIS_SCALE, ANALYSIS_SCALE),
            colorspace=pymupdf.csGRAY,
            alpha=False,
            annots=False,
        ),
    )
    mask = pixmap.samples.translate(_THRESHOLD_TABLE)
    first = mask.find(b"\x01")
    if first < 0:
        return None
    last = mask.rfind(b"\x01")
    top = first // pixmap.stride
    bottom = last // pixmap.stride
    left = pixmap.width
    right = -1
    for row_index in range(top, bottom + 1):
        row = mask[row_index * pixmap.stride : row_index * pixmap.stride + pixmap.width]
        row_left = row.find(b"\x01")
        if row_left < 0:
            continue
        left = min(left, row_left)
        right = max(right, row.rfind(b"\x01"))
    # Expand by one analysis pixel so antialiasing and pixel rounding never trim ink.
    page_rect = cast(_RectView, page.rect)
    x_scale = (page_rect.x1 - page_rect.x0) / pixmap.width
    y_scale = (page_rect.y1 - page_rect.y0) / pixmap.height
    return [
        round(max(page_rect.x0, (left - 1) * x_scale), 4),
        round(max(page_rect.y0, (top - 1) * y_scale), 4),
        round(min(page_rect.x1, (right + 2) * x_scale), 4),
        round(min(page_rect.y1, (bottom + 2) * y_scale), 4),
    ]


def _rect_list(value: pymupdf.Rect) -> list[float]:
    rect = cast(_RectView, value)
    return [round(rect.x0, 4), round(rect.y0, 4), round(rect.x1, 4), round(rect.y1, 4)]


def _media_bounds(page: pymupdf.Page) -> list[float]:
    return _rect_list(page.rect)


def _source_bounds(page: pymupdf.Page, display_bounds: list[float]) -> list[float]:
    return _rect_list(pymupdf.Rect(display_bounds) * page.derotation_matrix)


def _is_landscape_a4(bounds: list[float]) -> bool:
    return abs((bounds[2] - bounds[0]) - PAGE_WIDTH) <= PAGE_SIZE_TOLERANCE and abs(
        (bounds[3] - bounds[1]) - PAGE_HEIGHT
    ) <= PAGE_SIZE_TOLERANCE


def _fallback_title(pdf_path: pathlib.Path) -> str:
    stem = re.sub(r"(?:[-_]\d{1,2}[-.]\d{1,2}[-.]\d{2,4})$", "", pdf_path.stem)
    return re.sub(r"[-_]+", " ", stem).strip().title() or pdf_path.stem


def _page_rotation(page: pymupdf.Page, source_path: str) -> Rotation:
    value = cast(int, page.rotation)
    if value not in (0, 90, 180, 270):
        raise ContractError(f"source page has unsupported rotation: {source_path}")
    return value


def _metadata_title(document: pymupdf.Document) -> str:
    metadata = require_mapping(cast(object, document.metadata or {}), "PDF metadata")
    title = metadata.get("title", "")
    return title.strip() if isinstance(title, str) else ""


def _scan_pdf(pdf_path: pathlib.Path, repo_root: pathlib.Path, warnings: list[str]) -> SongV1:
    source_path = _relative(pdf_path, repo_root)
    try:
        fingerprint = hashlib.sha256(pdf_path.read_bytes()).hexdigest()
        with pymupdf.open(pdf_path) as document:
            if cast(bool, document.needs_pass):
                raise ContractError(f"encrypted PDF is not supported: {source_path}")
            page_count = cast(int, document.page_count)
            if page_count < 1:
                raise ContractError(f"PDF has no pages: {source_path}")
            metadata_title = _metadata_title(document)
            pages: list[ScannedPageV1] = []
            for index in range(page_count):
                page = document[index]
                media = _media_bounds(page)
                if not _is_landscape_a4(media):
                    raise ContractError(
                        f"source page must be landscape A4: {source_path} page {index + 1}"
                    )
                source_bounds = _source_bounds(page, media)
                occupied = _visible_bounds(page)
                if occupied is None:
                    occupied = media
                    warnings.append(f"no visible ink on {source_path} page {index + 1}; using full media bounds")
                pages.append(
                    {
                        "index": index,
                        "rotation": _page_rotation(page, source_path),
                        "mediaBounds": media,
                        "sourceBounds": source_bounds,
                        "occupiedBounds": occupied,
                        "sourceOccupiedBounds": _source_bounds(page, occupied),
                        "landscapeA4": _is_landscape_a4(media),
                    }
                )
    except ContractError:
        raise
    except (OSError, RuntimeError, ValueError) as error:
        raise ContractError(f"could not scan PDF {source_path}: {error}") from error

    return {
        "id": source_path,
        "title": metadata_title or _fallback_title(pdf_path),
        "sourcePath": source_path,
        "fingerprint": fingerprint,
        "pageCount": len(pages),
        "pages": pages,
    }


def scan_repository(repo_root: pathlib.Path) -> ScanV1:
    root = repo_root.resolve()
    warnings: list[str] = []
    songs = [_scan_pdf(pdf_path, root, warnings) for pdf_path in discover_pdfs(root)]
    return {"schemaVersion": 1, "songs": songs, "warnings": warnings}
