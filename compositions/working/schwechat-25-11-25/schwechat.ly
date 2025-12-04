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
songKey = fa
songMode = "major"  % "major" or "minor"
songTitle = "Schwechat"
songMeter = "6,6,6,6,8,8"
songComposer = "Ed Johnson-Williams, November 2025"
poetName = "Charles Wesley (kinda)"
timeSignature = 4/4
noteHeadStyle = "seven"  % "seven", "four", or "normal"
pickupDuration = "0"  % "0" = none, "2" = half, "2." = dotted half, "4" = quarter, "4." = dotted quarter, "8" = eighth, "8." = dotted eighth

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
        (all-keys '(
                     ((0 0 "major") . "C Major")
                     ((0 1/2 "major") . "C♯ Major")
                     ((1 -1/2 "major") . "D♭ Major")
                     ((1 0 "major") . "D Major")
                     ((2 -1/2 "major") . "E♭ Major")
                     ((2 0 "major") . "E Major")
                     ((3 0 "major") . "F Major")
                     ((3 1/2 "major") . "F♯ Major")
                     ((4 -1/2 "major") . "G♭ Major")
                     ((4 0 "major") . "G Major")
                     ((5 -1/2 "major") . "A♭ Major")
                     ((5 0 "major") . "A Major")
                     ((6 -1/2 "major") . "B♭ Major")
                     ((6 0 "major") . "B Major")
                     ((0 0 "minor") . "A Minor")
                     ((0 1/2 "minor") . "A♯ Minor")
                     ((1 -1/2 "minor") . "B♭ Minor")
                     ((1 0 "minor") . "B Minor")
                     ((1 1/2 "minor") . "C Minor")
                     ((2 -1/2 "minor") . "C Minor")
                     ((2 0 "minor") . "C♯ Minor")
                     ((3 0 "minor") . "D Minor")
                     ((3 1/2 "minor") . "D♯ Minor")
                     ((4 -1/2 "minor") . "E♭ Minor")
                     ((4 0 "minor") . "E Minor")
                     ((4 1/2 "minor") . "F Minor")
                     ((5 -1/2 "minor") . "F Minor")
                     ((5 0 "minor") . "F♯ Minor")
                     ((5 1/2 "minor") . "G Minor")
                     ((6 -1/2 "minor") . "G Minor")
                     ((6 0 "minor") . "G♯ Minor")))
        (key-list (list notename alteration mode))
        (result (assoc key-list all-keys)))
   (if result
       (cdr result)
       "Unknown Key"))

\paper {
  page-count = #1
  system-count = #2
  system-system-spacing = #'((basic-distance . 0) (padding . 6))
  markup-system-spacing = #'((basic-distance . 12) (padding . 4))
  top-margin = 1.25\cm
  bottom-margin = 1.25\cm
  % left-margin = 1.0\cm
  % left-margin = 1.0\cm
}

\header {
  title = \markup{ \bold \smaller #songTitle "   " \small{#songMeter }}
  composer = #songComposer
  tagline = ##f % removes the Lilypond tagline from bottom
  poet = \markup{
    \concat {
      #getKeySignature
      #(if (not (string-null? poetName))
           (string-append ", " poetName)
           "")
    }
  }
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

trebleMusic = \relative do'' {
  sol1 |
  do4 sol sol la |
  sol2. do4 |
  sol4. la8 sol4 fa |
  mi2. re4 |
  mi mi sol sol |
  la2. do4 |
  sol4. la8 sol4 do |
  si2. \repeat volta 2 {
    r4 |
    r1 |
    r1 |
    r1 |
    r1 |
    r1 |
    r2. do,4|
    do8[re] mi[fa] sol4 la8[do] |
    do2 si |
  }

  \alternative {
    {
      do2.
    }
    {
      do1 |
    }
  }

}


altoMusic = \relative do' {

  mi1 |
  mi4 re do do |
  do2. do4 |
  re4. do8 do4 la4 |
  sol2. sol4 |
  sol do mi do |
  do2. do4 |
  mi4. do8 re4 do |
  re2.

  \repeat volta 2 {
    r4 |
    r1 |
    r1 |
    r1 |
    r2. do4 |
    do8[re] mi[fa] mi4 mi |
    mi fa mi do |
    sol la si do |
    do2 re |
  }

  \alternative {
    {
      mi2.
    }
    {
      mi1 |
    }
  }

}


tenorMusic = \relative do' {
  do1 |
  do4 re mi fa |
  mi2. mi4 |
  sol4. fa8 mi4 re |
  do2. sol'4 |
  sol la do do |
  la2. la4 |
  sol4. la8 sol4 mi |
  re2. \repeat volta 2 {
    r4
    r1 |
    r2. do4 |
    do8[re] mi8[fa] sol4 do |
    la sol mi mi |
    sol la do sol |
    mi la sol sol |
    sol la

    sol fa |
    mi2 re |
  }
  \alternative {
    {
      do2.
    }
    {
      do1 |
    }
  }
  \bar ".."
}

bassMusic = \relative do {
  do1 |
  do4 sol do do |
  do2. sol4 |
  sol4. do8 do4 re |
  do2. sol4 |
  do4 la sol sol |
  la2. la4 |
  do4. la8 sol4 sol |
  sol2.

  \repeat volta 2 {
    do4
    do8[re] mi[fa] sol4 sol8[fa] |
    mi4 re do sol |
    sol do do sol |
    fa sol do do |
    sol do la do |
    do do do sol |
    sol  la sol do |
    do2 <sol sol'> |

  }

  \alternative {
    {
      do2.
    }
    {
      do1 |
    }
  }

}

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  I want a so -- ber mind
  An all -- sus -- tain -- ing eye
  To see my God a -- bove
  And to the heav -- ens fly
}

verseTwo = \lyricmode {
  \tiny
  I want a God -- ly fear,
  A quick dis -- cern -- ing eye,
  That looks to Thee my God,
  And see the tempt -- er fly.
}

refrainTenor = \lyricmode {
  \tiny
  _ _ _ _ _ _
  _ _ _ _ _ _
  _ _ _ _ _ _
  _ _ _ _ _ _

  I'd soar a -- way a -- bove the sky
  I'd soar a -- way a -- bove the sky
  I'd fly to see my God a -- bove
  bove
}

refrainTreble = \lyricmode {
  \tiny
  _ _ _ _ _ _
  _ _ _ _ _ _
  _ _ _ _ _ _
  _ _ _ _ _ _
  I'd fly to see my God a -- bove
  bove
}

refrainAlto = \lyricmode {
  \tiny
  _ _ _ _ _ _
  _ _ _ _ _ _
  _ _ _ _ _ _
  _ _ _ _ _ _
  I'd soar a -- way a -- bove the sky
  I'd fly to see my God a -- bove
  bove
}


refrainBass = \lyricmode {
  \tiny
  _ _ _ _ _ _
  _ _ _ _ _ _
  _ _ _ _ _ _
  _ _ _ _ _ _

  I'd soar a -- way a -- bove the sky


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
      \new Lyrics \lyricsto "treble" {
        \refrainTreble
      }

      % Uncomment for additional verses under treble:
      % \new Lyrics \lyricsto "treble" { \set stanza = "3." \verseThree }
    >>

    \new Staff = alto <<
      \new Voice = "alto" {
        \global
        \altoMusic
      }
      % Uncomment for verse 2 under alto:
      \new Lyrics \lyricsto "alto" { \refrainAlto }
    >>

    \new Staff = tenor <<
      \new Voice = "tenor" {
        \global
        \tenorMusic
      }
      \new Lyrics \lyricsto "tenor" { \refrainTenor }

      \new Lyrics \lyricsto "tenor" { \set stanza = "2." \verseTwo }
      % Uncomment for verse 3 under tenor:
      %      \new Lyrics \lyricsto "tenor" { \set stanza = "1." \verseOneTenor }
    >>

    \new Staff = bass <<
      \clef bass
      \new Voice = "bass" {
        \global
        \bassMusic
      }
      % Uncomment for lyrics under bass (less common):
      \new Lyrics \lyricsto "bass" {  \refrainBass }
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
