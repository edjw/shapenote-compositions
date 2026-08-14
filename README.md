# LilyPond Sacred Harp Compositions

A collection of original Sacred Harp compositions created with LilyPond.

## Compositions

### Finished Compositions (`compositions/finished/`)

Each composition directory contains:
- `.ly` - LilyPond source file
- `.pdf` - Rendered score
- `.midi` - Audio output

### Work in Progress (`compositions/working/`)

Compositions currently being developed.

I use Claude to commit to Github for me but I don't use Claude for writing music.

## Tools

### Sacred Harp Harmonic Analysis

For automated composition feedback and analysis. Not sure how well this works. Just an experiment really

```bash
# Basic analysis (MIDI only)
uv run sacred_harp_analyzer.py song.midi harmony.log

# Enhanced analysis with LilyPond source mapping
uv run sacred_harp_analyzer.py song.midi harmony.log song.ly

# Watch mode (auto-reanalyze when MIDI changes)
uv run sacred_harp_analyzer.py --watch song.midi harmony.log song.ly
```

The analyzer checks for:
- Forbidden chords (vii°, ii° in minor, VI in minor)
- Vocal range violations based on Sacred Harp repertoire data
- Sustained fatigue warnings for extreme singing
- Adjacent scale degree dissonance
- Chord progressions and voice leading

View results:
```bash
tail -n 20 harmony.log
```

### Songbook PDF composer

The terminal composer combines finished PDFs into a landscape A4 songbook, with up to two short songs on a page. See [`songbook/README.md`](songbook/README.md) for setup, controls and PDF rules.
