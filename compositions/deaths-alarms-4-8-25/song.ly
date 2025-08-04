\language "espanol"
\version "2.24.0"
#(set-default-paper-size "a4landscape")

%%%%%% Sacred Harp Simplified Template v1.0 %%%%%%
% Ed Johnson-Williams - Fast typesetting from paper
%
% HOW TO USE THIS TEMPLATE:
% 1. Change songKey (line 39) to set the key - examples provided
% 2. Update song info (lines 40-42): title, meter, composer
% 3. Update meter = "G Major" (line 54) to show the key name
% 4. Enter music in the four voice sections (always in C major)
% 5. Add lyrics to verseOne and verseTwo sections

%
% QUICK TIPS:
% - Always write music as if in C major (do, re, mi, fa, sol, la, si)
% - The transpose happens automatically based on songKey
% - All parts sing same lyrics - placement under treble/tenor for good spacing
% - For minor keys: set songKey AND uncomment \minor in global
%
% KEY TRANSPOSITION EXAMPLES (change on line 43):
% C major:  \transpose do do    (no change - default)
% G major:  \transpose do sol
% F major:  \transpose do fa
% D major:  \transpose do re
% Bb major: \transpose do sib
% Eb major: \transpose do mib
% A major:  \transpose do la
%
% MINOR KEYS (relative minor approach):
% F# minor: songKey = la    (writes in C major, transposes to A major)
% C# minor: songKey = mi    (writes in C major, transposes to E major)
% G# minor: songKey = si    (writes in C major, transposes to B major)
% D# minor: songKey = fis   (writes in C major, transposes to F# major)
% A minor:  songKey = do    (writes in C major, stays in C major)
% E minor:  songKey = sol   (writes in C major, transposes to G major)
% B minor:  songKey = re    (writes in C major, transposes to D major)
% G minor:  songKey = sib   (writes in C major, transposes to Bb major)
% D minor:  songKey = fa    (writes in C major, transposes to F major)

%%%%%% QUICK SETTINGS %%%%%%
songKey = la % Change this to set key (see examples above)
songTitle = "Death's Alarms"
songMeter = "CM"
songComposer = "Ed Johnson-Williams, 4 August 2025"

\paper {
  page-count = #1
  system-count = #2
  system-system-spacing = #'((basic-distance . 0) (padding . 6))
  top-margin = 0.5\in
}

\header {
  title = \markup{ \bold \smaller #songTitle "   " \small{#songMeter }}
  arranger = #songComposer
  meter = "G Minor"  % Update this manually to match songKey
  tagline = ##f
}

global = {
  \key do \major  % Don't remove the `\major` here – even for minor tunes
  %\minor        % Uncomment here for minor keys
  \aikenHeads     % or \sacredHarpHeads for 4-shape
  \numericTimeSignature
  \time 4/4       % Change as needed
  \defineBarLine ";" #'("|" ";" " ")
  \defineBarLine ";." #'("|" ";." ";.")
  \defineBarLine ".;" #'("|" ".;" ".;")
  \defineBarLine ".." #'(".." ".." "..")
  \defineBarLine ";.." #'(";.." ";.." ";..")
  \defineBarLine ";.;" #'(";.;" ";.;" ";.;")
  \autoBeamOff

}

%%%%%%% MUSIC %%%%%%%%%
% Write all music in C major (do, re, mi, fa, sol, la, si)
% The songKey transpose will handle the actual key
%
% HELPFUL PATTERNS:
% Repeats:     \repeat volta 2 { music }
% Mid-bar:     \bar ";"
% Line break:  \break (after A section)
% Slurs:       do8[re8] or do4(re4)
% Ties:        do4~ do4

trebleMusic = \relative do' {
  % === A SECTION ===
  mi1|
  la4 sol mi do8[si8] |
  do4 mi sol mi8[sol8] |
  la4 mi sol do4 |
  si2. la4 |
  sol4. mi8 sol4 mi |
  do8[mi8] sol4 sol4 mi4|
  mi2 do8([re8] mi4) |
  mi2 sol2|
  la1

  % === B SECTION ===
  % Add B section music here
  \bar ".."
}

altoMusic = \relative do' {
  % === A SECTION ===
  do1|
  do4 mi8[re8] do4 mi |
  do4 sol sol do4 |
  do4 do mi8[re8] do4 |
  re2. do4 |
  mi4. do8 re4 do8[mi8] |
  do4 sol4 sol4 sol4|
  do2 la4 (do4) |
  do2 si|
  do1


  % === B SECTION ===
  % Add B section music here
}

tenorMusic = \relative do'' {
  % === A SECTION ===
  la,1|
  mi'4 do la do |
  mi mi8[re8] mi4 sol |
  mi do do mi |
  sol2. la4 |
  sol4. mi8 re4 do |
  sol' sol8[mi8] re4
  mi4|
  do(mi) mi2 |
  sol4(mi) mi2|
  la,1

  % === B SECTION ===
  % Add B section music here
  \bar "|."
}

bassMusic = \relative do {
  % === A SECTION ===

  <la la,>1|
  la4 do la sol |
  la sol4 do4 do |
  la sol mi sol |
  sol2. la4 |
  sol4. mi8 sol4 la |
  do do sol4
  mi4 |
  sol(la) la2 |
  mi2 mi2|
  <la la,>1
  % === B SECTION ===
  % Add B section music here
}

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  % Verse 1 lyrics
  Why do we mourn de -- par -- ting friends,
  Or shake at death’s a -- larms?
  ’Tis but the voice that Je -- sus sends,
  To call them to His arms.
}

verseTwo = \lyricmode {
  \tiny
  % Verse 2 lyrics

  Why should we trem -- ble to con -- vey
  Their bod -- ies to the tomb?
  There the dear flesh of Je -- sus lay,
  And va -- nished all the gloom.
}

% Additional verses if needed
verseThree = \lyricmode {
  \tiny
  % Verse 3 lyrics if needed
  Thence He arose, a -- scend -- ed high,
  And showed our feet the way;
  Up to the Lord our souls shall fly,
  At the great ris -- ing day.
}

verseFour = \lyricmode {
  \tiny
  % Verse 4 lyrics if needed
}

%%%%%%% SCORE %%%%%%%%%
% Main music content (defined once, used for both print and MIDI)
musicContent = {
  \new ChoirStaff <<
    \new Staff = treble <<
      \new Voice = "treble" {
        \global
        \trebleMusic
      }
      \new Lyrics \lyricsto "treble" { \set stanza = "1." \verseOne }
      % Uncomment for additional verses under treble:
      % \new Lyrics \lyricsto "treble" { \set stanza = "3." \verseThree }
    >>

    \new Staff = alto <<
      \new Voice = "alto" {
        \global
        \altoMusic
      }
      % Uncomment for verse 2 under alto (common pattern):
      % \new Lyrics \lyricsto "alto" { \set stanza = "2." \verseTwo }
    >>

    \new Staff = tenor <<
      \new Voice = "tenor" {
        \global
        \tenorMusic
      }
      \new Lyrics \lyricsto "tenor" { \set stanza = "2." \verseTwo }
      % Uncomment for verse 3 under tenor:
      % \new Lyrics \lyricsto "tenor" { \set stanza = "3." \verseThree }
    >>

    \new Staff = bass <<
      \clef bass
      \new Voice = "bass" {
        \global
        \bassMusic
      }
      % Uncomment for lyrics under bass (less common):
      % \new Lyrics \lyricsto "bass" { \set stanza = "4." \verseFour }
    >>
  >>
}

% Score for printing
\score {
  % SINGLE TRANSPOSE for all voices - change songKey at top
  \transpose do \songKey {
    \musicContent
  }

  \layout {
    indent = 0\cm
    \context {
      \Score
      \remove "Bar_number_engraver"
      \omit VoltaBracket
      \override TimeSignature.break-visibility = ##(#f #t #t)
      \override NoteHead.font-size = #1
      startRepeatBarType = #";"
      endRepeatBarType = #";."
      doubleRepeatBarType = ";.;"
    }
  }
}

% Score for MIDI (reuses musicContent with octave doubling)
\score {
  \transpose do \songKey {
    <<
      \musicContent
      % Octave doubling for richer MIDI sound
      \new Staff {
        \set Staff.instrumentName = "Treble Low"

        \global \transpose do do, { \trebleMusic }
      }
      \new Staff {
        \set Staff.instrumentName = "Tenor Low"
        \global \transpose do do, { \tenorMusic }
      }
    >>
  }

  \midi {
    \context {
      \Score
      tempoWholesPerMinute = #(ly:make-moment 100 4)
    }
    \context {
      \Staff
      midiInstrument = #"acoustic grand"
    }
  }
}

