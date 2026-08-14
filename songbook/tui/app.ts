import {
  BoxRenderable,
  InputRenderable,
  InputRenderableEvents,
  TextRenderable,
  createCliRenderer,
  type CliRenderer,
  type KeyEvent,
} from "@opentui/core"
import { spawnSync } from "node:child_process"
import { mkdtempSync, readFileSync, rmSync, writeFileSync } from "node:fs"
import { tmpdir } from "node:os"
import { isAbsolute, join, resolve } from "node:path"

import { filterSongs } from "./filter.ts"
import { saveJsonAtomically } from "./save-layout.ts"

interface Song {
  id: string
  title: string
  pageCount: number
  fingerprint: string
}

interface Scan {
  schemaVersion: 1
  songs: Song[]
  warnings: string[]
}

interface Layout {
  schemaVersion: 1
  exclusions: string[]
  forceFullPage: string[]
  pairs: [string, string][]
  unpaired: string[]
  order: string[][]
  fingerprints?: Record<string, string>
}

interface PlanUnit {
  songIds: string[]
  kind: "pair" | "multiPage" | "single"
  forced: boolean
  pageIndexes: number[]
}

interface Plan {
  schemaVersion: 1
  units: PlanUnit[]
  pages: Array<{ index: number; placements: unknown[] }>
  layout: Layout
  warnings: string[]
}

interface Options {
  repoRoot: string
  layoutPath: string
  outputPath: string
  smoke: boolean
}

function argumentsFrom(argv: string[]): Options {
  let repoRoot = process.cwd()
  let layoutPath = ".songbook-layout.json"
  let outputPath = "songbook.pdf"
  let smoke = false
  for (let index = 0; index < argv.length; index += 1) {
    const argument = argv[index]
    if (argument === "--smoke") {
      smoke = true
      continue
    }
    if (argument === "--repo-root" || argument === "--layout" || argument === "--output") {
      const value = argv[index + 1]
      if (value === undefined) throw new Error(`${argument} requires a value`)
      if (argument === "--repo-root") repoRoot = value
      if (argument === "--layout") layoutPath = value
      if (argument === "--output") outputPath = value
      index += 1
      continue
    }
    throw new Error(`unknown argument: ${argument}`)
  }
  repoRoot = resolve(repoRoot)
  return {
    repoRoot,
    layoutPath: isAbsolute(layoutPath) ? layoutPath : join(repoRoot, layoutPath),
    outputPath: isAbsolute(outputPath) ? outputPath : join(repoRoot, outputPath),
    smoke,
  }
}

function runJson(repoRoot: string, command: string, arguments_: string[] = []): unknown {
  const result = spawnSync(
    "uv",
    ["run", "songbook-pdf", command, ...arguments_, "--repo-root", repoRoot],
    { cwd: repoRoot, encoding: "utf8" },
  )
  if (result.error !== undefined) throw new Error(`could not start songbook-pdf: ${result.error.message}`)
  if (result.status !== 0) throw new Error(result.stderr.trim() || `songbook-pdf ${command} failed`)
  try {
    return JSON.parse(result.stdout)
  } catch (error) {
    throw new Error(`songbook-pdf ${command} returned invalid JSON: ${String(error)}`)
  }
}

function defaultLayout(exclusions: string[] = []): Layout {
  return {
    schemaVersion: 1,
    exclusions: [...exclusions].sort(),
    forceFullPage: [],
    pairs: [],
    unpaired: [],
    order: [],
  }
}

function readLayout(path: string, defaultExclusions: string[] = []): Layout {
  try {
    const parsed: unknown = JSON.parse(readFileSync(path, "utf8"))
    if (typeof parsed !== "object" || parsed === null || (parsed as { schemaVersion?: unknown }).schemaVersion !== 1) {
      throw new Error("layout.schemaVersion must be 1")
    }
    return parsed as Layout
  } catch (error) {
    if ((error as NodeJS.ErrnoException).code === "ENOENT") return defaultLayout(defaultExclusions)
    throw error
  }
}

function withTemporaryJson<T>(value: unknown, operation: (path: string) => T): T {
  const directory = mkdtempSync(join(tmpdir(), "shapenote-songbook-"))
  const path = join(directory, "value.json")
  try {
    writeFileSync(path, `${JSON.stringify(value)}\n`, "utf8")
    return operation(path)
  } finally {
    rmSync(directory, { recursive: true, force: true })
  }
}

class SongbookApp {
  private readonly renderer: CliRenderer
  private readonly options: Options
  private readonly filterInput: InputRenderable
  private readonly libraryText: TextRenderable
  private readonly proposalText: TextRenderable
  private readonly statusText: TextRenderable
  private scan: Scan
  private plan: Plan
  private layout: Layout
  private activePane: "library" | "proposal" = "library"
  private libraryIndex = 0
  private proposalIndex = 0
  private pairFirst: string | null = null
  private busy = false

  constructor(renderer: CliRenderer, options: Options, scan: Scan, layout: Layout, plan: Plan) {
    this.renderer = renderer
    this.options = options
    this.scan = scan
    this.layout = structuredClone(layout)
    this.plan = plan

    const root = new BoxRenderable(renderer, {
      id: "songbook-root",
      width: "100%",
      height: "100%",
      flexDirection: "column",
      padding: 1,
      backgroundColor: "#111318",
    })
    const heading = new TextRenderable(renderer, {
      id: "heading",
      content: "Shape-note songbook composer",
      height: 1,
      fg: "#F2F4F8",
    })
    const panes = new BoxRenderable(renderer, {
      id: "panes",
      flexGrow: 1,
      flexDirection: "row",
      gap: 1,
      marginTop: 1,
    })
    const libraryBox = new BoxRenderable(renderer, {
      id: "library",
      width: "50%",
      border: true,
      borderStyle: "rounded",
      borderColor: "#5B6472",
      title: "Library",
      padding: 1,
    })
    const proposalBox = new BoxRenderable(renderer, {
      id: "proposal",
      width: "50%",
      border: true,
      borderStyle: "rounded",
      borderColor: "#5B6472",
      title: "Proposed pages (maximum 2 songs)",
      padding: 1,
    })
    this.filterInput = new InputRenderable(renderer, {
      id: "library-filter",
      width: "100%",
      value: "",
      placeholder: "Filter title or PDF path",
      backgroundColor: "#1B1F27",
      textColor: "#D8DEE9",
      focusedBackgroundColor: "#252B36",
      focusedTextColor: "#F2F4F8",
      marginBottom: 1,
      onKeyDown: (key) => {
        if (key.name !== "escape") return
        key.preventDefault()
        this.filterInput.value = ""
        this.filterInput.blur()
        this.libraryIndex = 0
        this.render()
      },
    })
    this.filterInput.on(InputRenderableEvents.INPUT, () => {
      this.libraryIndex = 0
      this.render()
    })
    this.filterInput.on(InputRenderableEvents.ENTER, () => {
      this.filterInput.blur()
      this.render()
    })
    this.libraryText = new TextRenderable(renderer, { id: "library-text", content: "", fg: "#D8DEE9" })
    this.proposalText = new TextRenderable(renderer, { id: "proposal-text", content: "", fg: "#D8DEE9" })
    this.statusText = new TextRenderable(renderer, {
      id: "status",
      content: "",
      height: 3,
      marginTop: 1,
      fg: "#A8C7FA",
    })
    const help = new TextRenderable(renderer, {
      id: "help",
      height: 3,
      fg: "#9198A1",
      content:
        "Tab pane  ↑/↓ select  Space include/exclude  f force-full  p pair two  u unpair\n" +
        "/ filter  Enter keep filter  Escape clear filter  J/K move unit\n" +
        "r auto  s save  l reload  v preview/open  e export  q quit",
    })
    libraryBox.add(this.filterInput)
    libraryBox.add(this.libraryText)
    proposalBox.add(this.proposalText)
    panes.add(libraryBox)
    panes.add(proposalBox)
    root.add(heading)
    root.add(panes)
    root.add(this.statusText)
    root.add(help)
    renderer.root.add(root)
    renderer.keyInput.on("keypress", (key: KeyEvent) => void this.onKey(key))
    this.setStatus(this.plan.warnings.length > 0 ? this.plan.warnings.join("; ") : "Ready")
    this.render()
  }

  private visibleSongs(): Song[] {
    return filterSongs(this.scan.songs, this.filterInput.value)
  }

  private selectedSong(): Song | undefined {
    return this.visibleSongs()[this.libraryIndex]
  }

  private selectedUnit(): PlanUnit | undefined {
    return this.plan.units[this.proposalIndex]
  }

  private setStatus(message: string, error = false): void {
    this.statusText.content = `${error ? "Error" : "Status"}: ${message}`
    this.statusText.fg = error ? "#FF8A8A" : "#A8C7FA"
  }

  private render(): void {
    const excluded = new Set(this.layout.exclusions)
    const forced = new Set(this.layout.forceFullPage)
    const unpaired = new Set(this.layout.unpaired)
    const songs = this.visibleSongs()
    this.libraryIndex = Math.max(0, Math.min(this.libraryIndex, songs.length - 1))
    const visibleRows = Math.max(5, this.renderer.height - 13)
    const libraryStart = Math.max(0, Math.min(this.libraryIndex - Math.floor(visibleRows / 2), songs.length - visibleRows))
    const libraryLines = songs.map((song, index) => {
      const cursor = this.activePane === "library" && index === this.libraryIndex ? ">" : " "
      const included = excluded.has(song.id) ? "[ ]" : "[x]"
      const flags = [forced.has(song.id) ? "full" : "", unpaired.has(song.id) ? "single" : "", song.pageCount > 1 ? `${song.pageCount}p` : ""]
        .filter(Boolean)
        .join(",")
      const pairing = this.pairFirst === song.id ? " pair-first" : ""
      return `${cursor} ${included} ${song.title}${flags ? ` (${flags})` : ""}${pairing}`
    })
    this.libraryText.content =
      libraryLines.length === 0
        ? "  No matching songs"
        : libraryLines.slice(libraryStart, libraryStart + visibleRows).join("\n")

    const proposalStart = Math.max(0, Math.min(this.proposalIndex - Math.floor(visibleRows / 2), this.plan.units.length - visibleRows))
    const proposalLines = this.plan.units.map((unit, index) => {
      const cursor = this.activePane === "proposal" && index === this.proposalIndex ? ">" : " "
      const pageLabel = unit.pageIndexes.length === 1 ? `page ${unit.pageIndexes[0]! + 1}` : `pages ${unit.pageIndexes[0]! + 1}-${unit.pageIndexes.at(-1)! + 1}`
      const names = unit.songIds.map((id) => this.scan.songs.find((song) => song.id === id)?.title ?? id).join(" + ")
      return `${cursor} ${pageLabel} [${unit.songIds.length}/2] ${names}${unit.forced ? " *" : ""}`
    })
    this.proposalText.content = proposalLines.slice(proposalStart, proposalStart + visibleRows).join("\n")
  }

  private mutateSet(values: string[], songId: string, present: boolean): string[] {
    const set = new Set(values)
    if (present) set.add(songId)
    else set.delete(songId)
    return [...set].sort()
  }

  private async replan(message: string): Promise<void> {
    this.busy = true
    this.setStatus("Scanning and planning…")
    this.render()
    try {
      this.plan = withTemporaryJson(this.layout, (path) =>
        runJson(this.options.repoRoot, "plan", ["--layout", path]),
      ) as Plan
      this.layout = structuredClone(this.plan.layout)
      this.proposalIndex = Math.min(this.proposalIndex, Math.max(0, this.plan.units.length - 1))
      this.setStatus(this.plan.warnings.length > 0 ? `${message}; ${this.plan.warnings.join("; ")}` : message)
    } catch (error) {
      this.layout = structuredClone(this.plan.layout)
      this.setStatus(error instanceof Error ? error.message : String(error), true)
    } finally {
      this.busy = false
      this.render()
    }
  }

  private removePairsContaining(songIds: Set<string>): void {
    this.layout.pairs = this.layout.pairs.filter((pair) => !pair.some((id) => songIds.has(id)))
  }

  private splitOrder(songIds: Set<string>): void {
    this.layout.order = this.plan.units.flatMap((unit) => {
      if (!unit.songIds.some((id) => songIds.has(id))) return [[...unit.songIds]]
      return unit.songIds.map((id) => [id])
    })
  }

  private pairOrder(songIds: [string, string]): void {
    const selected = new Set(songIds)
    const order: string[][] = []
    let inserted = false
    for (const unit of this.plan.units) {
      if (unit.songIds.some((id) => selected.has(id))) {
        if (!inserted) order.push([...songIds])
        inserted = true
      } else {
        order.push([...unit.songIds])
      }
    }
    if (!inserted) order.push([...songIds])
    this.layout.order = order
  }

  private async onKey(key: KeyEvent): Promise<void> {
    if (this.busy) return
    if (key.ctrl && key.name === "c") {
      this.renderer.destroy()
      return
    }
    if (this.filterInput.focused) return
    if (key.name === "q") {
      this.renderer.destroy()
      return
    }
    if (key.name === "/") {
      key.stopPropagation()
      this.activePane = "library"
      this.filterInput.focus()
      this.render()
      return
    }
    if (key.name === "tab") {
      this.activePane = this.activePane === "library" ? "proposal" : "library"
      this.render()
      return
    }
    if (key.name === "up" || key.name === "down") {
      const delta = key.name === "up" ? -1 : 1
      if (this.activePane === "library") this.libraryIndex = Math.max(0, Math.min(this.visibleSongs().length - 1, this.libraryIndex + delta))
      else this.proposalIndex = Math.max(0, Math.min(this.plan.units.length - 1, this.proposalIndex + delta))
      this.render()
      return
    }
    try {
      if (key.name === "space" && this.activePane === "library") {
        const song = this.selectedSong()
        if (song === undefined) return
        const exclude = !this.layout.exclusions.includes(song.id)
        this.layout.exclusions = this.mutateSet(this.layout.exclusions, song.id, exclude)
        if (exclude) {
          this.layout.forceFullPage = this.mutateSet(this.layout.forceFullPage, song.id, false)
          this.layout.unpaired = this.mutateSet(this.layout.unpaired, song.id, false)
          this.removePairsContaining(new Set([song.id]))
          // Keep the old atomic unit intact. The planner sees the excluded member,
          // drops that stale unit, then replans the remaining song safely.
        }
        await this.replan(exclude ? `Excluded ${song.title}` : `Included ${song.title}`)
      } else if (key.name === "f" && this.activePane === "library") {
        const song = this.selectedSong()
        if (song === undefined) return
        const enable = !this.layout.forceFullPage.includes(song.id)
        this.layout.forceFullPage = this.mutateSet(this.layout.forceFullPage, song.id, enable)
        if (enable) {
          this.removePairsContaining(new Set([song.id]))
          this.splitOrder(new Set([song.id]))
        }
        await this.replan(`${enable ? "Forced full page" : "Allowed pairing"}: ${song.title}`)
      } else if (key.name === "p" && this.activePane === "library") {
        const song = this.selectedSong()
        if (song === undefined) return
        if (song.pageCount !== 1) throw new Error("Only one-page songs can be paired")
        if (this.pairFirst === null) {
          this.pairFirst = song.id
          this.setStatus(`Pair first song: ${song.title}; choose another and press p`)
          this.render()
        } else {
          if (this.pairFirst === song.id) throw new Error("Choose a different second song")
          const pair: [string, string] = [this.pairFirst, song.id]
          this.removePairsContaining(new Set(pair))
          for (const id of pair) {
            this.layout.forceFullPage = this.mutateSet(this.layout.forceFullPage, id, false)
            this.layout.unpaired = this.mutateSet(this.layout.unpaired, id, false)
            this.layout.exclusions = this.mutateSet(this.layout.exclusions, id, false)
          }
          this.layout.pairs.push(pair)
          this.pairOrder(pair)
          this.pairFirst = null
          await this.replan("Forced pair")
        }
      } else if (key.name === "u" && this.activePane === "proposal") {
        const unit = this.selectedUnit()
        if (unit === undefined || unit.songIds.length !== 2) throw new Error("Select a paired unit to unpair")
        const ids = new Set(unit.songIds)
        this.removePairsContaining(ids)
        this.splitOrder(ids)
        for (const id of ids) this.layout.unpaired = this.mutateSet(this.layout.unpaired, id, true)
        await this.replan("Pair split into persistent singles")
      } else if ((key.name === "j" || key.name === "k") && this.activePane === "proposal") {
        const from = this.proposalIndex
        const to = key.name === "k" ? from - 1 : from + 1
        if (to < 0 || to >= this.plan.units.length) return
        const order = this.plan.units.map((unit) => [...unit.songIds])
        ;[order[from], order[to]] = [order[to]!, order[from]!]
        this.layout.order = order
        this.proposalIndex = to
        await this.replan("Moved atomic unit")
      } else if (key.name === "r") {
        await this.replan("Automatic optimization rerun")
      } else if (key.name === "s") {
        saveJsonAtomically(this.options.layoutPath, this.layout)
        this.setStatus(`Saved ${this.options.layoutPath}`)
      } else if (key.name === "l") {
        this.layout = readLayout(
          this.options.layoutPath,
          this.scan.songs.map((song) => song.id),
        )
        await this.replan(`Reloaded ${this.options.layoutPath}`)
      } else if (key.name === "v") {
        const preview = join(this.options.repoRoot, ".songbook-preview.pdf")
        withTemporaryJson(this.plan, (path) => runJson(this.options.repoRoot, "export", ["--plan", path, "--output", preview]))
        const opened = spawnSync("open", [preview], { encoding: "utf8" })
        if (opened.status !== 0) throw new Error(opened.stderr.trim() || "macOS open failed")
        this.setStatus(`Generated and opened ${preview}`)
      } else if (key.name === "e") {
        withTemporaryJson(this.plan, (path) =>
          runJson(this.options.repoRoot, "export", ["--plan", path, "--output", this.options.outputPath]),
        )
        this.setStatus(`Exported ${this.options.outputPath}`)
      }
    } catch (error) {
      this.setStatus(error instanceof Error ? error.message : String(error), true)
    }
  }
}

async function main(): Promise<void> {
  const options = argumentsFrom(process.argv.slice(2))
  const renderer = await createCliRenderer({ exitOnCtrlC: false, targetFps: 30 })
  if (options.smoke) {
    const smokeRoot = new BoxRenderable(renderer, {
      id: "smoke-root",
      width: "100%",
      height: 2,
      flexDirection: "column",
    })
    smokeRoot.add(new TextRenderable(renderer, { id: "smoke", content: "Songbook TUI startup OK" }))
    smokeRoot.add(
      new InputRenderable(renderer, {
        id: "smoke-filter",
        width: "100%",
        placeholder: "Filter title or PDF path",
      }),
    )
    renderer.root.add(smokeRoot)
    setTimeout(() => renderer.destroy(), 100)
    return
  }
  try {
    const scan = runJson(options.repoRoot, "scan") as Scan
    const layout = readLayout(
      options.layoutPath,
      scan.songs.map((song) => song.id),
    )
    const plan = withTemporaryJson(layout, (path) =>
      runJson(options.repoRoot, "plan", ["--layout", path]),
    ) as Plan
    new SongbookApp(renderer, options, scan, plan.layout, plan)
  } catch (error) {
    renderer.destroy()
    throw error
  }
}

main().catch((error: unknown) => {
  process.stderr.write(`songbook: ${error instanceof Error ? error.message : String(error)}\n`)
  process.exitCode = 1
})
