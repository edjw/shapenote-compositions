\language "espanol"
\version "2.24.0"
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
% KEY TRANSPOSITION EXAMPLES
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
songKey = la
songTitle = "Bevois"
songMeter = "8,7"
keySignature = "A Major"
songComposer = "Ed Johnson-Williams, July & September 2025"
poet = "John Newton"
timeSignature = 3/4
noteHeadStyle = "seven"  % "seven", "four", or "normal"
pickupDuration = 0  % 0 = none, 4 = quarter, 2 = half, 8 = eighth

setPickup =
#(let ((duration (if (defined? 'pickupDuration) pickupDuration 0)))
   (cond
    ((equal? duration 2) #{ \partial 2 #})
    ((equal? duration 4) #{ \partial 4 #})
    ((equal? duration 8) #{ \partial 8 #})
    ((equal? duration 0) #{ #})
    (else #{ #})))

\paper {
  page-count = #1
  system-count = #1
  system-system-spacing = #'((basic-distance . 0) (padding . 6))
  markup-system-spacing = #'((basic-distance . 12) (padding . 4))
  top-margin = 1.25\cm
  bottom-margin = 1.25\cm
}

\header {
  title = \markup{ \bold \smaller #songTitle "   " \small{#songMeter }}
  composer = #songComposer
  tagline = ##f % removes the Lilypond tagline from bottom
  poet = \markup{ \concat { #keySignature ", " #poet } }
}

setShapeHeads =
#(cond
  ((equal? noteHeadStyle "seven") #{ \aikenHeads #})
  ((equal? noteHeadStyle "four") #{ \sacredHarpHeads #})
  (else #{ #}))

setPickup =
#(let ((duration (if (defined? 'pickupDuration) pickupDuration 0)))
   (cond
    ((equal? duration 2) #{ \partial 2 #})
    ((equal? duration 4) #{ \partial 4 #})
    ((equal? duration 8) #{ \partial 8 #})
    ((equal? duration 0) #{ #})
    (else #{ #})))

% Don't change this global section
global = {
  \key do \major
  \setShapeHeads
  \setPickup
  \numericTimeSignature
  \time #timeSignature
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
  sol2 mi4 |
  sol2 sol4 |
  sol2 la4 |
  la2 la4 |
  sol2 mi4 |
  sol2 mi4 |
  mi2 mi4 |
  sol2. | \break
  mi2 sol4 |
  sol2 mi4 |
  do2 mi4|
  mi2 do4 |
  sol'4(fa4) mi4 |
  do2 do4 |
  sol'2 mi4 |
  sol2.
}

altoMusic = \relative do' {
  sol2 do4 |
  do2 do4 |
  mi2 do4 |
  la2 do4 |
  sol2 do4 |
  do2 mi4 |
  do2 do4 |
  re2. |
  do2 re4|
  do2  do4|
  mi2 do4 |
  la2 sol4 |
  sol2 la4|
  do2 do4 |
  re2 mi4 |
  mi2.
}

tenorMusic = \relative do' {
  sol2 la4 |
  do2 mi4 |
  sol2 mi8[do8] |
  la2 do4 |
  sol2 la4|
  do2 la4 |
  do2 la'4 |
  sol2.|
  la2 sol4|


  sol4 (mi) do |
  sol (la) do |
  mi2 sol4 |
  do,2 la4 |
  sol2 sol'8[mi] |
  sol2 sol4 |
  do,2.\bar "|."

  \bar ".."
}

bassMusic = \relative do {
  do2 la4 |
  sol2 sol4 |
  do2 la4 |
  do2 la4 |
  do2 la4 |
  sol2 la4 |
  do2 do4 |
  sol2. |
  la2 sol4 |
  sol2 sol4 |
  do2 do4 |
  do2 do4 |
  sol2 la4 |
  sol2 mi4 |
  sol2 do4 |
  <do do,>2.
}

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  May the grace of Christ our Sav -- ior,
  And the Fa -- ther’s bound -- less love,
  With the Ho -- ly Spi -- rit’s fa -- vor,
  Rest up -- on us from a -- bove.


}

verseTwo = \lyricmode {
  \tiny
  Thus may we a -- bide in un -- ion
  With each o -- ther and the Lord;
  And po -- ssess, in sweet com -- mun -- ion,
  Joys which earth can -- not af -- ford.

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
      % Uncomment for verse 2 under alto:
      % \new Lyrics \lyricsto "alto" { \set stanza = "2." \verseTwo }
    >>

    \new Staff = tenor <<
      \new Voice = "tenor" {
        \global
        \tenorMusic
      }
      \new Lyrics \lyricsto "tenor" { \set stanza = "2." \verseTwo }
      % Uncomment for verse 3 under tenor:
      %\new Lyrics \lyricsto "tenor" { \set stanza = "2." \verseThree }
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
