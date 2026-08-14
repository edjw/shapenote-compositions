from __future__ import annotations

import pathlib
from typing import Literal, Protocol, TypedDict, cast

import pymupdf

Coordinates = list[float] | tuple[float, ...]


class TextSpan(TypedDict):
    text: str
    bbox: Coordinates


class TextLine(TypedDict):
    spans: list[TextSpan]
    bbox: Coordinates
    dir: Coordinates


class TextBlock(TypedDict, total=False):
    lines: list[TextLine]


class TextDictionary(TypedDict):
    blocks: list[TextBlock]


class _InsertText(Protocol):
    def __call__(
        self, point: object, text: str, *, fontsize: float = 11
    ) -> int: ...


class _SaveDocument(Protocol):
    def __call__(self, filename: object) -> None: ...


class _SetMetadata(Protocol):
    def __call__(self, metadata: dict[str, str]) -> None: ...


class _AddRectAnnotation(Protocol):
    def __call__(self, rect: object) -> object: ...


class _SetRotation(Protocol):
    def __call__(self, rotation: int) -> None: ...


class _GetPlainText(Protocol):
    def __call__(self) -> str: ...


class _GetTextDictionary(Protocol):
    def __call__(self, option: Literal["dict"]) -> TextDictionary: ...


class _GetToc(Protocol):
    def __call__(self) -> list[list[int | float | str]]: ...


class _RectView(Protocol):
    @property
    def x0(self) -> float: ...

    @property
    def y0(self) -> float: ...

    @property
    def x1(self) -> float: ...

    @property
    def y1(self) -> float: ...


def insert_text(
    page: pymupdf.Page,
    point: tuple[float, float],
    text: str,
    *,
    fontsize: float = 11,
) -> None:
    operation = cast(_InsertText, page.insert_text)
    _ = operation(point, text, fontsize=fontsize)


def save_document(document: pymupdf.Document, path: pathlib.Path) -> None:
    operation = cast(_SaveDocument, document.save)
    operation(path)


def set_metadata(document: pymupdf.Document, metadata: dict[str, str]) -> None:
    operation = cast(_SetMetadata, document.set_metadata)
    operation(metadata)


def add_rect_annotation(page: pymupdf.Page, rect: pymupdf.Rect) -> None:
    operation = cast(_AddRectAnnotation, page.add_rect_annot)
    _ = operation(rect)


def set_rotation(page: pymupdf.Page, rotation: int) -> None:
    operation = cast(_SetRotation, page.set_rotation)
    operation(rotation)


def page_text(page: pymupdf.Page) -> str:
    operation = cast(_GetPlainText, page.get_text)
    return operation()


def text_dictionary(page: pymupdf.Page) -> TextDictionary:
    operation = cast(_GetTextDictionary, page.get_text)
    return operation("dict")


def table_of_contents(document: pymupdf.Document) -> list[list[int | float | str]]:
    operation = cast(_GetToc, document.get_toc)
    return operation()


def rect_contains(outer: pymupdf.Rect, inner: pymupdf.Rect) -> bool:
    outer_bounds = cast(_RectView, outer)
    inner_bounds = cast(_RectView, inner)
    return (
        outer_bounds.x0 <= inner_bounds.x0
        and outer_bounds.y0 <= inner_bounds.y0
        and outer_bounds.x1 >= inner_bounds.x1
        and outer_bounds.y1 >= inner_bounds.y1
    )
