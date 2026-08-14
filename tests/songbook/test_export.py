from __future__ import annotations

import hashlib
import pathlib
import tempfile
import unittest

import pymupdf

from shapenote_songbook.contract import ContractError, PlacementV1, PlanV1
from shapenote_songbook.export import export_plan
from shapenote_songbook.planner import build_plan
from shapenote_songbook.scan import scan_repository

from .pdf_helpers import (
    insert_text,
    page_text,
    rect_contains,
    save_document,
    set_rotation,
    table_of_contents,
    text_dictionary,
)


class ExportTests(unittest.TestCase):
    def setUp(self) -> None:
        self.temporary_directory = tempfile.TemporaryDirectory()
        self.root = pathlib.Path(self.temporary_directory.name)
        self.source = self.root / "compositions/finished/vector/vector.pdf"
        self.source.parent.mkdir(parents=True)
        with pymupdf.open() as document:
            page = document.new_page(width=841.89, height=595.28)
            insert_text(page, (20, 40), "VECTOR SONG", fontsize=12)
            save_document(document, self.source)
        self.fingerprint = hashlib.sha256(self.source.read_bytes()).hexdigest()
        self.second_source = self.root / "compositions/finished/second/second.pdf"
        self.second_source.parent.mkdir(parents=True)
        with pymupdf.open() as document:
            page = document.new_page(width=841.89, height=595.28)
            insert_text(page, (20, 40), "SECOND SONG", fontsize=12)
            save_document(document, self.second_source)
        self.second_fingerprint = hashlib.sha256(self.second_source.read_bytes()).hexdigest()
        song_id = "compositions/finished/vector/vector.pdf"
        self.plan: PlanV1 = {
            "schemaVersion": 1,
            "pageSize": [841.89, 595.28],
            "units": [
                {
                    "songIds": [song_id],
                    "kind": "single",
                    "forced": False,
                    "pageIndexes": [0],
                }
            ],
            "pages": [
                {
                    "index": 0,
                    "placements": [
                        {
                            "songId": song_id,
                            "title": "Vector Song",
                            "sourcePath": song_id,
                            "fingerprint": self.fingerprint,
                            "sourcePage": 0,
                            "rotation": 0,
                            "clip": [0, 0, 841.89, 595.28],
                            "target": [33.9426, 24, 807.9474, 571.28],
                            "scale": 0.919366,
                        }
                    ],
                }
            ],
            "layout": {
                "schemaVersion": 1,
                "exclusions": [],
                "forceFullPage": [],
                "pairs": [],
                "unpaired": [],
                "order": [[song_id]],
                "fingerprints": {song_id: self.fingerprint},
            },
            "warnings": [],
        }

    def tearDown(self) -> None:
        self.temporary_directory.cleanup()

    def pair_plan(
        self,
        first_target: list[float],
        second_target: list[float],
        first_scale: float,
        second_scale: float,
    ) -> PlanV1:
        first: PlacementV1 = {
            **self.plan["pages"][0]["placements"][0],
            "clip": [0, 0, 200, 100],
            "target": first_target,
            "scale": first_scale,
        }
        second: PlacementV1 = {
            "songId": "compositions/finished/second/second.pdf",
            "title": "Second Song",
            "sourcePath": "compositions/finished/second/second.pdf",
            "fingerprint": self.second_fingerprint,
            "sourcePage": 0,
            "rotation": 0,
            "clip": [0, 0, 200, 100],
            "target": second_target,
            "scale": second_scale,
        }
        return {
            **self.plan,
            "pages": [{"index": 0, "placements": [first, second]}],
        }

    def test_export_is_landscape_a4_vector_content_at_target_position(self) -> None:
        output = self.root / "songbook.pdf"

        result = export_plan(self.root, self.plan, output)

        self.assertEqual(result["pageCount"], 1)
        with pymupdf.open(output) as document:
            page = document[0]
            self.assertAlmostEqual(page.rect.width, 841.89, places=1)
            self.assertAlmostEqual(page.rect.height, 595.28, places=1)
            self.assertIn("VECTOR SONG", page_text(page))
            self.assertEqual(page.get_images(full=True), [])
            text = text_dictionary(page)
            lines = text["blocks"][0].get("lines")
            if lines is None:
                self.fail("exported text block has no lines")
            span = lines[0]["spans"][0]
            self.assertAlmostEqual(span["bbox"][0], 52, delta=2)
            self.assertAlmostEqual(span["bbox"][1], 49, delta=3)
            self.assertEqual(table_of_contents(document)[0][1], "Vector Song")

    def test_rotated_sources_keep_vector_content_orientation_and_crop_geometry(self) -> None:
        for rotation, expected_direction in ((90, (0.0, -1.0)), (180, (-1.0, 0.0))):
            with self.subTest(rotation=rotation), tempfile.TemporaryDirectory() as temporary_directory:
                root = pathlib.Path(temporary_directory)
                rotated = root / f"compositions/finished/rotated-{rotation}/rotated-{rotation}.pdf"
                companion = root / "compositions/finished/companion/companion.pdf"
                rotated.parent.mkdir(parents=True)
                companion.parent.mkdir(parents=True)
                with pymupdf.open() as document:
                    width, height = (
                        (595.28, 841.89) if rotation == 90 else (841.89, 595.28)
                    )
                    page = document.new_page(width=width, height=height)
                    insert_text(page, (130, 160), f"ROTATED {rotation}", fontsize=12)
                    set_rotation(page, rotation)
                    save_document(document, rotated)
                with pymupdf.open() as document:
                    page = document.new_page(width=841.89, height=595.28)
                    insert_text(page, (120, 160), "COMPANION", fontsize=12)
                    save_document(document, companion)

                scan = scan_repository(root)
                rotated_id = f"compositions/finished/rotated-{rotation}/rotated-{rotation}.pdf"
                companion_id = "compositions/finished/companion/companion.pdf"
                plan = build_plan(scan, {"schemaVersion": 1, "pairs": [[rotated_id, companion_id]]})
                placement = next(
                    item
                    for item in plan["pages"][0]["placements"]
                    if item["songId"] == rotated_id
                )

                self.assertEqual(placement["rotation"], rotation)
                clip_width = placement["clip"][2] - placement["clip"][0]
                clip_height = placement["clip"][3] - placement["clip"][1]
                target_width = placement["target"][2] - placement["target"][0]
                target_height = placement["target"][3] - placement["target"][1]
                expected_width = clip_height if rotation == 90 else clip_width
                expected_height = clip_width if rotation == 90 else clip_height
                self.assertAlmostEqual(target_width / target_height, expected_width / expected_height, places=3)

                output = root / "songbook.pdf"
                _ = export_plan(root, plan, output)

                with pymupdf.open(output) as document:
                    page = document[0]
                    self.assertIn(f"ROTATED {rotation}", page_text(page))
                    self.assertEqual(page.get_images(full=True), [])
                    text = text_dictionary(page)
                    line = next(
                        line
                        for block in text["blocks"]
                        for line in block.get("lines", [])
                        if f"ROTATED {rotation}" in "".join(span["text"] for span in line["spans"])
                    )
                    self.assertAlmostEqual(line["dir"][0], expected_direction[0], places=2)
                    self.assertAlmostEqual(line["dir"][1], expected_direction[1], places=2)
                    self.assertTrue(
                        rect_contains(
                            pymupdf.Rect(placement["target"]), pymupdf.Rect(line["bbox"])
                        )
                    )

    def test_direct_export_rejects_portrait_source_page(self) -> None:
        portrait = self.root / "compositions/finished/portrait/portrait.pdf"
        portrait.parent.mkdir(parents=True)
        with pymupdf.open() as document:
            page = document.new_page(width=595.28, height=841.89)
            insert_text(page, (20, 40), "PORTRAIT SONG", fontsize=12)
            save_document(document, portrait)
        placement = dict(
            self.plan["pages"][0]["placements"][0],
            songId="compositions/finished/portrait/portrait.pdf",
            title="Portrait Song",
            sourcePath="compositions/finished/portrait/portrait.pdf",
            fingerprint=hashlib.sha256(portrait.read_bytes()).hexdigest(),
            clip=[0, 0, 595.28, 841.89],
            target=[228, 24, 615, 571.28],
            scale=0.65,
        )
        plan = dict(self.plan, pages=[{"index": 0, "placements": [placement]}])

        with self.assertRaisesRegex(ContractError, "landscape A4"):
            _ = export_plan(self.root, plan, self.root / "portrait-output.pdf")

    def test_export_rejects_any_output_beneath_finished_compositions_before_writing(self) -> None:
        excluded_id = "compositions/finished/second/second.pdf"
        excluded_plan: PlanV1 = {
            **self.plan,
            "layout": {
                **self.plan["layout"],
                "exclusions": [excluded_id],
            },
        }
        original = self.second_source.read_bytes()

        with self.assertRaisesRegex(ContractError, "compositions/finished"):
            _ = export_plan(self.root, excluded_plan, self.second_source)

        self.assertEqual(self.second_source.read_bytes(), original)

    def test_invalid_plans_are_rejected_before_writing(self) -> None:
        cases: dict[str, dict[str, object]] = {
            "stale fingerprint": {"fingerprint": "0" * 64},
            "bad source page": {"sourcePage": 2},
            "unsafe source": {"sourcePath": "../vector.pdf", "songId": "../vector.pdf"},
            "bad rectangle": {"target": [100, 100, 50, 300]},
            "upscaled rectangle": {"target": [100, 100, 500, 300], "scale": 2},
        }
        for name, changes in cases.items():
            with self.subTest(name=name):
                placement = dict(self.plan["pages"][0]["placements"][0], **changes)
                plan = dict(self.plan, pages=[{"index": 0, "placements": [placement]}])
                output = self.root / f"{name}.pdf"
                with self.assertRaises(ContractError):
                    _ = export_plan(self.root, plan, output)
                self.assertFalse(output.exists())

    def test_pair_contract_rejects_unequal_small_overlapping_side_by_side_or_tight_placements(self) -> None:
        cases = {
            "unequal scale": self.pair_plan([100, 100, 280, 190], [100, 202, 290, 297], 0.9, 0.95),
            "below minimum scale": self.pair_plan([100, 100, 278, 189], [100, 201, 278, 290], 0.89, 0.89),
            "overlap": self.pair_plan([100, 100, 280, 190], [100, 180, 280, 270], 0.9, 0.9),
            "side by side": self.pair_plan([100, 100, 280, 190], [300, 100, 480, 190], 0.9, 0.9),
            "insufficient gutter": self.pair_plan([100, 100, 280, 190], [100, 200, 280, 290], 0.9, 0.9),
        }

        for name, plan in cases.items():
            with self.subTest(name=name):
                output = self.root / f"pair-{name}.pdf"
                with self.assertRaises(ContractError):
                    _ = export_plan(self.root, plan, output)
                self.assertFalse(output.exists())

    def test_pair_contract_accepts_uniform_vertical_placements_with_twelve_point_gutter(self) -> None:
        plan = self.pair_plan([100, 100, 280, 190], [100, 202, 280, 292], 0.9, 0.9)
        output = self.root / "valid-pair.pdf"

        result = export_plan(self.root, plan, output)

        self.assertEqual(result["pageCount"], 1)
        with pymupdf.open(output) as document:
            self.assertIn("VECTOR SONG", page_text(document[0]))
            self.assertIn("SECOND SONG", page_text(document[0]))

    def test_more_than_two_placements_is_rejected(self) -> None:
        placement = self.plan["pages"][0]["placements"][0]
        plan = dict(self.plan, pages=[{"index": 0, "placements": [placement, placement, placement]}])

        with self.assertRaisesRegex(ContractError, "at most two"):
            _ = export_plan(self.root, plan, self.root / "bad.pdf")


if __name__ == "__main__":
    _ = unittest.main()
