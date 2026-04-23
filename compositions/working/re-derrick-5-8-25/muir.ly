\language "espanol"
\version "2.26.0"
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
% G minor:  \transpose do sib  (then use \minor in global)

%%%%%% QUICK SETTINGS %%%%%%
songKey = fa  % Change this to set key (see examples above)
songTitle = "Muir"
songMeter = "PM"
songComposer = "Ed Johnson-Williams, 5+26 August 2025"

\paper {
  page-count = #1
  system-count = #2
  system-system-spacing = #'((basic-distance . 0) (padding . 6))
  top-margin = 0.5\in
}

\header {
  title = \markup{ \bold \smaller #songTitle "   " \small{#songMeter }}
  arranger = #songComposer
  meter = "F Major"  % Update this manually to match songKey
  tagline = ##f
}

global = {
  \key do \major
  % \minor        % Uncomment for minor keys but leave the \major aboe
  \aikenHeads     % or \sacredHarpHeads for 4-shape
  \numericTimeSignature
  \time 4/4       % Change as needed
  \defineBarLine ";" #'("|" ";" " ")        % Start repeat barline
  \defineBarLine ";." #'("|" ";." ";.")     % End repeat barline
  \defineBarLine ".;" #'("|" ".;" ".;")     % Double bar into start repeat
  \defineBarLine ".." #'(".." ".." "..")    % Double barline for section endings
  \defineBarLine ";.." #'(";.." ";.." ";..") % End repeat into double bar
  \defineBarLine ";.;" #'(";.;" ";.;" ";.;") % Back-to-back repeats
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

  % === B SECTION ===
  % Add B section music here
  \bar ".."
}

altoMusic = \relative do' {
  % === A SECTION ===


  % === B SECTION ===
  % Add B section music here
}

tenorMusic = \relative do' {


  r2. do4 |
  sol' sol do, la'8([sol]) |
  sol2. do,8([re]) |
  mi8([fa]) sol4  re8([do]) do4 |
  sol'2. sol4 |
  do,4 la' sol sol |
  do,2. re4 |
  mi4. fa8 sol4 re |
  do2. sol'4 |
  do mi do sol8([do]) |
  la4 sol sol do |
  do do la8([sol]) sol4 |
  do do do,2 |
  la' sol4 sol |
  do,8([re]) mi8([fa]) sol4. re8 |
  do2. do'4 |
  do do la8([sol]) sol4 |
  do do do,2 |

  \bar "|."
}

bassMusic = \relative do {

  r2. do4 |
  do sol la la8([sol]) |
  sol2. do8([sol]) |
  la8([do]) do4 sol8([do]) do4 |
  do2. sol4 |
  la4 la sol sol |
  do2. sol4 |
  la4. do8 do4 sol |
  do2. do4 |
  do la do do8([do]) |
  re4 mi mi do |
  do mi mi8([re]) do4 |
  la do do,2 |
  la' sol4 sol |
  do8([re]) mi8([fa]) sol4. re8 |
  la2. do'4 |
  do do la8([sol]) sol4 |
  do do do,2 |
}

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  No bur -- ning heats by day,
  Nor blasts of eve -- ning air,
  Shall take my health a -- way,
  If God be with me there.
  Thou art my sun and Thou my shade
  To guard my head by night or noon.
  Thou art my sun and Thou my shade
  To guard my head by night or noon.

}

verseTwo = \lyricmode {
  \tiny
  % Verse 2 lyrics

}

% Additional verses if needed
verseThree = \lyricmode {
  \tiny
  % Verse 3 lyrics if needed
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
      %\new Lyrics \lyricsto "tenor" { \set stanza = "2." \verseTwo }
      % Uncomment for verse 3 under tenor:
      \new Lyrics \lyricsto "tenor" { \set stanza = "1." \verseOne }
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
  \unfoldRepeats
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
      tempoWholesPerMinute = #100/4
    }

    \context {
      \Staff
      midiInstrument = #"acoustic grand"
    }
  }
}

