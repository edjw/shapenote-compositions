\language "espanol"
\version "2.24.0"
#(set-default-paper-size "a4landscape")

%%%%%% Shapenote Template %%%%%%
%
% HOW TO USE THIS TEMPLATE:
% 1. Change songKey to set the key - examples provided
% 2. Update song info: title, meter, composer
% 3. Enter music in the four voice sections
% 4. Add lyrics to verseOne and verseTwo sections

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
songKey = sol
songMode = "major"  % "major" or "minor"
songTitle = "Deliverance"
songMeter = "CM"
songComposer = "Ed Johnson-Williams, September 2025"
poet = "Philip Doddridge"
timeSignature = 6/8
noteHeadStyle = "seven"  % "seven", "four", or "normal"
pickupDuration = "4."  % "0" = none, "2" = half, "2." = dotted half, "4" = quarter, "4." = dotted quarter, "8" = eighth, "8." = dotted eighth

setPickup =
#(let ((duration (if (defined? 'pickupDuration) pickupDuration "0")))
   (cond
    ((equal? duration "2") #{ \partial 2 #})
    ((equal? duration "2.") #{ \partial 2. #})
    ((equal? duration "4") #{ \partial 4 #})
    ((equal? duration "4.") #{ \partial 4. #})
    ((equal? duration "8") #{ \partial 8 #})
    ((equal? duration "8.") #{ \partial 8. #})
    ((equal? duration "0") #{ #})
    (else #{ #})))


% Function to convert songKey to readable key signature
getKeySignature =
#(let* ((key-pitch (if (defined? 'songKey) songKey (ly:make-pitch 0 0 0)))
        (mode (if (defined? 'songMode) songMode "major"))
        (notename (ly:pitch-notename key-pitch))
        (alteration (ly:pitch-alteration key-pitch))
        ;; notename: 0=C, 1=D, 2=E, 3=F, 4=G, 5=A, 6=B
        ;; alteration: -1=flat, 0=natural, 1=sharp
        (major-keys '(((0 . 0) . "C Major")
                      ((1 . 0) . "D Major")
                      ((2 . 0) . "E Major")
                      ((3 . 0) . "F Major")
                      ((4 . 0) . "G Major")
                      ((5 . 0) . "A Major")
                      ((6 . 0) . "B Major")
                      ((6 . -1) . "B♭ Major")
                      ((2 . -1) . "E♭ Major")
                      ((5 . -1) . "A♭ Major")
                      ((1 . -1) . "D♭ Major")
                      ((4 . -1) . "G♭ Major")
                      ((3 . 1) . "F♯ Major")
                      ((0 . 1) . "C♯ Major")))
        (minor-keys '(((5 . 0) . "A Minor")
                      ((2 . 0) . "E Minor")
                      ((6 . 0) . "B Minor")
                      ((3 . 1) . "F♯ Minor")
                      ((0 . 1) . "C♯ Minor")
                      ((4 . 1) . "G♯ Minor")
                      ((1 . 1) . "D♯ Minor")
                      ((1 . 0) . "D Minor")
                      ((4 . 0) . "G Minor")
                      ((0 . 0) . "C Minor")
                      ((3 . 0) . "F Minor")
                      ((6 . -1) . "B♭ Minor")
                      ((2 . -1) . "E♭ Minor")))
        (keys (if (equal? mode "minor") minor-keys major-keys))
        (key-pair (cons notename alteration))
        (result (assoc key-pair keys)))
   (if result
       (cdr result)
       "Unknown Key"))

\paper {
  page-count = #1
  system-count = #2
  system-system-spacing = #'((basic-distance . 0) (padding . 3))
  markup-system-spacing = #'((basic-distance . 4) (padding . 3))
  top-margin = .75\cm
  bottom-margin = 0\cm
  left-margin = .75\cm
  right-margin = .75\cm
}

\header {
  title = \markup{ \bold \smaller #songTitle "   " \small{#songMeter }}
  composer = #songComposer
  tagline = ##f % removes the Lilypond tagline from bottom
  poet = \markup{ \concat { #getKeySignature ", " #poet } }
}

setShapeHeads =
#(cond
  ((equal? noteHeadStyle "seven") #{ \aikenHeads #})
  ((equal? noteHeadStyle "four") #{ \sacredHarpHeads #})
  (else #{ #}))



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

trebleMusic = \relative do' {

  \newSpacingSection
  \once \override Score.SpacingSpanner.spacing-increment = #0.2

  mi4. |

  \newSpacingSection
  \revert Score.SpacingSpanner.spacing-increment

  \repeat volta 2 {
    sol4 sol8 sol4 mi8 |
    sol4 do8 sol4 mi8 |
    sol4 la8 sol4 sol8
    \alternative {
      {
        mi4. sol4. |
      } {
        sol4. sol4. |\break
      }
    }
  }

  \repeat volta 2 {
    la4 sol8 mi4 do8 |
    do4 do8 mi4 sol8 |
    do4 sol8 mi4 mi8 |
    sol4. do4. |
    sol4 sol8 mi4 re8 |
    mi4 sol8 sol4 sol8 |
    la4 sol8 mi4 sol8 |
    \alternative {
      {
        sol4. sol4. |
      }
      {
        \newSpacingSection
        \once \override Score.SpacingSpanner.spacing-increment = #0.2
        sol2. |
      }
    }
  }
  \bar ".."
}

altoMusic = \relative do' {
  sol4. |
  \repeat volta 2 {
    do4 do8 sol4 la8 |
    sol4 sol8 sol4 do8 |
    do4 mi8 do4 sol8 |
    \alternative {
      {
        sol4. do4. |
      } {
        sol4. sol4. |
      }
    }
  }

  \repeat volta 2 {
    do4 do8 mi4 mi8 |
    do4 sol8 sol4 do8 |
    mi4 do8 do4 do8 |
    do4. mi4. |
    do4 do8 la4 sol8 |
    sol4 sol8 sol4 do8 |
    mi4 do8 la4 sol8 |
    \alternative {
      {
        do4. sol4. |
      }
      {
        do2. |
      }
    }
  }
}

tenorMusic = \relative do' {
  sol4 (la8) |
  \repeat volta 2 {
    do4 mi8 re8 (do) la |
    do4 do8 sol4 sol8 |
    do4 do8 mi4 re8 |
    \alternative {
      {
        do4. sol4. |
      } {
        do4. re4. |
      }
    }
  }

  \repeat volta 2 {
    do4 mi8 sol4 la8 |
    sol4 mi8 do4 do8 |
    sol'4 sol8 sol4 la8 |
    do4. la4. |
    sol4 sol8 la4 sol8  |
    mi4 re8 do4 sol8 |
    la4 do8 mi4 re8 |
    \alternative {
      {
        do4. re4. |
      }
      {
        do2. |
      }
    }
  }
}

bassMusic = \relative do {
  do4. |
  \repeat volta 2 {
    do4 do8 sol4 la8 |
    do4 do8 do4 do8 |
    sol4 la8 do4 sol8
    \alternative {
      {
        sol4. do4. |
      } {
        do4. sol4. |
      }
    }
  }

  \repeat volta 2 {
    la4 do8 do4 la8 |
    sol4 do8 mi4 do8 |
    sol4 do8 do4 la8 |
    sol4. la4. |
    do4 do8 la4 sol8 |
    do4 sol8 do4 mi8 |
    do4 do8 do4 sol8 |
    \alternative {
      {
        do4. sol4. |
      }
      {
        do2. |
      }
    }
  }
}
%%%%%%% LYRICS %%%%%%%%%

verseOneA = \lyricmode {
  \tiny
  Ye gold -- en lamps of heav’n fare -- well,
  With all your fee -- ble light;
  Fare-
  _
  \set stanza = "1." And thou re -- ful -- gent orb of day,
  In bright -- er flames ar -- rayed;
  My soul which springs be -- yond thy sphere,
  No more de -- mands thy aid.
  And
  aid.

}

verseOneB = \lyricmode {
  \tiny
  _ -well thou ev -- er chan -- ging moon,
  Pale em -- press of the - - night.
}

verseTwoA = \lyricmode {
  \tiny
  No more the drops of pier -- cing grief
  Shall swell in -- to mine eyes;
  Nor
  _
  \set stanza = "2." There all the mill -- ions of his saints
  Shall in one song u -- nite,
  And each the bliss of all shall share
  With in -- fin -- ite de -- light.
  There
  -light

}

verseTwoB = \lyricmode {
  \tiny
  _ the me -- rid -- ian sun de -- cline
  A -- midst those bright -- er - - skies.


}


%%%%%%% SCORE %%%%%%%%%
% Main music content (defined once, used for both print and MIDI)
musicContent = {
  \new ChoirStaff <<
    \new Staff = treble \with {
      \consists "Volta_engraver"
    } <<
      \new Voice = "treble" {
        \global
        \trebleMusic
      }
      \new Lyrics \lyricsto "treble" {  \verseOneA }
      \new Lyrics \lyricsto "treble" {  \verseOneB }
      % \new Lyrics \lyricsto "treble" { \set stanza = "2." \verseTwoA }
      % \new Lyrics \lyricsto "treble" { \verseTwoB }
    >>

    \new Staff = alto <<
      \new Voice = "alto" {
        \global
        \altoMusic
      }

    >>

    \new Staff = tenor \with {
      \consists "Volta_engraver"
    } <<
      \new Voice = "tenor" {
        \global
        \tenorMusic
      }
      \new Lyrics \lyricsto "tenor" {  \verseOneA }
      \new Lyrics \lyricsto "tenor" {  \verseOneB }
      %  \new Lyrics  \lyricsto "tenor" { \set stanza = "2." \verseTwoA }
      %  \new Lyrics \lyricsto "tenor" { \verseTwoB }
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
      \remove "Volta_engraver"
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
