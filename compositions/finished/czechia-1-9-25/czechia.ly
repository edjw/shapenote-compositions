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
songKey = la  % Change this to set key (see examples above)
songTitle = "Czechia"
songMeter = "CM"
songComposer = "Ed Johnson-Williams, September 2025"

\paper {
  page-count = #1
  system-count = #1
  system-system-spacing = #'((basic-distance . 0) (padding . 6))
  top-margin = 0.5\in
}

\header {
  title = \markup{ \bold \smaller #songTitle "   " \small{#songMeter }}
  arranger = #songComposer
  meter = "A Major, Isaac Watts"  % Update this manually to match songKey
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
  r2. mi4 |
  do2 mi |
  sol2 mi4(re) |
  mi2 sol |
  sol2. mi4 |
  re2. do4 |
  mi2 do |
  re2. do4 |
  do2 do4(re) |
  mi2. sol4 |
  la2 do4 (si) |
  sol2. la4 |
  sol2. sol4 |
  mi2 sol |
  mi1
  \bar ".."
}

altoMusic = \relative do' {
  r2. do4 |
  do2 do |
  do2 mi4(re) |
  do2 sol |
  do2. do4 |
  sol2. la4 |
  do2 do |
  re2. mi4 |
  do2 do4 (re) |
  do2. re4 |
  do2 do4 (sol) |
  sol2. do4 |
  do2. re4 |
  do2 sol2 |
  sol1
}

tenorMusic = \relative do' {
  r2. sol4 |
  sol2 la |
  sol2 do4(re) |
  mi2 re |
  do2. do4 |
  re2. mi4 |
  do2 sol |
  sol2. sol4 |
  la2 la4(sol) |
  do2. re4 |
  mi2 do4 (re) |
  do2. mi4 |
  sol2. sol4 |
  mi2 do4.(re8) |
  do1

  \bar "|."
}

bassMusic = \relative do {
  r2. do4 |
  do2 la |
  sol2 mi4(sol) |
  la2 sol |
  do2. do4 |
  sol2. la4 |
  sol2 sol |
  sol2. sol4 |
  la2 la4(sol) |
  mi2. sol4 |
  la2 la4 (sol) |
  do2. la4 |
  do2. sol4 |
  sol2 do |
  <do do,>1
}

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  God of my life, look gent -- ly down,
  Be -- hold the pains I feel;
  But I am dumb be -- fore Thy throne,
  Nor dare dis -- pute Thy will.

}

verseTwo = \lyricmode {
  \tiny
  I’m but a so -- jour -- ner be -- low,
  As all my fa -- thers were;
  May I be well pre -- pared to go
  When I the sum -- mons hear.

}

% Additional verses if needed
verseThree = \lyricmode {
  \tiny
  But if my life be spared a -- while,
  Be -- fore my last re -- move,
  Thy praise shall be my bus’ -- ness still
  And I’ll de -- clare Thy love.
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
      %\new Lyrics \lyricsto "tenor" { \set stanza = "1." \verseOne }
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
      \new ChoirStaff <<
        \new Staff \with {
          midiInstrument = #"soprano sax"
          instrumentName = "Treble"
        } {
          \new Voice = "treble" {
            \global
            \trebleMusic
          }
        }
        \new Staff \with {
          midiInstrument = #"alto sax"
          instrumentName = "Alto"
        } {
          \new Voice = "alto" {
            \global
            \altoMusic
          }
        }
        \new Staff \with {
          midiInstrument = #"trumpet"
          instrumentName = "Tenor"
        } {
          \new Voice = "tenor" {
            \global
            \tenorMusic
          }
        }
        \new Staff \with {
          midiInstrument = #"tuba"
          instrumentName = "Bass"
        } {
          \clef bass
          \new Voice = "bass" {
            \global
            \bassMusic
          }
        }
      >>
      % Octave doubling
      \new Staff \with {
        midiInstrument = #"tenor sax"
        instrumentName = "Treble (low)"
      } {
        \new Voice = "treble-low" {
          \global \transpose do do, { \trebleMusic }
        }
      }
      \new Staff \with {
        midiInstrument = #"trumpet"
        instrumentName = "Tenor (low)"
      } {
        \new Voice = "tenor-low" {
          \global \transpose do do, { \tenorMusic }
        }
      }
    >>
  }

  \midi {
    \context {
      \Score
      tempoWholesPerMinute = #100/4

    }
  }
}
