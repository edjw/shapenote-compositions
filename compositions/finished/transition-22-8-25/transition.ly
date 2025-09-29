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
% G minor:  \transpose do sib  (then use \minor in global)

%%%%%% QUICK SETTINGS %%%%%%
songKey = sib  % Change this to set key (see examples above)
songTitle = "Transition"
songMeter = "8,7s"
songComposer = "Ed Johnson-Williams, August & September 2025"

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
  \key do \major
  %\minor        % Uncomment for minor keys but leave the \major aboe
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

  \bar ";"
  \repeat volta 2 {
    mi2 mi4 re |
    do2 re |
    do4 re mi2 |
    sol2 mi4 mi8[sol] |
    la4 sol la4.(sol8)  |
    mi1 |
  }

  r2 sol |
  mi4 mi8[re] mi2 |
  sol mi4 mi |
  re2 do | \break
  mi4 sol mi8[re] do[re] |
  mi2 mi |
  sol mi4 sol |
  la2 sol |
  la4 mi mi2 |
  re mi4 sol |
  la sol mi2
  (sol) mi|

  % === B SECTION ===
  % Add B section music here
  \bar ".."
}

altoMusic = \relative do' {
  % === A SECTION ===

  \bar ";"
  \repeat volta 2 {
    la2 la4 sol |
    mi2 sol |
    la4 sol la2 |
    sol2 sol4 la |
    la4 sol mi4.(sol8)  |
    la1 |
  }

  r2 sol |
  la4 la la2 |
  sol do4 la4 |
  sol2 la |
  do4 re do do |
  sol2 la |
  sol sol8[la] sol4 |
  la2 sol |
  la8[sol] mi4 mi2 |
  sol la4 sol |
  mi sol la2
  (sol) la |

  % === B SECTION ===
  % Add B section music here
}

tenorMusic = \relative do' {
  % === A SECTION ===
  \bar ";"
  \repeat volta 2 {
    la2 do4 re |
    mi2 re |
    do4 sol la2 |
    si2 do4 do |
    do si la4.(sol8) |
    la1 |
  }

  r2 sol |
  la4 do8[re] mi2 |
  re mi8[re] mi4 |
  sol2 mi |
  mi4 sol la sol |
  sol2 mi |
  re do4 re |
  mi2 re |
  do4 la la2 |
  si do4 re |
  mi re do2
  (sol) la |


  % === B SECTION ===
  % Add B section music here
  \bar "|."
}

bassMusic = \relative do {
  % === A SECTION ===
  \bar ";"
  \repeat volta 2 {
    la2 la4 sol |
    la2 sol |
    la4 sol mi2 |
    sol2 do4 la4 |
    la sol mi4.(sol8) |
    la1 |
  }

  r2 do |
  la4 la la2 |
  sol la4 la |
  sol2 la |
  la4 sol mi sol |
  mi2 mi |
  sol mi4 sol |
  la2 sol |
  la4 do la2 |
  sol la4 sol |
  mi sol la2
  (do) la |

  % === B SECTION ===
  % Add B section music here
}
%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  I want to live a Chris -- tian here,
  I want to die a shou -- ting,

  I want to see bright an -- gels stand
  And wait -- ing to re -- ceive me,
  To bear my soul to Ca -- naan's land,
  Where Christ is gone be -- fore me.

}

verseOneARepeat = \lyricmode {
  \tiny
  I want to feel a Sav -- iour near,
  While soul and bo -- dy's part -- ing;
}




verseTwo = \lyricmode {
  \tiny

  O that I had some hum -- ble place,
  Where I might hide from sor -- row;

  O! had I wings like No -- ah's dove,
  I'd leave this word and Sa -- tan,
  And fly a -- way to realms a -- bove,
  Where Je -- sus stands in -- vit -- ing.

}

verseTwoARepeat = \lyricmode {
  \tiny
  Where I might see my Sa -- vior's face,
  And there by freed from ter -- ror.
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
      % Repeat lyrics (for the repeated A section)
      \new Lyrics \lyricsto "treble" {
        \set stanza = ""
        \verseOneARepeat
      }


    >>

    \new Staff = alto <<
      \new Voice = "alto" {
        \global
        \altoMusic
      }

    >>

    \new Staff = tenor <<
      \new Voice = "tenor" {
        \global
        \tenorMusic
      }
      \new Lyrics \lyricsto "tenor" { \set stanza = "2." \verseTwo }
      % Repeat lyrics (for the repeated A section)
      \new Lyrics \lyricsto "tenor" {
        \set stanza = ""
        \verseTwoARepeat
      }



    >>

    \new Staff = bass <<
      \clef bass
      \new Voice = "bass" {
        \global
        \bassMusic
      }

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
      \override NoteHead.font-size = #2
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
      tempoWholesPerMinute = #(ly:make-moment 100 4)

    }
  }
}
