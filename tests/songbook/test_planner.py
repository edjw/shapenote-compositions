from __future__ import annotations

import unittest

from shapenote_songbook.contract import ScanV1, ScannedPageV1, SongV1
from shapenote_songbook.planner import ContractError, build_plan


def song(
    song_id: str,
    *,
    pages: int = 1,
    bounds: tuple[float, float, float, float] = (100, 100, 700, 300),
) -> SongV1:
    scanned_pages: list[ScannedPageV1] = [
        {
            "index": index,
            "mediaBounds": [0.0, 0.0, 841.89, 595.28],
            "occupiedBounds": list(bounds),
            "landscapeA4": True,
        }
        for index in range(pages)
    ]
    return {
        "id": song_id,
        "title": song_id.title(),
        "sourcePath": f"compositions/finished/{song_id}/{song_id}.pdf",
        "fingerprint": song_id * 8,
        "pageCount": pages,
        "pages": scanned_pages,
    }


def scan(*songs: SongV1) -> ScanV1:
    return {"schemaVersion": 1, "songs": list(songs), "warnings": []}


class PlannerTests(unittest.TestCase):
    def test_measurements_and_overrides_make_pairs_and_reorder_atomic_units(self) -> None:
        library = scan(song("alpha"), song("beta"), song("gamma"))
        layout = {
            "schemaVersion": 1,
            "exclusions": [],
            "forceFullPage": [],
            "pairs": [["alpha", "beta"]],
            "unpaired": [],
            "order": [["gamma"], ["alpha", "beta"]],
        }

        plan = build_plan(library, layout)

        self.assertEqual(
            [unit["songIds"] for unit in plan["units"]],
            [["gamma"], ["alpha", "beta"]],
        )
        self.assertEqual(
            [len(page["placements"]) for page in plan["pages"]], [1, 2]
        )
        self.assertTrue(all(len(page["placements"]) <= 2 for page in plan["pages"]))

    def test_multi_page_song_is_atomic_consecutive_and_full_page(self) -> None:
        library = scan(song("long", pages=3), song("short"))

        plan = build_plan(
            library, {"schemaVersion": 1, "order": [["long"], ["short"]]}
        )

        self.assertEqual(plan["units"][0]["pageIndexes"], [0, 1, 2])
        self.assertEqual(
            [page["placements"][0]["sourcePage"] for page in plan["pages"][:3]],
            [0, 1, 2],
        )
        self.assertTrue(
            all(len(page["placements"]) == 1 for page in plan["pages"][:3])
        )
        self.assertTrue(
            all(
                page["placements"][0]["clip"] == [0.0, 0.0, 841.89, 595.28]
                for page in plan["pages"][:3]
            )
        )

    def test_incompatible_pair_and_conflicting_overrides_are_rejected(self) -> None:
        library = scan(song("long", pages=2), song("short"))
        layout = {"schemaVersion": 1, "pairs": [["long", "short"]]}

        with self.assertRaisesRegex(ContractError, "one-page"):
            _ = build_plan(library, layout)

    def test_stale_layout_preserves_valid_intent_warns_and_appends_new_songs(self) -> None:
        library = scan(song("alpha"), song("new"))
        layout = {
            "schemaVersion": 1,
            "forceFullPage": ["alpha", "missing"],
            "order": [["missing"], ["alpha"]],
            "fingerprints": {"alpha": "old fingerprint", "missing": "gone"},
        }

        plan = build_plan(library, layout)

        self.assertEqual(
            [unit["songIds"] for unit in plan["units"]], [["alpha"], ["new"]]
        )
        self.assertEqual(plan["layout"]["forceFullPage"], ["alpha"])
        self.assertTrue(any("missing" in warning for warning in plan["warnings"]))
        self.assertTrue(any("changed" in warning for warning in plan["warnings"]))

    def test_excluding_one_member_of_an_automatic_pair_replans_without_splitting_error(
        self,
    ) -> None:
        library = scan(song("alpha"), song("beta"), song("gamma"), song("delta"))
        original = build_plan(library, {"schemaVersion": 1})
        excluded_id = original["units"][0]["songIds"][0]
        layout = {**original["layout"], "exclusions": [excluded_id]}

        plan = build_plan(library, layout)

        planned_ids = [
            song_id for unit in plan["units"] for song_id in unit["songIds"]
        ]
        self.assertNotIn(excluded_id, planned_ids)
        self.assertEqual(len(planned_ids), 3)
        self.assertTrue(
            any("stale ordered unit dropped" in warning for warning in plan["warnings"])
        )

    def test_new_song_reconciles_automatic_pairs_without_losing_unaffected_manual_order(
        self,
    ) -> None:
        original_scan = scan(
            *(song(name) for name in ("alpha", "beta", "gamma", "delta", "epsilon"))
        )
        saved_layout = build_plan(
            original_scan,
            {
                "schemaVersion": 1,
                "forceFullPage": ["alpha"],
                "pairs": [["beta", "gamma"]],
                "order": [["delta", "epsilon"], ["alpha"], ["beta", "gamma"]],
            },
        )["layout"]
        next_scan = scan(*original_scan["songs"], song("zeta"))

        plan = build_plan(next_scan, saved_layout)

        units = [unit["songIds"] for unit in plan["units"]]
        self.assertEqual(units[:2], [["alpha"], ["beta", "gamma"]])
        self.assertCountEqual(
            [song_id for unit in units[2:] for song_id in unit],
            ["delta", "epsilon", "zeta"],
        )
        self.assertTrue(
            any("stale ordered unit dropped" in warning for warning in plan["warnings"])
        )

    def test_deleted_song_drops_stale_atomic_order_and_replans_changed_automatic_pairs(
        self,
    ) -> None:
        original_scan = scan(song("alpha"), song("beta"), song("gamma"), song("delta"))
        saved_layout = build_plan(original_scan, {"schemaVersion": 1})["layout"]
        next_scan = scan(
            *(item for item in original_scan["songs"] if item["id"] != "alpha")
        )

        plan = build_plan(next_scan, saved_layout)

        planned_ids = [
            song_id for unit in plan["units"] for song_id in unit["songIds"]
        ]
        self.assertCountEqual(planned_ids, ["beta", "gamma", "delta"])
        self.assertEqual(len(planned_ids), len(set(planned_ids)))
        self.assertTrue(
            any("stale ordered unit dropped" in warning for warning in plan["warnings"])
        )
        self.assertTrue(
            any(
                "alpha" in warning and "missing" in warning
                for warning in plan["warnings"]
            )
        )

    def test_stale_invalid_pair_is_dropped_instead_of_blocking_replanning(self) -> None:
        library = scan(song("long", pages=2), song("short"))
        layout = {
            "schemaVersion": 1,
            "pairs": [["long", "short"]],
            "order": [["long", "short"]],
            "fingerprints": {
                "long": "old",
                "short": library["songs"][1]["fingerprint"],
            },
        }

        plan = build_plan(library, layout)

        self.assertEqual(
            [unit["songIds"] for unit in plan["units"]], [["long"], ["short"]]
        )
        self.assertEqual(plan["layout"]["pairs"], [])
        self.assertTrue(any("pair dropped" in warning for warning in plan["warnings"]))

    def test_automatic_pairing_respects_minimum_common_scale(self) -> None:
        huge = (0, 0, 841.89, 400)
        library = scan(song("alpha", bounds=huge), song("beta", bounds=huge))

        plan = build_plan(library, {"schemaVersion": 1})

        self.assertEqual(
            [unit["songIds"] for unit in plan["units"]], [["alpha"], ["beta"]]
        )

    def test_automatic_pairing_maximises_pair_count_before_fullness(self) -> None:
        narrow = (200, 100, 600, 200)
        wide = (10, 100, 830, 400)
        library = scan(
            song("alpha", bounds=narrow),
            song("beta", bounds=narrow),
            song("gamma", bounds=wide),
            song("delta", bounds=wide),
        )

        plan = build_plan(library, {"schemaVersion": 1})

        self.assertEqual(
            sum(unit["kind"] == "pair" for unit in plan["units"]), 2
        )


if __name__ == "__main__":
    _ = unittest.main()
