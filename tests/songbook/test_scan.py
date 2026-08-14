from __future__ import annotations

import hashlib
import pathlib
import tempfile
import unittest

import pymupdf

from shapenote_songbook.contract import ContractError
from shapenote_songbook.scan import scan_repository

from .pdf_helpers import add_rect_annotation, insert_text, save_document, set_metadata


class ScanTests(unittest.TestCase):
    def test_scan_recurses_honors_pdfignore_and_measures_visible_ink(self) -> None:
        with tempfile.TemporaryDirectory() as temporary_directory:
            root = pathlib.Path(temporary_directory)
            included = root / "compositions/finished/my-song/my-song.pdf"
            ignored = root / "compositions/finished/old/old.pdf"
            included.parent.mkdir(parents=True)
            ignored.parent.mkdir(parents=True)
            with pymupdf.open() as document:
                set_metadata(document, {"title": "My Readable Song"})
                page = document.new_page(width=841.89, height=595.28)
                insert_text(page, (120, 140), "Visible vector score", fontsize=20)
                add_rect_annotation(page, pymupdf.Rect(700, 500, 800, 550))
                save_document(document, included)
            with pymupdf.open() as document:
                _ = document.new_page(width=841.89, height=595.28)
                save_document(document, ignored)
            _ = (root / ".pdfignore").write_text(
                "# historical duplicate\ncompositions/finished/old/old.pdf\n",
                encoding="utf-8",
            )

            result = scan_repository(root)

            self.assertEqual(result["schemaVersion"], 1)
            self.assertEqual(len(result["songs"]), 1)
            song = result["songs"][0]
            self.assertEqual(song["id"], "compositions/finished/my-song/my-song.pdf")
            self.assertEqual(song["sourcePath"], song["id"])
            self.assertEqual(song["title"], "My Readable Song")
            self.assertEqual(song["fingerprint"], hashlib.sha256(included.read_bytes()).hexdigest())
            self.assertEqual(song["pageCount"], 1)
            page = song["pages"][0]
            self.assertTrue(page["landscapeA4"])
            self.assertLess(page["occupiedBounds"][0], 125)
            self.assertLess(page["occupiedBounds"][1], 145)
            self.assertLess(page["occupiedBounds"][2], 400)
            self.assertLess(page["occupiedBounds"][3], 200)

    def test_portrait_page_is_rejected(self) -> None:
        with tempfile.TemporaryDirectory() as temporary_directory:
            root = pathlib.Path(temporary_directory)
            pdf = root / "compositions/finished/portrait/portrait.pdf"
            pdf.parent.mkdir(parents=True)
            with pymupdf.open() as document:
                _ = document.new_page(width=595.28, height=841.89)
                save_document(document, pdf)

            with self.assertRaisesRegex(ContractError, "landscape A4"):
                _ = scan_repository(root)

    def test_empty_page_falls_back_to_media_bounds_with_warning(self) -> None:
        with tempfile.TemporaryDirectory() as temporary_directory:
            root = pathlib.Path(temporary_directory)
            pdf = root / "compositions/finished/empty/empty.pdf"
            pdf.parent.mkdir(parents=True)
            with pymupdf.open() as document:
                _ = document.new_page(width=841.89, height=595.28)
                save_document(document, pdf)

            result = scan_repository(root)

            self.assertEqual(result["songs"][0]["pages"][0]["occupiedBounds"], [0.0, 0.0, 841.89, 595.28])
            self.assertIn("no visible ink", result["warnings"][0])


if __name__ == "__main__":
    _ = unittest.main()
