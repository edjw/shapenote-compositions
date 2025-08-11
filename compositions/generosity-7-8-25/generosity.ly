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
% KEY TRANSPOSITION EXAMPLES (change in ONE place only):
% C major:  \transpose do do    (no change - default)
% G major:  \transpose do sol
% F major:  \transpose do fa
% D major:  \transpose do re
% Bb major: \transpose do sib
% Eb major: \transpose do mib
% A major:  \transpose do la
%
% MINOR KEYS:
% A minor:  \transpose do la   (then use \minor in global)
% E minor:  \transpose do mi   (then use \minor in global)
% D minor:  \transpose do re   (then use \minor in global)
% C minor:  \transpose do do   (then use \minor in global)
% G minor:  \transpose do sol  (then use \minor in global)

%%%%%% QUICK SETTINGS %%%%%%
songKey = sol  % Change this to set key (see examples above)
songTitle = "Generosity"
songMeter = "LM"
songComposer = "Ed Johnson-Williams, 7 August 2025"

\paper {
  page-count = #1
  system-count = #2
  system-system-spacing = #'((basic-distance . 0) (padding . 6))
  top-margin = 0.5\in
}

\header {
  title = \markup{ \bold \smaller #songTitle "   " \small{#songMeter }}
  arranger = #songComposer
  meter = "G Major"  % Update this manually to match songKey
  tagline = ##f
}

global = {
  \key do \major
  %\minor        % Uncomment for minor keys but leave the \major aboe
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

  r2. mi4 |
  sol mi mi8([re]) do4 |
  si4 do do sol' |
  sol4 mi sol sol |
  do si8([la]) sol2 |
  sol2 sol8([mi]) do8([re]) |
  mi4 sol do4 sol |
  mi2 sol2 |
  mi4 sol sol la |
  sol8([fa]) mi4 sol2



  % === B SECTION ===
  % Add B section music here
  \bar ".."
}

altoMusic = \relative do' {
  % === A SECTION ===
  r2. sol4 |
  do do do sol |
  sol la sol do |
  si la sol do8([si]) |
  la4 sol sol2 |
  sol2 do4 do8([re]) |
  do4 do do re |
  do2 sol2 |
  do4 mi do do |
  si do4 do2


  % === B SECTION ===
  % Add B section music here
}

tenorMusic = \relative do' {
  % === A SECTION ===
  r2. mi4 |
  do do8([re]) mi4 mi |
  re mi8([re8]) do4 sol |
  sol' la8([sol]) mi4 do8([re])|
  mi4 re re2 |
  re4.(mi8) sol4 sol8([la]) |
  sol4 mi sol sol8([la]) |
  sol2 do, |
  do4 do8([re]) mi4 fa8([mi8]) |
  re8([fa8]) mi8([re8]) do2


  % === B SECTION ===
  % Add B section music here
  \bar "|."
}

bassMusic = \relative do {
  % === A SECTION ===
  r2. do4 |
  do sol sol do |
  sol la sol do |
  sol4 la do do |
  la sol sol2 |
  sol2 do4 mi8([re]) |
  do4 do8([sol]) mi4 sol |
  sol2 do2 |
  sol4 do do do |
  sol4 sol <do do,>2

  % === B SECTION ===
  % Add B section music here
}

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  % Verse 1 lyrics
  Life is the time to serve the Lord,
  The time t’in -- sure the great re -- ward;
  And while the lamp holds out to burn
  The vi -- lest sin -- ner may re -- turn.

}

verseTwo = \lyricmode {
  \tiny
  % Verse 2 lyrics
  Life is the hour that God has giv’n,
  To es -- cape hell and fly to heav’n;
  The day of grace, and mor -- tals may
  Se -- cure the bles -- sing of the day.

}

% Additional verses if needed
verseThree = \lyricmode {
  \tiny
  % Verse 3 lyrics if needed
  The li -- ving know that they must die,
  But all the dead for -- got -- ten lie;
  Their mem’ -- ry and their sense is gone,
  A -- like un -- know -- ing and un -- known.
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
      \new Lyrics \lyricsto "alto" { \set stanza = "2." \verseTwo }
    >>

    \new Staff = tenor <<
      \new Voice = "tenor" {
        \global
        \tenorMusic
      }
      % Uncomment for verse 3 under tenor:
      \new Lyrics \lyricsto "tenor" { \set stanza = "3." \verseThree }
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
      \new Staff { \global \transpose do do, { \trebleMusic } }
      \new Staff { \global \transpose do do, { \tenorMusic } }
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

