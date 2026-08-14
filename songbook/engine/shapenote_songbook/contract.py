from __future__ import annotations

import math
from typing import Literal, NotRequired, TypedDict, cast

SCHEMA_VERSION: Literal[1] = 1
PAGE_WIDTH = 841.89
PAGE_HEIGHT = 595.28
PAGE_SIZE_TOLERANCE = 2.0
OUTER_MARGIN = 24.0
PAIR_GUTTER = 12.0
CROP_PADDING = 8.0
MIN_PAIR_SCALE = 0.90

Rotation = Literal[0, 90, 180, 270]
Rectangle = list[float]
UnitKind = Literal["pair", "multiPage", "single"]


class ScannedPageV1(TypedDict):
    index: int
    rotation: NotRequired[Rotation]
    mediaBounds: Rectangle
    sourceBounds: NotRequired[Rectangle]
    occupiedBounds: Rectangle
    sourceOccupiedBounds: NotRequired[Rectangle]
    landscapeA4: bool


class SongV1(TypedDict):
    id: str
    title: str
    sourcePath: str
    fingerprint: str
    pageCount: int
    pages: list[ScannedPageV1]


class ScanV1(TypedDict):
    schemaVersion: Literal[1]
    songs: list[SongV1]
    warnings: list[str]


class LayoutV1(TypedDict):
    schemaVersion: Literal[1]
    exclusions: list[str]
    forceFullPage: list[str]
    pairs: list[list[str]]
    unpaired: list[str]
    order: list[list[str]]
    fingerprints: dict[str, str]


class PlacementV1(TypedDict):
    songId: str
    title: str
    sourcePath: str
    fingerprint: str
    sourcePage: int
    rotation: Rotation
    clip: Rectangle
    target: Rectangle
    scale: float


class PlanPageV1(TypedDict):
    index: int
    placements: list[PlacementV1]


class PlanUnitV1(TypedDict):
    songIds: list[str]
    kind: UnitKind
    forced: bool
    pageIndexes: list[int]


class PlanV1(TypedDict):
    schemaVersion: Literal[1]
    pageSize: list[float]
    units: list[PlanUnitV1]
    pages: list[PlanPageV1]
    layout: LayoutV1
    warnings: list[str]


class ExportResultV1(TypedDict):
    schemaVersion: Literal[1]
    output: str
    pageCount: int


class ContractError(ValueError):
    """Raised when versioned songbook JSON is invalid."""


def require_mapping(value: object, name: str) -> dict[str, object]:
    if not isinstance(value, dict):
        raise ContractError(f"{name} must be a JSON object")
    raw = cast(dict[object, object], value)
    result: dict[str, object] = {}
    for key, item in raw.items():
        if not isinstance(key, str):
            raise ContractError(f"{name} must have string keys")
        result[key] = item
    return result


def require_object(value: object, name: str) -> dict[str, object]:
    result = require_mapping(value, name)
    if result.get("schemaVersion") != SCHEMA_VERSION:
        raise ContractError(f"{name}.schemaVersion must be {SCHEMA_VERSION}")
    return result


def require_string(value: object, name: str) -> str:
    if not isinstance(value, str):
        raise ContractError(f"{name} must be a string")
    return value


def require_string_list(value: object, name: str, *, unique: bool = True) -> list[str]:
    if value is None:
        return []
    if not isinstance(value, list):
        raise ContractError(f"{name} must be an array of song IDs")
    raw = cast(list[object], value)
    result: list[str] = []
    for item in raw:
        if not isinstance(item, str):
            raise ContractError(f"{name} must be an array of song IDs")
        result.append(item)
    if unique and len(result) != len(set(result)):
        raise ContractError(f"{name} contains duplicate song IDs")
    return result


def rect(value: object, name: str) -> Rectangle:
    if not isinstance(value, list):
        raise ContractError(f"{name} must be a four-number rectangle")
    raw = cast(list[object], value)
    if len(raw) != 4:
        raise ContractError(f"{name} must be a four-number rectangle")
    result: Rectangle = []
    for number in raw:
        if (
            not isinstance(number, (int, float))
            or isinstance(number, bool)
            or not math.isfinite(number)
        ):
            raise ContractError(f"{name} must be a four-number rectangle")
        result.append(float(number))
    if result[0] >= result[2] or result[1] >= result[3]:
        raise ContractError(f"{name} must have positive width and height")
    return result
