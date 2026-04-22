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
songKey = sib
songMode = "major"  % "major" or "minor"
songTitle = "Thy Life Was Giv'n For Me"
songMeter = "6s	"
songComposer = "Ed Johnson-Williams, April 2026"
poetName = "Frances Ridley Havergal, 1859"
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
           (string-append ". " poetName)
           "")
    }
  }
}


setShapeHeads =
#(cond
  ((equal? noteHeadStyle "seven") #{ \aikenHeads #})
  ((equal? noteHeadStyle "four") #{ \sacredHarpHeads #})
  (else #{ #}))

#(define openingShapeSourceDo (ly:make-pitch -1 0 0))

#(define openingShapeQuarterDuration (ly:make-duration 2 0 1))

#(define (opening-shape-notename)
   (cond
    ((or (equal? noteHeadStyle "seven") (equal? noteHeadStyle "four")) 6)
    (else #f)))

#(define (make-opening-shape-music pitch)
   (if pitch
       (make-music 'NoteEvent
                   'pitch pitch
                   'duration openingShapeQuarterDuration)
       (make-music 'SkipMusic
                   'duration openingShapeQuarterDuration)))

#(define (opening-shape-notehead-stencil grob)
   (let* ((notehead (ly:note-head::print grob))
          (chevron (grob-interpret-markup
                    grob
                    (markup
                     #:override '(font-size . 1)
                     #:translate '(1.6 . -0.58)
                     "›"))))
     (ly:stencil-add notehead chevron)))

#(define (choose-opening-shape-pitch low-semitone high-semitone target-semitone)
   (let ((note-name (opening-shape-notename)))
     (if (not note-name)
         #f
         (let* ((transpose-interval (ly:pitch-diff songKey openingShapeSourceDo))
                (candidate-octaves '(-3 -2 -1 0 1 2)))
           (let loop ((octaves candidate-octaves) (best-pitch #f) (best-score #f))
             (if (null? octaves)
                 best-pitch
                 (let* ((base-pitch (ly:make-pitch (car octaves) note-name 0))
                        (printed-pitch (ly:pitch-transpose base-pitch transpose-interval))
                        (printed-semitone (ly:pitch-semitones printed-pitch))
                        (in-range (and (>= printed-semitone low-semitone)
                                       (<= printed-semitone high-semitone)))
                        (distance (abs (- printed-semitone target-semitone)))
                        (score (+ distance (if in-range 0 1000))))
                   (if (or (not best-score) (< score best-score))
                       (loop (cdr octaves) base-pitch score)
                       (loop (cdr octaves) best-pitch best-score)))))))))

getOpeningShapeTrebleMusic =
#(make-opening-shape-music (choose-opening-shape-pitch 4 17 10))

getOpeningShapeBassMusic =
#(make-opening-shape-music
  (if (and (equal? songMode "major")
           (= (ly:pitch-notename songKey) 5)
           (= (ly:pitch-alteration songKey) 0))
      (ly:make-pitch -2 6 0)
      (choose-opening-shape-pitch -17 -3 -11)))

openingShapeVoiceSettings = {
  \voiceOne
  \shiftOff
  \setShapeHeads
  \once \override NoteHead.stencil = #opening-shape-notehead-stencil
  \omit Stem
  \omit Flag
  \omit Beam
  \omit Dots
  \omit Accidental
  \omit Rest
  \omit LedgerLineSpanner
  \once \override NoteColumn.ignore-collision = ##t
  \once \override NoteHead.extra-offset = #'(-11.75 . 0)
}

#(define (single-digit-time-signature-markup grob)
   (let* ((fraction (ly:grob-property grob 'fraction '(4 . 4)))
          (numerator (number->string (car fraction))))
     (markup
      #:override '(font-size . 9)
      #:raise -2.2
      #:translate (cons -1 0)
      numerator)))

#(define (single-digit-time-signature-stencil grob)
   (grob-interpret-markup grob (single-digit-time-signature-markup grob)))

singleDigitTimeSignatureStencil =
#(lambda (grob)
   (single-digit-time-signature-stencil grob))

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
  sol4 mi8 sol sol4 mi4 |
  do2 do2 |
  mi4. mi8 mi4 do |
  re1 |
  sol4 mi8 sol sol4 mi4 |
  do2 do2 |
  mi4. do8 sol'4 fa |
  mi1 |
  fa4 fa8 fa8 mi4 re |
  sol2 sol |
  do,4 mi sol mi |
  re1 |
  sol4 mi8 sol sol4 mi4 |
  do2 do2 |
  re4. do8 mi4 re |
  mi1
}

altoMusic = \relative do' {
  sol4 sol8 mi sol4 sol4 |
  la2 la2 |
  sol4. mi8 sol4 sol4 |
  sol1 |
  sol4 sol8 mi sol4 sol4 |
  la2 la2 |
  sol4. sol8 do4 sol |
  sol1 |
  sol4 sol8 sol mi4 sol4 |
  sol2 mi2 |
  sol4 sol do sol |
  sol1 |
  mi4 sol8 mi sol4 sol4 |
  la2 la2 |
  sol4. mi8 sol4 sol |
  sol1 |
}

tenorMusic = \relative do' {
  mi4 mi8 mi re4 do |
  fa2 la,2 |
  sol4. sol8 do4 mi |
  re1 |
  mi4 mi8 mi re4 do |
  fa2 la,2 |
  sol4. mi'8 mi4 re |
  do1 |
  re4 re8 re8 do4 re |
  mi2 mi2 |
  sol4 sol mi4 do |
  re1 |
  mi4 mi8 mi re4 do |
  fa2 la2 |
  sol4. do,8 mi4 re |
  do1 |
  \bar ".."
}

bassMusic = \relative do, {
  do4  do8 do re4 mi |
  fa2 fa |
  do4. do8 do4 do |
  sol'1 |
  do,4  do8 do re4 mi |
  fa2 fa |
  do4. do8 sol'4 sol |
  do,1 |
  sol'4 sol8 sol sol4 sol |
  do,2 do |
  do4 do mi do |
  sol'1 |
  do,4  do8 do re4 mi |
  fa2 fa2 |
  sol4. sol8 sol4 sol |
  do,1 |

}

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  Thy life was giv'n for me,
  thy blood, O Lord, was shed,
  that I might ran -- somed be,
  and quick -- ened from the dead;
  thy life was giv'n for me;
  what have I giv'n for thee?
  Thy life was giv'n for me,
  thy blood, O Lord, was shed
}

verseTwo = \lyricmode {
  \tiny
  And thou hast brought to me
  down from thy home a -- bove
  sal -- vat -- ion full and free,
  thy pard -- on and thy love;
  great gifts thou brought -- est me;
  what have I brought to thee?
  And thou hast brought to me
  down from thy home a -- bove
}

% Additional verses if needed
verseThree = \lyricmode {
  \tiny
  O let my life be giv'n
  my years for thee be spent;
  world fett -- ers all be riv'n,
  and joy with suff' -- ring blent:
  thou gav'st thy -- self for me,
  I give my -- self to thee.
  O let my life be giv'n
  my years for thee be spent;
}

verseFour = \lyricmode {
  \tiny
  % Verse 4 lyrics if needed
}

%%%%%%% SCORE %%%%%%%%%
% Main music content (defined once, used for both print and MIDI)
musicContent = {
  <<
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

printMusicContent = <<
  \musicContent
  \context Staff = treble \new Voice {
    \openingShapeVoiceSettings
    \getOpeningShapeTrebleMusic
  }
  \context Staff = alto \new Voice {
    \openingShapeVoiceSettings
    \getOpeningShapeTrebleMusic
  }
  \context Staff = tenor \new Voice {
    \openingShapeVoiceSettings
    \getOpeningShapeTrebleMusic
  }
  \context Staff = bass \new Voice {
    \openingShapeVoiceSettings
    \getOpeningShapeBassMusic
  }
>>

% Score for printing
\score {
  % SINGLE TRANSPOSE for all voices - change songKey at top
  \transpose do \songKey {
    \printMusicContent
  }

  \layout {
    indent = 0\cm
    \context {
      \Score
      \remove "Bar_number_engraver"
      \override SpanBar.stencil = ##f
      \override TimeSignature.break-visibility = ##(#f #t #t)
      \override NoteHead.font-size = #2
      startRepeatBarType = #";"
      endRepeatBarType = #";."
      doubleRepeatBarType = ";.;"
    }
    \context {
      \Staff
      \remove "Rest_collision_engraver"
      \override KeySignature.stencil = ##f
      \override KeyCancellation.stencil = ##f
      \override BarLine.break-visibility = ##(#t #t #f)
      \override TimeSignature.stencil = #singleDigitTimeSignatureStencil
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
