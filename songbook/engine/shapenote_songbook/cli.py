from __future__ import annotations

import argparse
import json
import pathlib
import sys

from .contract import ContractError, ExportResultV1, PlanV1, ScanV1, require_mapping
from .export import export_plan
from .planner import build_plan
from .scan import scan_repository


def _json_file(path: pathlib.Path, name: str) -> dict[str, object]:
    try:
        value: object = json.loads(path.read_text(encoding="utf-8"))
    except OSError as error:
        raise ContractError(f"could not read {name} {path}: {error}") from error
    except json.JSONDecodeError as error:
        raise ContractError(f"invalid JSON in {name} {path}: {error}") from error
    try:
        return require_mapping(value, name)
    except ContractError as error:
        raise ContractError(f"{name} must contain a JSON object") from error


def _parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(prog="songbook-pdf")
    commands = parser.add_subparsers(dest="command", required=True)
    for command in ("scan", "plan", "export"):
        subparser = commands.add_parser(command)
        _ = subparser.add_argument("--repo-root", type=pathlib.Path, default=pathlib.Path.cwd())
        if command == "plan":
            _ = subparser.add_argument("--layout", type=pathlib.Path)
        if command == "export":
            _ = subparser.add_argument("--plan", type=pathlib.Path, required=True)
            _ = subparser.add_argument("--output", type=pathlib.Path, required=True)
    return parser


def run(arguments: list[str] | None = None) -> ScanV1 | PlanV1 | ExportResultV1:
    args = _parser().parse_args(arguments)
    repo_root = args.repo_root.resolve()
    if args.command == "scan":
        return scan_repository(repo_root)
    if args.command == "plan":
        layout = _json_file(args.layout, "layout") if args.layout else None
        return build_plan(scan_repository(repo_root), layout)
    if args.command == "export":
        plan = _json_file(args.plan, "plan")
        return export_plan(repo_root, plan, args.output)
    raise ContractError(f"unknown command: {args.command}")


def main() -> int:
    try:
        result = run()
        _ = json.dump(result, sys.stdout, ensure_ascii=False, separators=(",", ":"))
        _ = sys.stdout.write("\n")
        return 0
    except ContractError as error:
        print(f"songbook-pdf: {error}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
