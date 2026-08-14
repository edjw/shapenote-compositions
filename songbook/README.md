# Songbook PDF composer

This terminal app builds a landscape A4 songbook from the PDFs in `compositions/finished`.

It measures the visible score on each page, then reorders short one-page songs so that two can share a page where they fit. It never puts more than two songs on a page. Multi-page songs stay together and use one output page for each source page.

The measurement pass renders a temporary image to find the surrounding whitespace. The export still uses the original PDF text and drawing paths. It does not put that temporary image into the finished PDF.

## Project structure

The feature lives under one directory, but has two parts because OpenTUI and PDF processing use different runtimes:

```text
songbook/
├── engine/
│   └── shapenote_songbook/   Python scanning, planning and PDF export
├── tui/                      TypeScript OpenTUI app
└── README.md
```

The engine tests are in `tests/songbook`.

## Requirements

- macOS, to open previews with `open`
- [uv](https://docs.astral.sh/uv/) for Python and PyMuPDF
- Node.js 26.4 or later, including the experimental FFI support used by OpenTUI
- [pnpm](https://pnpm.io/) 11

Install the locked dependencies from the repository root:

```bash
uv sync --locked
pnpm install --frozen-lockfile
```

## Start the app

```bash
pnpm songbook --repo-root .
```

On the first launch, all PDFs are deselected. Use the arrow keys and `Space` to choose the songs for the new PDF. If a saved layout exists, the app restores its selection and manual overrides instead.

The library is on the left. The proposed output is on the right. The proposal shows the output page numbers and whether each unit contains one or two songs.

| Key | Action |
| --- | --- |
| `Tab` | Switch between the library and proposed output |
| `/` | Focus the library filter; match a title or repository-relative PDF path |
| `Enter` | Keep the current filter and return to the normal controls |
| `Escape` | Clear the filter and return to the normal controls |
| `↑` / `↓` | Select a song or output unit |
| `Space` | Include or exclude the selected song |
| `f` | Force the selected song to use a full page, or allow pairing again |
| `p` | Choose two songs as an explicit pair |
| `u` | Split the selected pair and keep both songs as singles |
| `J` / `K` | Move the selected song or pair down or up as one unit |
| `r` | Re-run automatic optimisation without removing manual overrides |
| `s` | Save the layout |
| `l` | Reload the saved layout |
| `v` | Generate `.songbook-preview.pdf` and open it in Preview |
| `e` | Export the final PDF |
| `q` | Quit |

By default, the app saves the layout to `.songbook-layout.json` and exports the finished PDF to `songbook.pdf`. You can choose other paths when starting it:

```bash
pnpm songbook \
  --repo-root . \
  --layout layouts/choir.json \
  --output choir-songbook.pdf
```

The app creates a missing layout directory when you save. A saved layout records which songs are included, which must use full pages, explicit pairs, persistent unpairs and the order of output units. It does not save calculated crop rectangles, so changed PDFs are measured again when the layout is reopened.

The app honours `.pdfignore`. This keeps historical and duplicate PDFs out of the library.

## PDF rules

- Every displayed source page must be landscape A4.
- Every output page is landscape A4.
- A page contains no more than two songs.
- Only one-page songs can share a page.
- Paired songs use the same scale and are never enlarged.
- Multi-page songs remain consecutive.
- Export keeps text and notation as vectors.

The scanner stops with a clear error if it finds a portrait or non-A4 source page.

## Run the checks

```bash
pnpm check
```

This runs TypeScript checking, the filter's Node tests, strict basedpyright and the Python test suite. basedpyright uses the uv-managed `.venv`, so imports such as `pymupdf` resolve in the editor and on the command line.

## Use the PDF engine directly

The TUI talks to the Python engine through versioned JSON commands. They can also be run by hand:

```bash
uv run songbook-pdf scan --repo-root .
uv run songbook-pdf plan --repo-root . --layout .songbook-layout.json > plan.json
uv run songbook-pdf export --repo-root . --plan plan.json --output songbook.pdf
```

Each command writes JSON schema version 1 to standard output. Errors go to standard error. PDF paths and song IDs are repository-relative POSIX paths.
