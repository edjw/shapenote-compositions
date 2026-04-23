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
songMode = "minor"  % "major" or "minor"
songTitle = "Metford"
songMeter = "SMD"
songComposer = "Ed Johnson-Williams, December 2025"
poetName = "Charles Wesley"
timeSignature = 6/8
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

trebleMusic = \relative do' {

  r4. mi |
  re4 mi8 mi4 sol8 |
  la4. sol |
  la4 mi8 re8[mi] mi |
  mi4. mi |
  re4 mi8 mi4 sol8 |
  la4 la8 sol4 la8 |
  mi4 mi8 re8[mi] mi |
  mi4. mi4. |
  re4 mi8 sol4 sol8 |
  la4. mi |
  re4 mi8 mi8[re] mi |
  sol4. mi |
  re4 mi8 mi4 mi8 |
  sol4 la8 sol4 sol8 |
  la4 mi8 re8[mi] mi |
  mi2.

}

altoMusic = \relative do' {
  r4. la4. |
  sol4 la8 la4 si8 |
  la4. si4. |
  la4 la8 sol8[la] sol |
  la4. la |
  sol4 la8 la4 si8 |
  la4 la8 si4 la8 |
  la4 la8 sol8[la] sol8
  la4. la |
  si4 la8 si4 si8 |
  la4. la |
  si4 la8 la8[si] la8 |
  si4. la |
  sol4 la8 la4 la8 |
  si4 la8 si4 si8 |
  la4 la8 sol8[la] sol |
  la2.

}

tenorMusic = \relative do' {

  r4. la4. |
  sol4 la8 la4 re8 |
  mi4. re4. |
  mi4 la,8 sol [la] si |
  la4. la4. |
  sol4 la8 la4 re8 |
  mi4 mi8 re4 mi8 |
  la,4 la8 sol8[la] si8
  la4. mi'4.
  sol4 mi8 re4 re8 |
  mi4. mi4. |
  sol4 la8 la[sol] mi |
  re4. la4. |
  sol4 la8 la4 la8 |
  re4 mi8 re4 re8 |
  mi4 la,8 sol8[la] si |
  la2.

  \bar ".."
}

bassMusic = \relative do {
  r4. la4. |
  sol4 la8 la4 sol8 |
  la4. sol4. |
  la4 la8 sol8[la] mi8 |
  la4. la4.
  sol4 la8 la4 sol8 |
  la4 la8 sol4 la8 |
  la4 la8 sol8[la] mi8 |
  la4. la4. sol4 la8 sol4 sol8 |
  la4. la |
  sol4 la8 la8[sol] la |
  sol4. la |
  sol4 la8 la4 la8 |
  sol4 la8 sol4 sol8 |
  la4 la8 sol8[la] mi8 |
  la2.

}


verseOne = \lyricmode {
  \tiny
  Je -- sus, my strength, my hope,
  On thee I cast my care,
  With hum -- ble con -- fi -- dence look up,
  And know thou hear'st my prayer.
  Give me on thee to wait,
  Till I can all things do;
  On thee, al -- migh -- ty to cre -- ate,
  Al -- migh -- ty to re -- new.

}


verseTwo = \lyricmode {
  \tiny
  I want a so -- ber mind;
  A self re -- nounc -- ing will,
  That tram -- ples down and casts be -- hind
  The baits of pleas -- ing ill;
  A soul in -- ured to pain,
  To hard -- ship, grief, and loss,
  Bold to take up, firm to sus -- tain,
  The con -- sec -- rat -- ed cross.

}


verseThree = \lyricmode {
  \tiny
  I want a god -- ly fear,
  A quick dis -- cern -- ing eye,
  That looks to thee when sin is near,
  And sees the temp -- ter fly;
  A spi -- rit still pre -- pared,
  And arm'd with jeal -- ous care,
  For e -- ver stand -- ing on its guard,
  And watch -- ing un -- to prayer.
}

verseFour = \lyricmode {
  \tiny
  I rest u -- pon thy word;
  The prom -- ise is for me;
  My suc -- cour and sal -- vat -- ion, Lord,
  Shall sure -- ly come from thee:
  But let me still a -- bide,
  Nor from my hope re -- move,
  Till thou my pat -- ient spi -- rit guide
  In -- to thy per -- fect love.
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
      \new Lyrics \lyricsto "treble" { \set stanza = "2." \verseTwo }
    >>


    \new Staff = alto <<
      \new Voice = "alto" {
        \global
        \altoMusic
      }
      \new Lyrics \lyricsto "alto" { \set stanza = "3." \verseThree }
    >>

    \new Staff = tenor <<
      \new Voice = "tenor" {
        \global
        \tenorMusic
      }


      \new Lyrics \lyricsto "tenor" { \set stanza = "4." \verseFour }
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
      tempoWholesPerMinute = #100/4

    }
  }
}
