export interface FilterableSong {
  id: string
  title: string
}

export function filterSongs<Song extends FilterableSong>(songs: readonly Song[], query: string): Song[] {
  const normalizedQuery = query.trim().toLowerCase()
  if (normalizedQuery === "") return [...songs]
  return songs.filter(
    (song) =>
      song.title.toLowerCase().includes(normalizedQuery) ||
      song.id.toLowerCase().includes(normalizedQuery),
  )
}
