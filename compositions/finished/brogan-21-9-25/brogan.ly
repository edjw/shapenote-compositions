\language "espanol"
\version "2.26.0"
#(set-default-paper-size "a4landscape")

%%%%%% Shapenote Template %%%%%%
%
% HOW TO USE THIS TEMPLATE:
% 1. Change songKey to set the key - examples provided
% 2. Update song info: title, meter, composer
% 3. Update meter = "G Major" to show the key name
% 4. Enter music in the four voice sections
% 5. Add lyrics to verseOne and verseTwo sections

%
% KEY TRANSPOSITION EXAMPLES (change in ONE place only):
% C major:  \transpose do do
% G major:  \transpose do sol
% F major:  \transpose do fa
% D major:  \transpose do re
% A major:  \transpose do la
% E major:  \transpose do mi
% Bb major: \transpose do sib
% Eb major: \transpose do mib
%
% MINOR KEYS:
% A minor:  \transpose do do
% E minor:  \transpose do sol
% B minor:  \transpose do re
% F# minor: \transpose do la
% D minor:  \transpose do fa
% G minor:  \transpose do sib
% C minor:  \transpose do mib

%%%%%% QUICK SETTINGS %%%%%%
songKey = mib
songTitle = "Brogan"
songMeter = "CM"
keySignature = "E♭ Major"
songComposer = "Ed Johnson-Williams, September 2025"
poet = "Isaac Watts"

\paper {
  page-count = #1
  system-count = #1
  system-system-spacing = #'((basic-distance . 0) (padding . 6))
  markup-system-spacing = #'((basic-distance . 12) (padding . 4))
  top-margin = 1.25\cm
  bottom-margin = 1.25\cm
}

% Custom strikethrough command
#(define-markup-command (strike-through layout props arg)
   (markup?)
   #:properties ((thickness 1) (offset 0.2))
   (let* ((thick (ly:output-def-lookup layout 'line-thickness))
          (underline-thick (* thickness thick))
          (markup (interpret-markup layout props arg))
          (x1 (car (ly:stencil-extent markup X)))
          (x2 (cdr (ly:stencil-extent markup X)))
          (y1 (interval-center (ly:stencil-extent markup Y)))
          (y2 y1)
          (line (make-line-stencil underline-thick x1 y1 x2 y2)))
     (ly:stencil-add markup line)))

\header {
  title = \markup{ \bold \smaller #songTitle "   " \small{#songMeter }}
  composer = #songComposer
  %tagline = ##f % removes the Lilypond tagline from bottom
  tagline = \markup { \tiny {Major \strike-through {Banger} Bangor}}
  poet = \markup{ \concat { #keySignature ", " #poet } }
}

global = {
  \key do \major % Don't change this
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
% Write all music with the do, re, mi, fa, sol, la, si
%
% HELPFUL PATTERNS:
% Repeats:         \repeat volta 2 { music }
% Mid-bar:         \bar ";"
% Line break:      \break (after A section)
% Beams:           do8[ re8] (eighth notes and shorter only)
% Slurs:           do8( re8 mi8)
% Combined:        do8([ re8]) (slur and beam together)
% Ties:            do4~ do4
% Dotted notes:    do4. re8
% Octaves:         do'4 (higher) or do,4 (lower)
% Fermatas:        do4\fermata
% Grace notes:     \grace { do8 } re4
% Chords:          <do mi sol>4
% Accidentals:     dis4 or reb4
% Text markings:   do4^\markup { "Fine" }
% Triplets:        \tuplet 3/2 { do8 re8 mi8 }

trebleMusic = \relative do'' {
  r2 sol2 |
  sol sol4(fa) |
  mi2 sol |
  sol2 sol4(fas) |
  sol2 \fermata sol |
  do2 re4(do) |
  si2 la |
  si \fermata sol |
  sol sol |
  sol sol |
  sol sol4(fas) |
  sol2 \fermata sol |
  sol sol4(la) |
  sol2 sol |
  mi1 \fermata

}

altoMusic = \relative do' {
  r2 mi |
  do si |
  do mi |
  mi re |
  re \fermata mi |
  mi re4(mi)
  re2 re |
  re \fermata sol |
  sol fa |
  mi sol4(fa) |
  mi2 re |
  re \fermata mi |
  mi4(fa) mi(re) |
  do2 si |
  do1 \fermata
}

tenorMusic = \relative do'' {
  r2 sol |
  mi re |
  do sol' |
  do si4 (la) |
  sol2 \fermata sol |
  sol4(la) si(la) |
  sol2 fas |
  sol2 \fermata sol |
  do si |
  do mi4(re) |
  do2 si4(la) |
  sol2 \fermata sol2 |
  do2 sol4(fa) |
  mi2 re |
  do1 \fermata
  \bar ".."
}

bassMusic = \relative do {
  r2 do |
  do sol |
  do do |
  do re |
  sol, \fermata do |
  do si4(do) |
  re2 re |
  sol2 \fermata sol4(fa) |
  mi2 re |
  do do |
  do re |
  sol, \fermata do |
  do4(re) mi(fa) |
  sol2 sol,2 |
  do1 \fermata

}

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  Hark! from the tombs a dole -- ful sound!
  My ears at -- tend the cry:
  Ye liv -- ing men! come view the ground
  Where you must short -- ly lie.

}

verseTwo = \lyricmode {
  \tiny
  Prin -- ces! this clay must be your bed,
  In spite of all your towers;
  The tall, the wise, the rev' -- rend head
  Must lie as low as ours.

}

% Additional verses if needed
verseThree = \lyricmode {
  \tiny
  Great God! is this our cer -- tain doom?
  And are we still se -- cure?
  Still walk -- ing down -- ward to our tomb,
  And yet pre -- pare no more!
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
      % Uncomment for verse 2 under alto:
      \new Lyrics \lyricsto "alto" { \set stanza = "2." \verseTwo }
    >>

    \new Staff = tenor <<
      \new Voice = "tenor" {
        \global
        \tenorMusic
      }
      %\new Lyrics \lyricsto "tenor" { \set stanza = "2." \verseTwo }
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
      \override NoteHead.font-size = #2
      startRepeatBarType = #";"
      endRepeatBarType = #";."
      doubleRepeatBarType = ";.;"
    }
  }
}

\score {
  \unfoldRepeats
  \transpose do \songKey {
    <<
      \new ChoirStaff <<
        \new Staff \with {
          midiInstrument = #"trumpet"
          instrumentName = "Treble"
        } {
          \new Voice = "treble" {
            \global
            \trebleMusic
          }
        }
        \new Staff \with {
          midiInstrument = #"french horn"
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
        midiInstrument = #"trumpet"
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

