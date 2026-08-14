from __future__ import annotations

from dataclasses import dataclass
from typing import Literal, cast

from .contract import (
    CROP_PADDING,
    MIN_PAIR_SCALE,
    OUTER_MARGIN,
    PAGE_HEIGHT,
    PAGE_WIDTH,
    PAIR_GUTTER,
    ContractError,
    LayoutV1,
    PlacementV1,
    PlanPageV1,
    PlanUnitV1,
    PlanV1,
    Rectangle,
    Rotation,
    ScannedPageV1,
    SongV1,
    UnitKind,
    rect,
    require_mapping,
    require_object,
    require_string,
    require_string_list,
)


@dataclass(frozen=True)
class Unit:
    song_ids: tuple[str, ...]
    forced_pair: bool = False


def _required_int(value: object, name: str) -> int:
    if not isinstance(value, int) or isinstance(value, bool):
        raise ContractError(f"{name} must be an integer")
    return value


def _rotation_value(value: object, song_id: str) -> Rotation:
    if (
        not isinstance(value, int)
        or isinstance(value, bool)
        or value not in (0, 90, 180, 270)
    ):
        raise ContractError(f"{song_id} rotation must be 0, 90, 180, or 270")
    return value


def _scanned_page(value: object, song_id: str, index: int) -> ScannedPageV1:
    page = require_mapping(value, f"song {song_id} page {index}")
    if _required_int(page.get("index"), f"song {song_id} page index") != index:
        raise ContractError(f"song {song_id} has an invalid page index")
    result: ScannedPageV1 = {
        "index": index,
        "rotation": _rotation_value(page.get("rotation", 0), song_id),
        "mediaBounds": rect(page.get("mediaBounds"), f"{song_id} mediaBounds"),
        "occupiedBounds": rect(page.get("occupiedBounds"), f"{song_id} occupiedBounds"),
        "landscapeA4": page.get("landscapeA4") is True,
    }
    if "sourceBounds" in page:
        result["sourceBounds"] = rect(page["sourceBounds"], f"{song_id} sourceBounds")
    if "sourceOccupiedBounds" in page:
        result["sourceOccupiedBounds"] = rect(
            page["sourceOccupiedBounds"], f"{song_id} sourceOccupiedBounds"
        )
    return result


def _song(value: object, index: int) -> SongV1:
    raw = require_mapping(value, f"scan.songs[{index}]")
    song_id = require_string(raw.get("id"), f"scan.songs[{index}].id")
    page_count = _required_int(raw.get("pageCount"), f"song {song_id} pageCount")
    raw_pages = raw.get("pages")
    if not isinstance(raw_pages, list):
        raise ContractError(f"song {song_id} pages must be an array")
    pages = [
        _scanned_page(page, song_id, page_index)
        for page_index, page in enumerate(cast(list[object], raw_pages))
    ]
    if page_count != len(pages):
        raise ContractError(f"song {song_id} has inconsistent pageCount")
    if not pages:
        raise ContractError(f"song {song_id} has no pages")
    return {
        "id": song_id,
        "title": require_string(raw.get("title"), f"song {song_id} title"),
        "sourcePath": require_string(raw.get("sourcePath"), f"song {song_id} sourcePath"),
        "fingerprint": require_string(raw.get("fingerprint"), f"song {song_id} fingerprint"),
        "pageCount": page_count,
        "pages": pages,
    }


def _songs(scan: object) -> tuple[dict[str, SongV1], list[str], list[str]]:
    raw_scan = require_object(scan, "scan")
    raw_songs = raw_scan.get("songs")
    if not isinstance(raw_songs, list):
        raise ContractError("scan.songs must be an array")
    songs: dict[str, SongV1] = {}
    order: list[str] = []
    for index, raw_song in enumerate(cast(list[object], raw_songs)):
        song = _song(raw_song, index)
        song_id = song["id"]
        if song_id in songs:
            raise ContractError(f"duplicate song ID: {song_id}")
        songs[song_id] = song
        order.append(song_id)
    warnings = require_string_list(
        raw_scan.get("warnings"), "scan.warnings", unique=False
    )
    return songs, order, warnings


def _pairs(value: object) -> list[tuple[str, str]]:
    if value is None:
        return []
    if not isinstance(value, list):
        raise ContractError("layout.pairs must be an array")
    result: list[tuple[str, str]] = []
    seen: set[str] = set()
    for index, raw_pair in enumerate(cast(list[object], value)):
        if not isinstance(raw_pair, list):
            raise ContractError(f"layout.pairs[{index}] must contain exactly two song IDs")
        pair = cast(list[object], raw_pair)
        if len(pair) != 2 or not isinstance(pair[0], str) or not isinstance(pair[1], str):
            raise ContractError(f"layout.pairs[{index}] must contain exactly two song IDs")
        left = pair[0]
        right = pair[1]
        if left == right or left in seen or right in seen:
            raise ContractError("a song may occur in at most one explicit pair")
        seen.update((left, right))
        result.append((left, right))
    return result


def _fingerprints(value: object) -> dict[str, str]:
    if value is None:
        return {}
    raw = require_mapping(value, "layout.fingerprints")
    result: dict[str, str] = {}
    for song_id, fingerprint in raw.items():
        result[song_id] = require_string(
            fingerprint, f"layout.fingerprints[{song_id}]"
        )
    return result


def _rotation(page: ScannedPageV1, song_id: str) -> Rotation:
    return _rotation_value(page.get("rotation", 0), song_id)


def _source_rect(
    page: ScannedPageV1,
    key: Literal["sourceBounds", "sourceOccupiedBounds"],
    fallback: Literal["mediaBounds", "occupiedBounds"],
) -> Rectangle:
    return page.get(key, page[fallback])


def _padded_crop(song: SongV1) -> Rectangle:
    page = song["pages"][0]
    media = _source_rect(page, "sourceBounds", "mediaBounds")
    occupied = _source_rect(page, "sourceOccupiedBounds", "occupiedBounds")
    return [
        max(media[0], occupied[0] - CROP_PADDING),
        max(media[1], occupied[1] - CROP_PADDING),
        min(media[2], occupied[2] + CROP_PADDING),
        min(media[3], occupied[3] + CROP_PADDING),
    ]


def _display_size(
    page: ScannedPageV1, source_rect: Rectangle, song_id: str
) -> tuple[float, float]:
    width = source_rect[2] - source_rect[0]
    height = source_rect[3] - source_rect[1]
    if _rotation(page, song_id) in (90, 270):
        return height, width
    return width, height


def _pair_scale(left: SongV1, right: SongV1) -> float:
    crops = [_padded_crop(left), _padded_crop(right)]
    sizes = [
        _display_size(song["pages"][0], crop, song["id"])
        for song, crop in zip((left, right), crops, strict=True)
    ]
    widths = [size[0] for size in sizes]
    heights = [size[1] for size in sizes]
    available_width = PAGE_WIDTH - 2 * OUTER_MARGIN
    available_height = PAGE_HEIGHT - 2 * OUTER_MARGIN - PAIR_GUTTER
    return min(1.0, available_width / max(widths), available_height / sum(heights))


def _automatic_units(
    song_ids: list[str], songs: dict[str, SongV1], singles: set[str]
) -> list[Unit]:
    available_width = PAGE_WIDTH - 2 * OUTER_MARGIN
    available_height = PAGE_HEIGHT - 2 * OUTER_MARGIN - PAIR_GUTTER
    maximum_pair_height = available_height / MIN_PAIR_SCALE
    measured: list[tuple[float, str]] = []
    for song_id in song_ids:
        if songs[song_id]["pageCount"] != 1 or song_id in singles:
            continue
        crop = _padded_crop(songs[song_id])
        width, height = _display_size(
            songs[song_id]["pages"][0], crop, song_id
        )
        if available_width / width >= MIN_PAIR_SCALE:
            measured.append((height, song_id))

    # Pair the shortest remaining crop with the fullest one it can accommodate.
    # Since feasibility is an individual width limit plus a height-sum limit, this
    # two-pointer matching maximises pair count. Height and stable ID break ties.
    measured.sort()
    pairs: dict[str, Unit] = {}
    shortest = 0
    fullest = len(measured) - 1
    while shortest < fullest:
        short_height, short_id = measured[shortest]
        full_height, full_id = measured[fullest]
        if short_height + full_height <= maximum_pair_height:
            unit = Unit((short_id, full_id))
            pairs[short_id] = unit
            pairs[full_id] = unit
            shortest += 1
            fullest -= 1
        else:
            fullest -= 1

    units: list[Unit] = []
    emitted: set[str] = set()
    for song_id in song_ids:
        if song_id in emitted:
            continue
        unit = pairs.get(song_id, Unit((song_id,)))
        units.append(unit)
        emitted.update(unit.song_ids)
    return units


def _apply_order(
    units: list[Unit],
    value: object,
    warnings: list[str],
    stale_ids: set[str],
    missing_fingerprint_ids: set[str],
) -> list[Unit]:
    if value is None:
        return units
    if not isinstance(value, list):
        raise ContractError("layout.order must be an array of atomic song-ID arrays")
    by_song = {song_id: unit for unit in units for song_id in unit.song_ids}
    ordered: list[Unit] = []
    emitted: set[Unit] = set()
    for index, raw_unit in enumerate(cast(list[object], value)):
        if not isinstance(raw_unit, list):
            raise ContractError(f"layout.order[{index}] must be a non-empty song-ID array")
        raw_items = cast(list[object], raw_unit)
        if not raw_items or any(not isinstance(item, str) for item in raw_items):
            raise ContractError(f"layout.order[{index}] must be a non-empty song-ID array")
        song_ids = [cast(str, item) for item in raw_items]
        present = [song_id for song_id in song_ids if song_id in by_song]
        missing = [song_id for song_id in song_ids if song_id not in by_song]
        warnings.extend(
            f"ordered song is missing or excluded: {song_id}" for song_id in missing
        )
        if not present:
            continue
        unit = by_song[present[0]]
        if set(present) != set(unit.song_ids):
            if (
                missing
                or not unit.forced_pair
                or (set(song_ids) | set(unit.song_ids)) & stale_ids
                or missing_fingerprint_ids
            ):
                warnings.append(
                    f"stale ordered unit dropped because its pairing changed: {', '.join(song_ids)}"
                )
                continue
            raise ContractError(
                f"layout.order[{index}] splits pair; pairs must move atomically"
            )
        if unit in emitted:
            raise ContractError("layout.order contains a song more than once")
        ordered.append(unit)
        emitted.add(unit)
    ordered.extend(unit for unit in units if unit not in emitted)
    return ordered


def _target_for_clip(
    clip: Rectangle, page: ScannedPageV1, song_id: str
) -> tuple[Rectangle, float]:
    width, height = _display_size(page, clip, song_id)
    scale = min(
        1.0,
        (PAGE_WIDTH - 2 * OUTER_MARGIN) / width,
        (PAGE_HEIGHT - 2 * OUTER_MARGIN) / height,
    )
    target_width, target_height = width * scale, height * scale
    x = (PAGE_WIDTH - target_width) / 2
    y = (PAGE_HEIGHT - target_height) / 2
    return [x, y, x + target_width, y + target_height], scale


def _placement(
    song: SongV1,
    source_page: int,
    clip: Rectangle,
    target: Rectangle,
    scale: float,
) -> PlacementV1:
    page = song["pages"][source_page]
    return {
        "songId": song["id"],
        "title": song["title"],
        "sourcePath": song["sourcePath"],
        "fingerprint": song["fingerprint"],
        "sourcePage": source_page,
        "rotation": _rotation(page, song["id"]),
        "clip": [round(number, 4) for number in clip],
        "target": [round(number, 4) for number in target],
        "scale": round(scale, 6),
    }


def _pages_for_unit(
    unit: Unit, songs: dict[str, SongV1]
) -> list[list[PlacementV1]]:
    if len(unit.song_ids) == 2:
        left, right = (songs[song_id] for song_id in unit.song_ids)
        crops = [_padded_crop(left), _padded_crop(right)]
        scale = _pair_scale(left, right)
        if scale < MIN_PAIR_SCALE and not unit.forced_pair:
            raise ContractError("automatic pair is below the minimum common scale")
        if scale < MIN_PAIR_SCALE:
            raise ContractError(
                f"explicit pair {left['id']}, {right['id']} is below minimum common scale {MIN_PAIR_SCALE:.2f}"
            )
        sizes = [
            _display_size(song["pages"][0], crop, song["id"])
            for song, crop in zip((left, right), crops, strict=True)
        ]
        heights = [size[1] * scale for size in sizes]
        group_height = sum(heights) + PAIR_GUTTER
        y = (PAGE_HEIGHT - group_height) / 2
        placements: list[PlacementV1] = []
        for song, crop, size, height in zip(
            (left, right), crops, sizes, heights, strict=True
        ):
            width = size[0] * scale
            x = (PAGE_WIDTH - width) / 2
            target = [x, y, x + width, y + height]
            placements.append(_placement(song, 0, crop, target, scale))
            y += height + PAIR_GUTTER
        return [placements]

    song = songs[unit.song_ids[0]]
    result: list[list[PlacementV1]] = []
    for source_page, page in enumerate(song["pages"]):
        clip = _source_rect(page, "sourceBounds", "mediaBounds")
        target, scale = _target_for_clip(clip, page, song["id"])
        result.append([_placement(song, source_page, clip, target, scale)])
    return result


def build_plan(scan: object, layout: object | None = None) -> PlanV1:
    songs, source_order, warnings = _songs(scan)
    raw_layout = require_object(layout or {"schemaVersion": 1}, "layout")
    exclusions = set(
        require_string_list(raw_layout.get("exclusions"), "layout.exclusions")
    )
    force_full = set(
        require_string_list(raw_layout.get("forceFullPage"), "layout.forceFullPage")
    )
    unpaired = set(
        require_string_list(raw_layout.get("unpaired"), "layout.unpaired")
    )
    explicit_pairs = _pairs(raw_layout.get("pairs"))

    known = set(songs)
    for name, values in (
        ("excluded", exclusions),
        ("force-full", force_full),
        ("unpaired", unpaired),
    ):
        for song_id in sorted(values - known):
            warnings.append(f"{name} song is missing: {song_id}")
    exclusions &= known
    force_full &= known
    unpaired &= known

    fingerprints = {
        song_id: songs[song_id]["fingerprint"] for song_id in source_order
    }
    old_fingerprints = _fingerprints(raw_layout.get("fingerprints"))
    changed_ids: set[str] = set()
    stale_ids: set[str] = set()
    missing_fingerprint_ids: set[str] = set()
    if old_fingerprints:
        changed_ids = {
            song_id
            for song_id in known & old_fingerprints.keys()
            if old_fingerprints[song_id] != fingerprints[song_id]
        }
        missing_fingerprint_ids = set(old_fingerprints) - known
        stale_ids = changed_ids | (known - old_fingerprints.keys()) | missing_fingerprint_ids
        warnings.extend(
            f"song changed since layout was saved: {song_id}"
            for song_id in sorted(changed_ids)
        )
        warnings.extend(
            f"song from saved layout is missing: {song_id}"
            for song_id in sorted(missing_fingerprint_ids)
        )

    pair_members: set[str] = set()
    valid_pairs: list[tuple[str, str]] = []
    for left, right in explicit_pairs:
        missing = [song_id for song_id in (left, right) if song_id not in songs]
        if missing:
            warnings.append(
                f"explicit pair dropped because song is missing: {', '.join(missing)}"
            )
            continue
        if left in exclusions or right in exclusions:
            raise ContractError("an excluded song cannot be explicitly paired")
        if left in force_full or right in force_full or left in unpaired or right in unpaired:
            raise ContractError(
                "force-full/unpaired overrides conflict with an explicit pair"
            )
        if songs[left]["pageCount"] != 1 or songs[right]["pageCount"] != 1:
            if {left, right} & changed_ids:
                warnings.append(
                    f"explicit pair dropped because a changed song is no longer one-page: {left}, {right}"
                )
                continue
            raise ContractError("only one-page songs may be paired")
        if _pair_scale(songs[left], songs[right]) < MIN_PAIR_SCALE:
            if {left, right} & changed_ids:
                warnings.append(
                    f"explicit pair dropped because changed measurements no longer fit: {left}, {right}"
                )
                continue
            raise ContractError(
                f"explicit pair {left}, {right} is below minimum common scale {MIN_PAIR_SCALE:.2f}"
            )
        valid_pairs.append((left, right))
        pair_members.update((left, right))

    included = [song_id for song_id in source_order if song_id not in exclusions]
    automatic = _automatic_units(
        included, songs, force_full | unpaired | pair_members
    )
    by_song = {
        song_id: unit for unit in automatic for song_id in unit.song_ids
    }
    for left, right in valid_pairs:
        unit = Unit((left, right), forced_pair=True)
        by_song[left] = unit
        by_song[right] = unit
    units: list[Unit] = []
    emitted_ids: set[str] = set()
    for song_id in included:
        if song_id in emitted_ids:
            continue
        unit = by_song[song_id]
        units.append(unit)
        emitted_ids.update(unit.song_ids)
    units = _apply_order(
        units,
        raw_layout.get("order"),
        warnings,
        stale_ids,
        missing_fingerprint_ids,
    )

    plan_pages: list[PlanPageV1] = []
    plan_units: list[PlanUnitV1] = []
    for unit in units:
        page_indexes: list[int] = []
        for placements in _pages_for_unit(unit, songs):
            page_index = len(plan_pages)
            page_indexes.append(page_index)
            plan_pages.append({"index": page_index, "placements": placements})
        kind: UnitKind = (
            "pair"
            if len(unit.song_ids) == 2
            else (
                "multiPage"
                if songs[unit.song_ids[0]]["pageCount"] > 1
                else "single"
            )
        )
        plan_units.append(
            {
                "songIds": list(unit.song_ids),
                "kind": kind,
                "forced": unit.forced_pair
                or any(
                    song_id in force_full or song_id in unpaired
                    for song_id in unit.song_ids
                ),
                "pageIndexes": page_indexes,
            }
        )

    normalized_layout: LayoutV1 = {
        "schemaVersion": 1,
        "exclusions": sorted(exclusions),
        "forceFullPage": sorted(force_full),
        "pairs": [list(pair) for pair in valid_pairs],
        "unpaired": sorted(unpaired),
        "order": [list(unit.song_ids) for unit in units],
        "fingerprints": fingerprints,
    }
    return {
        "schemaVersion": 1,
        "pageSize": [PAGE_WIDTH, PAGE_HEIGHT],
        "units": plan_units,
        "pages": plan_pages,
        "layout": normalized_layout,
        "warnings": warnings,
    }


__all__ = ["ContractError", "build_plan"]
