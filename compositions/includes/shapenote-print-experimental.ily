% This is an experimental layout.
% No clef symbols
% Just a big top number for time signature
% A mi/si at the beginning instead of key signature

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
  \once \override NoteHead.extra-offset = #'(-7 . 0)
}

printMusicContent = <<
  \staffMusic
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

\score {
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
      \override TimeSignature.style = #'single-digit
      \override Clef.stencil = ##f
    }
  }
}
