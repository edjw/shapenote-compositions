from __future__ import annotations

import json
import pathlib
import subprocess
import tempfile
import unittest

import pymupdf

from .pdf_helpers import insert_text, save_document


class CliTests(unittest.TestCase):
    def setUp(self) -> None:
        self.temporary_directory = tempfile.TemporaryDirectory()
        self.root = pathlib.Path(self.temporary_directory.name)
        pdf = self.root / "compositions/finished/example/example.pdf"
        pdf.parent.mkdir(parents=True)
        with pymupdf.open() as document:
            page = document.new_page(width=841.89, height=595.28)
            insert_text(page, (100, 100), "Example")
            save_document(document, pdf)

    def tearDown(self) -> None:
        self.temporary_directory.cleanup()

    def run_cli(self, *arguments: str) -> subprocess.CompletedProcess[str]:
        return subprocess.run(
            ["uv", "run", "songbook-pdf", *arguments, "--repo-root", str(self.root)],
            check=False,
            capture_output=True,
            text=True,
        )

    def test_scan_plan_and_export_are_versioned_json_commands(self) -> None:
        scan = self.run_cli("scan")
        self.assertEqual(scan.returncode, 0, scan.stderr)
        self.assertEqual(json.loads(scan.stdout)["schemaVersion"], 1)
        self.assertEqual(scan.stderr, "")

        plan = self.run_cli("plan")
        self.assertEqual(plan.returncode, 0, plan.stderr)
        plan_data = json.loads(plan.stdout)
        self.assertEqual(plan_data["schemaVersion"], 1)
        plan_path = self.root / "plan.json"
        _ = plan_path.write_text(plan.stdout, encoding="utf-8")

        export = self.run_cli("export", "--plan", str(plan_path), "--output", "songbook.pdf")
        self.assertEqual(export.returncode, 0, export.stderr)
        self.assertEqual(json.loads(export.stdout)["pageCount"], 1)
        self.assertTrue((self.root / "songbook.pdf").is_file())

    def test_contract_error_is_explicit_without_traceback(self) -> None:
        layout = self.root / "layout.json"
        _ = layout.write_text('{"schemaVersion": 99}', encoding="utf-8")

        result = self.run_cli("plan", "--layout", str(layout))

        self.assertEqual(result.returncode, 2)
        self.assertIn("schemaVersion", result.stderr)
        self.assertNotIn("Traceback", result.stderr)
        self.assertEqual(result.stdout, "")


if __name__ == "__main__":
    _ = unittest.main()
