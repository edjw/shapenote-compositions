# LilyPond Sacred Harp Project

## Sacred Harp Harmonic Analysis

To run harmonic analysis on a LilyPond file after compilation:

```bash
# Basic analysis (MIDI only)
uv run sacred_harp_analyzer.py song.midi harmony.log

# Enhanced analysis with LilyPond source mapping
uv run sacred_harp_analyzer.py song.midi harmony.log song.ly

# Watch mode (auto-reanalyze when MIDI changes)
uv run sacred_harp_analyzer.py --watch song.midi harmony.log song.ly
```

The analyzer will check for:
- Forbidden chords (vii°, ii° in minor, VI in minor)
- Vocal range violations based on Sacred Harp repertoire data
- Sustained fatigue warnings for extreme singing
- Adjacent scale degree dissonance
- Chord progressions and voice leading

View the results with:
```bash
tail -n 20 harmony.log
```