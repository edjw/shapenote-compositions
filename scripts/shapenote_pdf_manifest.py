#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import pathlib
import re
import sys
from dataclasses import dataclass

MONTH_NUMBERS = {
    "january": "01",
    "february": "02",
    "march": "03",
    "april": "04",
    "may": "05",
    "june": "06",
    "july": "07",
    "august": "08",
    "september": "09",
    "october": "10",
    "november": "11",
    "december": "12",
}

MONTH_NAMES = {number: name.title() for name, number in MONTH_NUMBERS.items()}
MONTH_PATTERN = "|".join(MONTH_NUMBERS.keys())
COMPOSER_PATTERN = re.compile(r'^\s*songComposer\s*=\s*"([^"]*)"', re.MULTILINE)
DATE_PATTERN = re.compile(
    rf"\b(?:\d{{1,2}}\s+)?((?:{MONTH_PATTERN})(?:\s*(?:\+|&|and|/|-)\s*(?:{MONTH_PATTERN}))*)\s+((?:19|20)\d{{2}})\b",
    re.IGNORECASE,
)


@dataclass(frozen=True)
class CompositionMetadata:
    composition_month: str
    display_date: str
    filename_date: str


def repo_path(path: pathlib.Path, repo_root: pathlib.Path) -> str:
    return path.relative_to(repo_root).as_posix()


def ignored_paths(repo_root: pathlib.Path) -> set[str]:
    ignore_file = repo_root / ".pdfignore"
    if not ignore_file.is_file():
        return set()

    ignored = set()
    for line in ignore_file.read_text(encoding="utf-8", errors="ignore").splitlines():
        line = line.strip()
        if line and not line.startswith("#"):
            ignored.add(line)
    return ignored


def date_overrides(repo_root: pathlib.Path) -> dict[str, str]:
    override_file = repo_root / ".pdfdates"
    if not override_file.is_file():
        return {}

    overrides = {}
    for line in override_file.read_text(encoding="utf-8", errors="ignore").splitlines():
        line = line.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue

        path, date = (part.strip() for part in line.split("=", 1))
        if re.fullmatch(r"\d{4}-\d{2}-\d{2}", date):
            overrides[path] = date
    return overrides


def display_date(month_numbers: list[str], year: str) -> str:
    months = [MONTH_NAMES[number] for number in month_numbers]
    if len(months) == 1:
        return f"{months[0]} {year}"
    if len(months) == 2:
        return f"{months[0]} & {months[1]} {year}"

    return f"{', '.join(months[:-1])} & {months[-1]} {year}"


def metadata_from_date(year: str, month_number: str) -> CompositionMetadata:
    return CompositionMetadata(
        composition_month=f"{year}-{month_number}",
        display_date=display_date([month_number], year),
        filename_date=f"{year}-{month_number}-01",
    )


def parse_composer_metadata(text: str) -> CompositionMetadata | None:
    composer_match = COMPOSER_PATTERN.search(text)
    if not composer_match:
        return None

    matches = list(DATE_PATTERN.finditer(composer_match.group(1)))
    if not matches:
        return None

    match = matches[-1]
    month_names = re.findall(MONTH_PATTERN, match.group(1), re.IGNORECASE)
    month_numbers = [MONTH_NUMBERS[name.lower()] for name in month_names]
    if not month_numbers:
        return None

    year = match.group(2)
    first_month = month_numbers[0]
    return CompositionMetadata(
        composition_month=f"{year}-{first_month}",
        display_date=display_date(month_numbers, year),
        filename_date=f"{year}-{first_month}-01",
    )


def ly_candidates(pdf_path: pathlib.Path) -> list[pathlib.Path]:
    matching_stem = pdf_path.with_suffix(".ly")
    if matching_stem.is_file():
        return [matching_stem]

    return sorted(pdf_path.parent.glob("*.ly"))


def metadata_for_pdf(
    pdf_path: pathlib.Path,
    repo_root: pathlib.Path,
    overrides: dict[str, str] | None = None,
) -> CompositionMetadata:
    overrides = overrides if overrides is not None else date_overrides(repo_root)
    pdf_repo_path = repo_path(pdf_path, repo_root)

    if override_date := overrides.get(pdf_repo_path):
        year, month, _day = override_date.split("-")
        return metadata_from_date(year, month)

    for ly_path in ly_candidates(pdf_path):
        try:
            text = ly_path.read_text(encoding="utf-8", errors="ignore")
        except OSError:
            continue

        metadata = parse_composer_metadata(text)
        if metadata:
            return metadata

    raise ValueError(f"Could not parse composition month from {pdf_repo_path}")


def clean_basename(pdf_path: pathlib.Path) -> str:
    basename = pdf_path.stem
    return re.sub(
        r"_?\d{4}-\d{2}-\d{2}$|_?\d{2}-\d{2}-\d{4}$",
        "",
        basename,
    )


def copied_filename(pdf_path: pathlib.Path, metadata: CompositionMetadata) -> str:
    return f"{clean_basename(pdf_path)}_{metadata.filename_date}.pdf"


def find_pdfs(repo_root: pathlib.Path) -> list[pathlib.Path]:
    ignored = ignored_paths(repo_root)
    finished_dir = repo_root / "compositions" / "finished"
    return [
        pdf_path
        for pdf_path in sorted(finished_dir.rglob("*.pdf"))
        if repo_path(pdf_path, repo_root) not in ignored
    ]


def manifest(repo_root: pathlib.Path, url_root: str) -> list[dict[str, str]]:
    overrides = date_overrides(repo_root)
    items = []
    errors = []
    filenames: dict[str, str] = {}

    for pdf_path in find_pdfs(repo_root):
        source_path = repo_path(pdf_path, repo_root)
        try:
            metadata = metadata_for_pdf(pdf_path, repo_root, overrides)
        except ValueError as error:
            errors.append(str(error))
            continue

        filename = copied_filename(pdf_path, metadata)
        if existing_source := filenames.get(filename):
            errors.append(
                f"Duplicate output filename {filename}: {existing_source} and {source_path}"
            )
            continue
        filenames[filename] = source_path

        items.append(
            {
                "name": clean_basename(pdf_path),
                "filename": filename,
                "url": f"{url_root.rstrip('/')}/{filename}",
                "compositionMonth": metadata.composition_month,
                "displayDate": metadata.display_date,
                "sourcePath": source_path,
            }
        )

    if errors:
        for error in errors:
            print(error, file=sys.stderr)
        raise SystemExit(1)

    items.sort(key=lambda item: item["name"])
    items.sort(key=lambda item: item["compositionMonth"], reverse=True)
    return items


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--repo-root",
        type=pathlib.Path,
        default=pathlib.Path.cwd(),
    )
    subparsers = parser.add_subparsers(dest="command", required=True)

    date_parser = subparsers.add_parser("date")
    date_parser.add_argument("pdf", type=pathlib.Path)

    filename_parser = subparsers.add_parser("filename")
    filename_parser.add_argument("pdf", type=pathlib.Path)

    manifest_parser = subparsers.add_parser("manifest")
    manifest_parser.add_argument(
        "--url-root",
        default="/files/shapenote-compositions",
    )

    args = parser.parse_args()
    repo_root = args.repo_root.resolve()

    if args.command in {"date", "filename"}:
        pdf_path = args.pdf
        if not pdf_path.is_absolute():
            pdf_path = repo_root / pdf_path
        pdf_path = pdf_path.resolve()
        metadata = metadata_for_pdf(pdf_path, repo_root)
        if args.command == "date":
            print(metadata.filename_date)
        else:
            print(copied_filename(pdf_path, metadata))
        return

    if args.command == "manifest":
        json.dump(manifest(repo_root, args.url_root), sys.stdout, indent=2)
        print()


if __name__ == "__main__":
    main()
