# LilyPond Sacred Harp Reference for Claude

## CONTEXT DETECTION

### User Intent Recognition
```
User mentions → Use this approach:
"Sacred Harp" → 4-shape system, \sacredHarpHeads
"Christian Harmony" → 7-shape system, \aikenHeads  
"shape notes" (generic) → Ask which system, default to \aikenHeads
"4-shape" → \sacredHarpHeads
"7-shape" → \aikenHeads
"Aikin" → \aikenHeads
"small print/compact" → \aikenThinHeads
```

### Geographic Context Clues
```
Georgia, Alabama, Texas, Florida → Sacred Harp likely
North Carolina, Tennessee, Mississippi → Christian Harmony likely
Mennonite, Brethren → Christian Harmony
"singing" (without "church") → Sacred Harp likely
```

## COMMAND REFERENCE

### Shape Note Commands (Copy-Paste Ready)
```lilypond
% PRIMARY SYSTEMS
\sacredHarpHeads              % Sacred Harp major
\sacredHarpHeadsMinor         % Sacred Harp minor
\aikenHeads                   % Christian Harmony major
\aikenHeadsMinor              % Christian Harmony minor
\aikenThinHeads               % Christian Harmony compact
\aikenThinHeadsMinor          % Christian Harmony compact minor

% HISTORICAL (rarely used)
\southernHarmonyHeads \southernHarmonyHeadsMinor
\funkHeads \funkHeadsMinor
\walkerHeads \walkerHeadsMinor
```

### Essential Setup Blocks
```lilypond
% REQUIRED HEADER
\language "espanol"
\version "2.16.00"
#(set-default-paper-size "a4landscape")

% STANDARD GLOBAL
global = {
  \key do \major
  \aikenHeads
  \numericTimeSignature
  \time 4/4
  \defineBarLine ";" #'("|" ";" " ")
  \defineBarLine ";." #'("|" ";." ";.")
  \defineBarLine ".;" #'("|" ".;" ".;")
  \autoBeamOff
}
```

## COMPLETE TEMPLATES

### Sacred Harp Template 0.4 (Complete Working Template)
```lilypond
\language "espanol"
%%%%%% Sacred Harp Template 0.4 %%%%%%
\version "2.16.00"
#(set-default-paper-size "a4landscape")

\paper {
  page-count = #1
  system-count = #2
  ragged-last = ##t
  ragged-bottom = ##t
  system-system-spacing = #'((basic-distance . 0) (padding . 6))
  top-margin = 0.5\in
}

\header {
  title = \markup{ \bold \smaller
  "__________   "  \small{"11s" }}% TITLE.  METER.
  arranger = \markup "Ed Johnson-Williams, 25 July 2025."
  meter = \markup {"C Major (transpose as needed)."}
  tagline = ##f
}

global = {
  \key do \major
  \aikenHeads    % or \sacredHarpHeads
  \numericTimeSignature
  \time 4/4
  \defineBarLine ";" #'("|" ";" " ")
  \defineBarLine ";." #'("|" ";." ";.")
  \defineBarLine ".;" #'("|" ".;" ".;")
  \defineBarLine ".." #'(".." ".." "..")
  \defineBarLine ";.." #'(";.." ";.." ";..")
  \defineBarLine ";.;" #'(";.;" ";.;" ";.;")
  \autoBeamOff
  \override Score.RehearsalMark.self-alignment-X = #LEFT
}

%%%%%%% MUSIC %%%%%%%%%
trebleA = \relative do'' {
  % \repeat volta 2{  % Uncomment to repeat A section
  % \bar ";"          % Uncomment if repeating
  % MUSIC GOES HERE
  % \break           % Uncomment for line break after A
  % }               % Uncomment if repeating
}

altoA = \relative do' {
  % MUSIC GOES HERE
}

tenorA = \relative do'' {
  % MUSIC GOES HERE (tenor clef is treble_8)
}

bassA = \relative do' {
  % MUSIC GOES HERE
}

trebleB = \relative do'' {
  % MUSIC GOES HERE
  \bar ".."  % Standard ending
}

altoB = \relative do'' {
  % MUSIC GOES HERE
}

tenorB = \relative do'' {
  % MUSIC GOES HERE
}

bassB = \relative do' {
  % MUSIC GOES HERE
}

%%%%%%% TEXT %%%%%%%%%
trebleTextA = \lyricmode {
  \tiny
  \set stanza = "1."
  % Lyrics here
}

trebleTextB = \lyricmode {
  \tiny
  % Lyrics here
}

tenorTextA = \lyricmode {
  \tiny
  \set stanza = "2."
  % Lyrics here
}

tenorTextB = \lyricmode {
  \tiny
  % Lyrics here
}

%%%%%%%%% LAYOUT %%%%%%%%%%%
\score {
  % Global transpose: Change 'do' to target note for different keys
  % \transpose do sol {    % Uncomment and change 'sol' for G major, etc.
  \new ChoirStaff <<
    \new Staff = treble <<
      \new Voice = "treble" {
        \global
        \trebleA
        \trebleB
      }
      \new Lyrics \lyricsto "treble" { \trebleTextA \trebleTextB }
    >>

    \new Staff = alto <<
      \new Voice = "alto" {
        \global
        \altoA
        \altoB
      }
    >>

    \new Staff = tenor <<
      \new Voice = "tenor" {
        \global
        \tenorA
        \tenorB
      }
      \new Lyrics \lyricsto "tenor" { \tenorTextA \tenorTextB }
    >>

    \new Staff = bass <<
      \clef bass
      \new Voice = "bass" {
        \global
        \bassA
        \bassB
      }
    >>
  >>
  % } % Uncomment if using transpose
  \layout {
    indent = 0\cm
    \context {
      \Score
      \remove "Bar_number_engraver"
      \omit VoltaBracket
      \override RehearsalMark.self-alignment-X = #LEFT
      \override TimeSignature.break-visibility = ##(#f #t #t)
      \override NoteHead.font-size = #1
      startRepeatBarType = #";"
      endRepeatBarType = #";."
      doubleRepeatBarType = ";.;"
    }
  }
  \midi {
    \context {
      \Score
      tempoWholesPerMinute = #(ly:make-moment 96 2)
    }
  }
}
```

### Quick Scale Reference Template
```lilypond
\language "espanol"
\version "2.16.00"

trebleScale = \relative do'' {
  \key do \major
  \aikenHeads
  \omit TimeSignature
  \cadenzaOn
  do re mi fa sol la si do \bar "||"
}

bassScale = \relative do {
  \key do \major
  \aikenHeads
  \omit TimeSignature
  \cadenzaOn
  \clef bass
  do re mi fa sol la si do \bar "||"
}

\markup { \column {
  \score { \new Staff \trebleScale \layout { } }
  \score { \new Staff \bassScale \layout { } }
}}
```

## ERROR PATTERNS & FIXES

### Vertical Note Stacking
```
SYMPTOM: Notes appear stacked vertically instead of horizontally
CAUSE: Apostrophes within \relative block
FIX: Remove all apostrophes except the starting one

WRONG: \relative do' { do4 re' mi' fa' }
RIGHT: \relative do' { do4 re mi fa }
```

### Wrong Octaves
```
SYMPTOM: Notes in wrong octave range
CAUSE: Incorrect \relative starting pitch
COMMON FIXES:
- Treble: \relative do'' (or \relative sol')  
- Alto: \relative do' (or \relative sol)
- Tenor: \relative do' (with treble_8 clef)
- Bass: \relative do (with bass clef)
```

### Missing Shapes
```
SYMPTOM: Standard noteheads instead of shapes
CAUSE: Missing shape command in global
FIX: Add \aikenHeads or \sacredHarpHeads to global block
```

### Spanish Note Names Error
```
SYMPTOM: "c d e f g a b" not recognized
CAUSE: Missing \language "espanol"
FIX: Add \language "espanol" at top of file
NOTES: do re mi fa sol la si (not c d e f g a b)
SHARPS: fas dos sols (add 's')
FLATS: sib mib lab (add 'b')
```

## DECISION TREES

### Choosing Shape System
```
IF user mentions "Sacred Harp" OR "4-shape" OR southern US context
  → Use \sacredHarpHeads / \sacredHarpHeadsMinor
ELSE IF user mentions "Christian Harmony" OR "7-shape" OR "Aikin"
  → Use \aikenHeads / \aikenHeadsMinor
ELSE IF user mentions "compact" OR "small print"
  → Use \aikenThinHeads / \aikenThinHeadsMinor
ELSE (generic "shape notes")
  → Ask for clarification OR default to \aikenHeads
```

### Key Selection and Transposition
```
ALWAYS use solmization transposition system:

1. WRITING PHASE:
   → Always use \key do \major in global
   → Write using logical note names (si=si, do=do)

2. SOUNDING KEY:
   IF user specifies key (e.g., "G major", "F# minor")
     → Use \transpose do [target] in score
   ELSE IF no key specified
     → Default to \transpose do do (C major, no change)
     → Mention that key can be easily changed

3. TRANSPOSE TARGET MAPPING:
   C major: \transpose do do
   G major: \transpose do sol  
   F major: \transpose do fa
   D major: \transpose do re
   Bb major: \transpose do sib
   Etc.
```

### Clef Assignment
```
Treble: \clef treble
Alto: \clef treble  
Tenor: \clef "treble_8" (octave treble)
Bass: \clef bass
```

### Vocal Ranges and Starting Pitches

#### Sacred Harp Voice Ranges (Based on Repertoire Analysis)
**Data from 12 Sacred Harp songs, 3074 notes total**

```
TREBLE: Repertoire range D#4 to G5 (MIDI 63-79)
- \relative do'' standard starting point
- Sweet spot: A#4 to D5 (MIDI 70-74) - 50% of notes here
- WARNING range: Below G#4 (MIDI 68) or above E5 (MIDI 76)
- Average pitch: C5 (MIDI 72)

ALTO: Repertoire range A#3 to G5 (MIDI 58-79) 
- \relative do' standard starting point  
- Sweet spot: F4 to A4 (MIDI 65-69) - 50% of notes here
- WARNING range: Below D#4 (MIDI 63) or above B4 (MIDI 71)
- Average pitch: G4 (MIDI 67)
- Widest range (21 semitones) due to harmonic filling role

TENOR: Repertoire range D4 to A5 (MIDI 62-81)
- \relative do' standard starting point
- Sweet spot: G#4 to D5 (MIDI 68-74) - 50% of notes here  
- WARNING range: Below F#4 (MIDI 66) or above E5 (MIDI 76)
- Average pitch: B4 (MIDI 71)
- Should be melodic leader with wide range and jumps

BASS: Repertoire range G2 to C4 (MIDI 43-60)
- \relative do standard starting point
- Sweet spot: D3 to G3 (MIDI 50-55) - 50% of notes here
- CRITICAL: Never below G2 (MIDI 43) - too low to sing
- WARNING range: Below B2 (MIDI 47) or above A3 (MIDI 57)
- Average pitch: E3 (MIDI 52)
```

#### Template Starting Pitches (Always use \relative do)
```
Treble: \relative do' or \relative do'' (adjust octave for range)
Alto: \relative do' or \relative do'' (adjust octave for range)  
Tenor: \relative do' or \relative do'' (adjust octave for range, with treble_8 clef)
Bass: \relative do (with bass clef)

PRINCIPLE: Always start with \relative do, adjust octave (', '', etc.) for proper range
This keeps note names logical: si is always si, do is always do
```

## OCTAVE MANAGEMENT STRATEGY

### Core Problem
The `\relative` system makes octave jumps non-obvious, leading to voices ending up too high or too low. This system prevents octave confusion and reduces correction cycles.

### Standard Starting Points (MEMORISE THESE)
```
TREBLE: \relative do''  - High soprano range
ALTO:   \relative do'   - Middle alto range  
TENOR:  \relative do'   - Comfortable tenor range
BASS:   \relative do    - Standard bass range
```

### Octave Checkpoint Rules
```
WHEN TO EXPECT OCTAVE MARKERS:

Treble (\relative do''):
- Use , (comma) for notes below the staff: si, la, sol,
- Use ' (apostrophe) sparingly, only for very high passages
- DANGER SIGN: If you need '' (double apostrophe), check starting octave

Alto (\relative do'):
- Should rarely need octave markers in normal passages
- Use ' for occasional high notes (above staff)
- DANGER SIGN: If you need , (comma), probably wrong starting octave

Tenor (\relative do'):
- May need occasional ' for high passages
- Should rarely need , (comma)
- DANGER SIGN: Frequent ' usage suggests wrong starting octave

Bass (\relative do):
- May need occasional ' for higher passages
- Should NEVER need , (comma) - this puts notes too low to sing
- DANGER SIGN: Any , (comma) usage indicates octave error
```

### Visual Staff Position Reference
```
TREBLE CLEF (\relative do''):
do'' = middle of staff (3rd line)
si, = below staff (comfortable low)
do''' = high above staff (use sparingly)

ALTO CLEF (\relative do'):
do' = just below staff (comfortable low)
sol' = top of staff (comfortable high)
do'' = above staff (occasional use)

TENOR CLEF (\relative do'):
do' = middle of staff (comfortable)
sol' = top of staff (comfortable high)
do = below staff (comfortable low)

BASS CLEF (\relative do):
do = middle of staff (comfortable)
sol = bottom of staff (comfortable low)
do' = above staff (comfortable high)
```

### Octave Safety Rules
```
1. IF bass needs ' more than twice per phrase → check starting octave
2. IF alto needs any , (comma) → wrong starting octave
3. IF treble needs frequent , (comma) → possibly too high starting octave
4. IF tenor needs frequent ' → possibly too low starting octave
5. IF any voice has awkward jumps → check for octave marker errors

EMERGENCY FIXES:
- Too high overall? Lower the \relative starting point (do'' → do')
- Too low overall? Raise the \relative starting point (do → do')
- Octave jumps? Check for missing or extra ' and , markers
```

### Common Error Patterns
```
WRONG: si,4 si4 (octave jump down then up)
RIGHT: si4 si4 (consistent octave)

WRONG: do'4 do4 (octave jump up then down)  
RIGHT: do4 do4 (consistent octave)

WRONG: Bass with la,4 si,4 (too low, multiple ledger lines)
RIGHT: Bass with la4 si4 (comfortable bass range)

WRONG: Alto with sol'4 sol4 (erratic octave jumping)
RIGHT: Alto with sol4 sol4 (consistent range)
```

### Troubleshooting Decision Tree
```
IF voice sounds too high:
  1. Remove ' markers first
  2. If still too high, lower \relative starting point
  3. Add , markers only if absolutely necessary

IF voice sounds too low:  
  1. Remove , markers first
  2. If still too low, raise \relative starting point
  3. Add ' markers as needed

IF voice has awkward jumps:
  1. Check for octave markers causing jumps
  2. Ensure consistent \relative usage throughout
  3. Verify octave markers match intended pitches
```

## SOLMIZATION TRANSPOSITION SYSTEM

### Core Principle
**Write in C major using solmization note names, transpose globally for different keys.**

This approach ensures:
- Note names in code match shape names on PDF  
- `si4 si4 la4 sol4` displays as si-si-la-sol shapes
- Easy key changes without rewriting music
- Consistent, logical notation system

### Implementation
```lilypond
global = {
  \key do \major    % Always C major for writing
  \aikenHeads       % or \sacredHarpHeads
  % other settings
}

\score {
  % Global transpose: Change target note for different keys
  \transpose do sol {    % C to G major
    \new ChoirStaff <<
      % All music here
    >>
  } % End transpose
  \layout { ... }
}
```

### Key Change Reference
```
\transpose do do     % C major (no change)
\transpose do re     % D major
\transpose do mi     % E major  
\transpose do fa     % F major
\transpose do sol    % G major
\transpose do la     % A major
\transpose do si     % B major

% For flats, use appropriate note names:
\transpose do sib    % Bb major
\transpose do mib    % Eb major
\transpose do lab    % Ab major
```

### Benefits Over Key-Specific Writing
```
OLD WAY (key-specific):
\key sol \major           % G major
sol4 sol4 fas4 sol4      % Shows as do-do-si-do shapes (confusing!)

NEW WAY (solmization + transpose):
\key do \major           % C major for writing
sol4 sol4 fas4 sol4      % Shows as sol-sol-fas-sol shapes (logical!)
\transpose do sol { ... } % Sounds in G major
```

## SHAPE-TO-SCALE MAPPING

### 4-Shape System (Sacred Harp)
```
fa (triangle): scale degrees 1, 4
sol (oval): scale degrees 2, 5
la (rectangle): scale degrees 3, 6  
mi (diamond): scale degree 7
```

### 7-Shape System (Aikin/Christian Harmony)
```
do (triangle): scale degree 1
re (half-moon): scale degree 2
mi (diamond): scale degree 3
fa (triangle): scale degree 4
sol (oval): scale degree 5
la (rectangle): scale degree 6
si/ti (quarter-note): scale degree 7
```

## ADVANCED FEATURES

### Repeats and Barlines (Sacred Harp Style)
```lilypond
% All barline definitions (required in global)
\defineBarLine ";" #'("|" ";" " ")
\defineBarLine ";." #'("|" ";." ";.")
\defineBarLine ".;" #'("|" ".;" ".;")
\defineBarLine ".." #'(".." ".." "..")
\defineBarLine ";.." #'(";.." ";.." ";..")
\defineBarLine ";.;" #'(";.;" ";.;" ";.;")

% Usage in music
\bar ";"      % Beginning repeat (mid-bar)
\bar ".;"     % Beginning repeat (on barline)
\bar ";."     % Ending repeat
\bar ";.;"    % Double repeat
\bar ".."     % Standard ending
\bar ";.."    % Ending with repeat option

% With volta repeats
\repeat volta 2 {
  \bar ";"    % Beginning repeat
  % music
}

% Line breaks
\break        % Force line break after A section
```

### Lyrics Structure (Sacred Harp Convention)
```lilypond
% Separate lyrics for each voice and section
trebleTextA = \lyricmode {
  \tiny
  \set stanza = "1."  % Verse number
  % A section lyrics under treble
}

trebleTextB = \lyricmode {
  \tiny
  % B section lyrics under treble
}

tenorTextA = \lyricmode {
  \tiny
  \set stanza = "2."  % Different verse on tenor
  % A section lyrics under tenor
}

tenorTextB = \lyricmode {
  \tiny
  % B section lyrics under tenor
}

% Multiple verses on same voice
trebleTextATwo = \lyricmode {
  \tiny
  % Second verse for treble A section
}

% Apply in score
\new Lyrics \lyricsto "treble" { \trebleTextA \trebleTextB }
\new Lyrics \lyricsto "treble" { \trebleTextATwo }  % Second verse
\new Lyrics \lyricsto "tenor" { \tenorTextA \tenorTextB }

% Skip beats for lyrics that start later
\new Lyrics \lyricsto "treble" { 
  \repeat unfold 8 { \skip 1 } \trebleTextB  % Skip 8 beats then start B lyrics
}
```

### MIDI and Transposition
```lilypond
% MIDI tempo setting
\midi {
  \context {
    \Score
    tempoWholesPerMinute = #(ly:make-moment 96 2)  % 96 half notes per minute
  }
}

% Transposition (in voice, not global)
\new Voice = "treble" {
  \global
  \transpose do fa {  % From C to F
    \trebleA
    \trebleB
  }
}

% Alternative ending patterns
\alternative {
  { \set Timing.measureLength = #(ly:make-moment 3/4) 
    \mark \markup \bold \tiny "1." 
    mi2. \bar ";." }
  { \set Timing.measureLength = #(ly:make-moment 6/4) 
    \mark \markup \bold \tiny "2." 
    mi1. \bar ".." }
}
```

## LAYOUT SHORTCUTS

### Hide Elements
```lilypond
\omit TimeSignature        % Hide time signature
\omit BarLine             % Hide bar lines
\cadenzaOn                % Free rhythm mode
```

### Paper Settings
```lilypond
\paper {
  page-count = #1
  system-count = #2
  ragged-last = ##t
  ragged-bottom = ##t
  system-system-spacing = #'((basic-distance . 0) (padding . 6))
  top-margin = 0.5\in
}
```

### Layout Context (Sacred Harp Template Standard)
```lilypond
\layout {
  indent = 0\cm
  \context {
    \Score
    \remove "Bar_number_engraver"
    \omit VoltaBracket
    \override RehearsalMark.self-alignment-X = #LEFT
    \override TimeSignature.break-visibility = ##(#f #t #t)
    \override NoteHead.font-size = #1
    startRepeatBarType = #";"     % Mid-bar repeat start
    endRepeatBarType = #";."      % Repeat end
    doubleRepeatBarType = ";.;"   % Double repeat
  }
}
```

### Custom Shapes (Advanced)
```lilypond
% Custom shape set
\set shapeNoteStyles = ##(do re mi fa sol la ti)

% Mixed standard/custom
\set shapeNoteStyles = ##(cross triangle fa #f mensural xcircle diamond)
```

## SACRED HARP HARMONY REFERENCE

## SACRED HARP HARMONY REFERENCE

### Major Key Chord Usage (Do-based)

#### COMMON (Use Freely)
```
I:  do mi sol
vi: la do mi  
V:  sol si re
```

#### QUITE COMMON (Use Moderately)
```
ii: re fa la
IV: fa la do
```

#### RARE (Use Sparingly)
```
iii: mi sol si
```

#### DON'T USE
```
vii°: si re fa  (AVOID)
```

### Minor Key Chord Usage (La-based)

#### COMMON (Use Freely)
```
i:   la do mi
VII: sol si re
III: do mi sol
```

#### QUITE COMMON (Use Moderately)  
```
v:  mi sol si
iv: re fa la
```

#### DON'T USE
```
ii°: si re fa   (AVOID)
VI:  fa la do   (AVOID)
```

### Harmonic Decision Tree for Claude
```
When harmonising a melody:

1. MAJOR KEY PROGRESSIONS:
   Primary: I - vi - V - I
   Secondary: I - IV - V - I
   Avoid: vii° entirely

2. MINOR KEY PROGRESSIONS:
   Primary: i - VII - III - i
   Secondary: i - iv - v - i  
   Avoid: ii° and VI entirely

3. CHORD SELECTION PRIORITY:
   First choice: Common chords
   Second choice: Quite common chords
   Rare: Only for special colour
   Never: Forbidden chords (vii°, ii°, VI in minor)
```

### Harmonic Principles for Claude
- **Dissonance**: Adjacent scale degrees (do-re, mi-fa) create instability, avoid in Sacred Harp
- **Consonance**: Notes with one scale degree between (do-mi, fa-la) sound pleasant
- **Dyads**: Two-note chords sound "open and folk-y", common in Sacred Harp
- **Triads**: Three-note chords, alto often completes dyads into triads
- **Bass foundation**: Usually takes chord root, but can cross above tenor when tenor is low

### Part-Writing Order and Character
```
Write in this order: TENOR → BASS → TREBLE → ALTO

TENOR: 
- Wide range, steps and jumps
- "Flight of fancy" (Billings)
- Exploratory, melodic leader
- Range: D4 to A5, average B4

BASS:
- Foundation, not boring - frequent jumps especially at phrase ends
- Harmonic foundation but with melodic interest
- Can cross above tenor when tenor is low
- Always ends on key note (do)
- CRITICAL: Never below G2 (MIDI 43), sweet spot D3-G3
- Use melodic motion: sol-do-la patterns, not static do-do-do

TREBLE:
- Mirror to tenor in contrary motion  
- Higher centre, winds around tune
- Balances tenor's movement
- Range: D#4 to G5, average C5

ALTO:
- Almost never jumps, moves in steps
- Widest overall range but stepwise motion
- Adds harmonic colour, completes dyads into triads
- Neither too complex nor too dull
- Range: A#3 to G5, average G4
```

### Practical Harmonisation Examples
```lilypond
% MAJOR KEY PROGRESSION: I - vi - IV - V - I
% Melody in tenor: do - la - fa - sol - do

trebleA = \relative do'' {
  sol4 mi4 la4 si4 sol4     % Contrary motion to tenor, range G4-B4
}
altoA = \relative do' {  
  mi4 do4 fa4 re4 mi4       % Stepwise filling, range C4-F4
}
tenorA = \relative do' {
  do4 la4 fa4 sol4 do4      % Given melody, range F4-C5
}
bassA = \relative do {
  do4 la,4 fa4 sol4 do4     % Roots with melodic interest, range A2-C4
}

% BASS CHARACTER EXAMPLE: Avoid boring static patterns
% WRONG (boring):
bassWrong = \relative do { do2 do4 do | do2 do4 do | }
% RIGHT (melodic foundation):
bassRight = \relative do { do2 do4 la, | sol,2 sol4 do | }

% Range-safe bass writing in D3-A3 sweet spot:
bassSweet = \relative do {
  sol4 do4 la,4 sol4 |      % G3-C4-A3-G3 - all in sweet spot
  do4 sol4 do4 sol4 |       % Melodic but foundational
}
```

### Common Progressions for Quick Reference
```
MAJOR KEY:
I - vi - V - I        (do-la-sol-do bass line)
I - IV - V - I        (do-fa-sol-do bass line)  
I - vi - ii - V - I   (do-la-re-sol-do bass line)

MINOR KEY:
i - VII - III - i     (la-sol-do-la bass line)
i - iv - v - i        (la-re-mi-la bass line)
i - VII - iv - i      (la-sol-re-la bass line)
```

### Chord Voicing Examples
```lilypond
% MAJOR KEY COMMON CHORDS

% I chord (do mi sol) - most stable
treble: sol4  alto: mi4  tenor: do4  bass: do4   % Root position
treble: do'4  alto: sol4  tenor: mi4  bass: mi4  % First inversion

% vi chord (la do mi) - relative minor feel  
treble: mi4   alto: do4  tenor: la4  bass: la4   % Root position
treble: la4   alto: mi4  tenor: do4  bass: do4   % First inversion to I

% V chord (sol si re) - dominant, wants to resolve to I
treble: re'4  alto: si4  tenor: sol4 bass: sol4  % Root position
treble: si4   alto: re4  tenor: sol4 bass: sol4  % Leading tone in treble

% MINOR KEY COMMON CHORDS

% i chord (la do mi) - tonic in minor
treble: mi4   alto: do4  tenor: la4  bass: la4   % Root position

% VII chord (sol si re) - subtonic, common in minor
treble: re4   alto: si4  tenor: sol4 bass: sol4  % Root position

% III chord (do mi sol) - relative major
treble: sol4  alto: mi4  tenor: do4  bass: do4   % Same as major I

% AVOID THESE ENTIRELY:
% vii° (si re fa) - diminished, too unstable
% ii° (si re fa) - diminished in minor  
% VI (fa la do) - rare in Sacred Harp minor
```

## IMPORTANT TEMPLATE INSIGHTS

### Template Commenting System
```lilypond
% Uncomment patterns in template:
% \repeat volta 2{      % Uncomment to repeat A section
% \bar ";"              % Uncomment if repeating
% \break                % Uncomment for line break after A
% }                     % Uncomment if repeating

% \transpose do fa {    % Uncomment if transposing
% }                     % Uncomment if transposing
```

### Staff Structure (No instrumentName)
```lilypond
% Template uses simple staff structure, not \with instrumentName
\new Staff = treble <<
  \new Voice = "treble" { \global \trebleA \trebleB }
  \new Lyrics \lyricsto "treble" { \trebleTextA \trebleTextB }
>>

\new Staff = tenor <<  % No treble_8 clef in voice definition
  \new Voice = "tenor" { \global \tenorA \tenorB }  % clef handled by global
  \new Lyrics \lyricsto "tenor" { \tenorTextA \tenorTextB }
>>

\new Staff = bass <<
  \clef bass             % Bass clef explicitly set on staff
  \new Voice = "bass" { \global \bassA \bassB }
>>
```

### Octave Doubling in Bass
```lilypond
% Template uses octave doubling for strong bass notes
<do do,>2    % Current octave + octave below
<do' do,>1   % Octave above + octave below
```

### File Extensions
- `.ly` - LilyPond source files
- `.pdf` - Compiled output
- `.midi` - Audio output

## AUTOMATED HARMONIC FEEDBACK SYSTEM

### Overview
The Sacred Harp analyzer script provides real-time harmonic feedback by analyzing MIDI output from LilyPond compilation. Uses real Sacred Harp repertoire data (12 songs, 3074 notes) for accurate range checking.

### System Setup
```bash
# Install requirements (use uv in this project)
uv add music21

# Run analyzer on MIDI file
uv run sacred_harp_analyzer.py song.midi harmony.log

# WITH LILYPOND SOURCE MAPPING (Enhanced Mode)
uv run sacred_harp_analyzer.py song.midi harmony.log song.ly

# Watch for MIDI changes (auto-reanalyze when LilyPond compiles)
uv run sacred_harp_analyzer.py --watch song.midi harmony.log song.ly
```

### How Claude Should Use This System
```
1. AFTER writing/modifying LilyPond music:
   - Compile LilyPond file (generates MIDI)
   - Run analyzer with LilyPond source: uv run sacred_harp_analyzer.py song.midi harmony.log song.ly
   - Use `tail -n 20 harmony.log` to read recent feedback with precise locations
   - Apply corrections based on harmonic analysis and location information

2. INTERPRET LOG FEEDBACK (Enhanced with Source Locations):
   - "FORBIDDEN": Immediately fix (vii°, ii° in minor, VI in minor)
   - "CRITICAL": Fix immediately (bass below G2)
   - "EXTREME": Outside all repertoire ranges - includes exact line numbers
   - "SUSTAINED FATIGUE": 5+ notes in extreme range within 8 beats - will tire singers
   - "FATIGUE WARNING": 4+ consecutive extreme notes - may strain singers
   - Adjacent scale degrees: si-do, do-re, mi-fa create dissonance

3. ENHANCED SOURCE LOCATION FEEDBACK:
   Each warning now includes:
   - Voice section (bassA, bassB, trebleA, etc.)
   - Approximate line number in LilyPond source
   - Code context showing surrounding lines
   - Specific fix suggestions for the problem type

4. SELF-CORRECTION WORKFLOW:
   - Read harmony.log after each compilation
   - Use line numbers to locate exact problems in source
   - Fix FORBIDDEN and CRITICAL issues first using provided context
   - Address SUSTAINED FATIGUE with location-specific fixes

5. FIXING SUSTAINED FATIGUE:
   Option A: TRANSPOSE ENTIRE PIECE
   - If bass consistently too high: transpose down (do → sib, do → lab)
   - If treble consistently too low: transpose up (do → re, do → mi)
   - Use \transpose in score: \transpose do sib { ... }
   - CAUTION: May fix one voice but create problems in others
   - Test all voices after transposing - might make treble too low or alto too high
   
   Option B: REWRITE PROBLEMATIC SECTIONS (Usually Better)
   - Use provided line numbers to locate exact problems
   - Move bass notes down an octave: do4 → do  
   - Use voice crossing: let bass go above tenor when tenor is low
   - Redistribute harmony: move high bass notes to tenor
   - Change chord inversions to put bass in lower register
   - ADVANTAGE: Fixes specific problems without affecting other voices
```

### Automated Feedback Examples

#### Basic Feedback (without LilyPond source)
```
2025-07-29 14:30:15: Bar 3, Beat 1: vii° (7-2-4) - FORBIDDEN: vii° chord FORBIDDEN in Sacred Harp style
2025-07-29 14:30:15: VOICE LEADING WARNING: Bar 2, Beat 3: Adjacent scale degrees do-re create dissonance
2025-07-29 14:30:15: VOICE LEADING WARNING: SUSTAINED FATIGUE: Bass spends 7 of 8 beats in top 10% range (bars 8-9) - may tire singers
2025-07-29 14:30:15: VOICE LEADING WARNING: FATIGUE WARNING: Tenor has 4 consecutive high notes (bars 9-11) - may strain singers
2025-07-29 14:30:15: Bar 5, Beat 2: CRITICAL: Bass note F2 (MIDI 41) is too low to sing! Never go below G2.
2025-07-29 14:30:15: PROGRESSION: I - vi - vii° - I
2025-07-29 14:30:15: ERROR: Forbidden vii° chord found in progression
```

#### Enhanced Feedback (with LilyPond source mapping)
```
2025-07-29 13:12:43: VOICE LEADING WARNING: Bar 3, Beat 3: EXTREME: Bass note C5 (MIDI 72) is above any note found in Sacred Harp repertoire.
→ Location: bassA section, approximately line 165 in ed_bass_revised.ly
→ Context:
  Line 162:   %\bar ";"		% Uncomment if repeating
  Line 163: 
  Line 164:   % MUSIC GOES HERE - melodic bass with variety
→ Line 165:   r2
  Line 166: 
  Line 167:   do' |                  % C4 - strong opening, occasional high note OK
  Line 168:   sol do4 do |           % G3 C3 C3 - mix of ranges
→ Fix suggestion: Lower note by octave or transpose passage down

2025-07-29 13:12:43: Bar 4, Beat 1: vii° (7-2-4) - FORBIDDEN: vii° chord FORBIDDEN in Sacred Harp style
→ Fix suggestion: Replace with V chord (sol-si-re) or vi chord (la-do-mi)

2025-07-29 13:12:43: VOICE LEADING WARNING: Bar 2, Beat 3: Adjacent scale degrees do-re create dissonance
→ Fix suggestion: Brief passing dissonance is acceptable, but avoid sustaining both notes
```

### Integration with Existing Harmony Rules
The analyzer implements all chord rules from the Sacred Harp Harmony Reference section:

**Automated Detection of:**
- Forbidden chords (vii°, ii° in minor, VI in minor)
- Adjacent scale degree dissonance (do-re, mi-fa, si-do)
- Vocal range violations using real repertoire data
- Voice crossings (bass above tenor noted but acceptable)
- Lack of contrary motion between treble and tenor

### Claude's Response to Feedback
```
WHEN Claude receives "FORBIDDEN" or "CRITICAL" feedback:
1. IMMEDIATELY fix - forbidden chords or unsingable bass notes
2. MAINTAIN bass resolution to tonic and melodic interest
3. PRESERVE voice leading where possible
4. RECOMPILE and check harmony.log again

WHEN Claude receives "SUSTAINED FATIGUE" feedback:
1. EVALUATE if problem affects entire piece or just sections
2. If widespread: consider transposing entire piece up/down
3. If localized: rewrite problematic passages
4. OPTIONS: octave shifts, voice crossing, chord inversions
5. GOAL: Keep exciting moments, avoid extended strain

WHEN Claude receives "FATIGUE WARNING" feedback:
1. ACCEPTABLE for climactic or expressive moments
2. AVOID in opening or extended passages
3. BALANCE challenge with singability
4. CONSIDER if warning enhances or detracts from musical effect

WHEN Claude receives adjacent scale degrees:
1. ACCEPTABLE for brief passing moments
2. AVOID sustained do-re, mi-fa, or si-do combinations
3. OFTEN occurs at cadences and can add harmonic color
```

### Log File Monitoring Commands
```bash
# Read latest feedback
tail -n 10 harmony.log

# Watch log in real-time (if needed)
tail -f harmony.log

# Search for specific issues
grep "FORBIDDEN" harmony.log
grep "CRITICAL" harmony.log
grep "WARNING" harmony.log
grep "EXTREME" harmony.log
grep "PROGRESSION" harmony.log

# Count range warnings by voice
grep "WARNING:.*Bass" harmony.log | wc -l
grep "WARNING:.*Treble" harmony.log | wc -l
```

### Sacred Harp Specific Analysis Features
- **Fatigue-aware range analysis** (sustained extreme singing detection)
- **Real repertoire vocal ranges** (12 songs, 3074 notes analyzed)
- **Sliding window analysis** (8-beat windows detect sustained strain)
- **Contextual warnings** (occasional extreme notes OK, sustained strain flagged)
- **Octave doubling detection** (bass `<do do,>` patterns)
- **Incomplete chord recognition** (do-sol dyads, etc.)
- **Voice crossing tolerance** (bass above tenor acceptable)
- **C major solmization analysis** (works with transpose system)
- **Problem-focused logging** (no noise from acceptable choices)
- **LilyPond source mapping** (voice sections, line numbers, code context)
- **Composition agent integration** (precise locations for automated fixes)
- **Enhanced fix suggestions** (octave changes, chord substitutions, voice leading)

## ENHANCED SOURCE LOCATION MAPPING (v2.0)

### Composition Agent Integration
The enhanced analyzer provides precise LilyPond source locations for automated composition assistance:

#### Voice Section Detection
- Automatically parses `bassA`, `bassB`, `trebleA`, `trebleB`, etc. sections
- Maps MIDI timing to specific voice sections and approximate line numbers
- Handles A/B section boundaries and repeats

#### Location Format
```
→ Location: bassA section, approximately line 169 in ed_bass_revised.ly
→ Context:
  Line 167:   do' |                  % C4 - strong opening
→ Line 169:   la2 do'4 sol |         % A3 C4 G3 - strategic high note  
  Line 170:   do2 la4 la |           % C3 A3 A3 - comfortable but not static
→ Fix suggestion: Change note to higher octave or transpose passage up
```

#### Usage for Automated Editing
```bash
# Generate MIDI and get source locations
lilypond song.ly
uv run sacred_harp_analyzer.py song.midi harmony.log song.ly

# Parse locations for automated fixes
grep "Location:" harmony.log
grep "Line.*:" harmony.log
```

#### Supported Voice Section Names
```
bassA, bassB          - Bass voice A and B sections
trebleA, trebleB      - Treble voice A and B sections  
altoA, altoB          - Alto voice A and B sections
tenorA, tenorB        - Tenor voice A and B sections
```

#### Section Timing Estimation
- A section: 0 to midpoint of piece
- B section: midpoint to end of piece
- Handles irregular section lengths
- Maps beats within sections to approximate line numbers

### Most Common User Requests
1. "Create a shape note version of [song]" → Use template + ask for melody
2. "Show me the scales" → Use scale template
3. "Fix my LilyPond code" → Check error patterns above, use enhanced analyzer
4. "What's the difference between systems?" → Reference shape mapping section
5. "Find problems in my composition" → Use enhanced analyzer with source mapping