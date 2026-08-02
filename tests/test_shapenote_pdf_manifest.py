import json
import pathlib
import subprocess
import sys
import tempfile
import unittest


REPO_ROOT = pathlib.Path(__file__).resolve().parents[1]
MANIFEST_SCRIPT = REPO_ROOT / "scripts" / "shapenote_pdf_manifest.py"


def run_cli(
    lilypond_source: str,
    command: str,
    composition_name: str = "example",
    pdf_stem: str = "example",
) -> subprocess.CompletedProcess[str]:
    with tempfile.TemporaryDirectory() as temporary_directory:
        repo_root = pathlib.Path(temporary_directory)
        composition_dir = repo_root / "compositions" / "finished" / composition_name
        composition_dir.mkdir(parents=True)
        pdf_path = composition_dir / f"{pdf_stem}.pdf"
        pdf_path.write_bytes(b"PDF")
        pdf_path.with_suffix(".ly").write_text(lilypond_source, encoding="utf-8")

        arguments = [
            sys.executable,
            str(MANIFEST_SCRIPT),
            "--repo-root",
            str(repo_root),
            command,
        ]
        if command != "manifest":
            arguments.append(str(pdf_path))

        return subprocess.run(
            arguments,
            check=False,
            capture_output=True,
            text=True,
        )


class ManifestCliTests(unittest.TestCase):
    def test_manifest_reads_date_from_multiline_composer_markup(self) -> None:
        result = run_cli(
            """songComposer = \\markup \\right-column {
  \"Arr. Ed Johnson-Williams, July 2026\"
  \"from Original Sacred Harp, 1966, from B. F. White, 1844.\"
}
poetName = \"The Sacred Harp, 1844.\"
""",
            "manifest",
            "safe-in-the-promised-land-15-7-26",
            "safe-in-the-promised-land",
        )

        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(
            json.loads(result.stdout),
            [
                {
                    "name": "safe-in-the-promised-land",
                    "filename": "safe-in-the-promised-land_2026-07-01.pdf",
                    "url": "/files/shapenote-compositions/safe-in-the-promised-land_2026-07-01.pdf",
                    "compositionMonth": "2026-07",
                    "displayDate": "July 2026",
                    "sourcePath": "compositions/finished/safe-in-the-promised-land-15-7-26/safe-in-the-promised-land.pdf",
                }
            ],
        )

    def test_date_ignores_dates_after_a_quoted_composer(self) -> None:
        result = run_cli(
            """songComposer = \"Ed Johnson-Williams, July 2026\"
\\paper {
  % Engraving revised August 2025
}
""",
            "date",
        )

        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(result.stdout, "2026-07-01\n")

    def test_date_ignores_dates_after_multiline_composer_markup(self) -> None:
        result = run_cli(
            """songComposer = \\markup \\right-column {
  \"Arr. Ed Johnson-Williams, July 2026\"
}
\\paper {
  % Engraving revised August 2025
}
""",
            "date",
        )

        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(result.stdout, "2026-07-01\n")

    def test_date_reads_multiline_composer_with_brace_on_following_line(self) -> None:
        result = run_cli(
            """songComposer = \\markup
  \\right-column {
    \"Arr. Ed Johnson-Williams, July 2026\"
  }
""",
            "date",
        )

        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(result.stdout, "2026-07-01\n")

    def test_date_ignores_braces_in_composer_comments(self) -> None:
        result = run_cli(
            """songComposer = \\markup \\right-column {
  \"Arr. Ed Johnson-Williams, July 2026\"
  % A literal opening brace: {
}
\\paper {
  % Engraving revised August 2025
}
""",
            "date",
        )

        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(result.stdout, "2026-07-01\n")


if __name__ == "__main__":
    unittest.main()
