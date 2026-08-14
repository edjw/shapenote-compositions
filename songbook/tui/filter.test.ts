import assert from "node:assert/strict"
import test from "node:test"

import { filterSongs } from "./filter.ts"

const songs = [
  { id: "compositions/finished/alpha-road/alpha-road.pdf", title: "Alpha Road" },
  { id: "compositions/finished/beta-hymn/beta-hymn.pdf", title: "Evening Hymn" },
  { id: "compositions/finished/gamma-song/gamma-song.pdf", title: "Gamma Song" },
]

const ids = (items: typeof songs): string[] => items.map((song) => song.id)

test("empty filter shows every song", () => {
  assert.deepEqual(ids(filterSongs(songs, "")), ids(songs))
})

test("filter matches song titles", () => {
  assert.deepEqual(ids(filterSongs(songs, "Evening")), [songs[1]!.id])
})

test("filter matches repository-relative PDF paths", () => {
  assert.deepEqual(ids(filterSongs(songs, "beta-hymn.pdf")), [songs[1]!.id])
})

test("filter matching is case-insensitive", () => {
  assert.deepEqual(ids(filterSongs(songs, "GAMMA SONG")), [songs[2]!.id])
})

test("filter trims surrounding whitespace", () => {
  assert.deepEqual(ids(filterSongs(songs, "  alpha road  ")), [songs[0]!.id])
})

test("filter returns an empty list when nothing matches", () => {
  assert.deepEqual(filterSongs(songs, "missing"), [])
})

test("filter preserves source order", () => {
  const source = [songs[2]!, songs[0]!, songs[1]!]

  assert.deepEqual(ids(filterSongs(source, "finished/")), ids(source))
})
