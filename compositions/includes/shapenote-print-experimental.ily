% This is an experimental layout.
% No clef symbols
% Just a big top number for time signature
% A mi/si at the beginning instead of key signature

#(define openingShapeSourceDo (ly:make-pitch -1 0 0))
#(define openingShapeQuarterDuration (ly:make-duration 2 0 1))

% openingShapeStyle values:
%   "root"    = do/la marker (default)
%   "seventh" = si/mi marker
% Four-shape notation ignores this and always uses the seventh marker.
#(if (not (defined? 'openingShapeStyle))
     (module-define! (current-module) 'openingShapeStyle "root"))

#(define (opening-shape-notename)
   (cond
    ((equal? noteHeadStyle "four") 6)
    ((equal? noteHeadStyle "seven")
     (if (equal? openingShapeStyle "root")
         (if (equal? songMode "minor") 5 0)
         6))
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
                     #:translate '(1.8 . -0.58)
                     "›"))))
     (ly:stencil-add notehead chevron)))

% The opening note only prints on system 1. To repeat it, register the note grob
% per staff and replay its stencil through the KeySignature (reprinted on every
% system). Read on demand at replay time so note/keysig stencil order is irrelevant.
#(define opening-shape-store (make-hash-table))

% Slide the replayed marker left onto the far-left edge (extra-offset, since a
% stencil translate just gets cancelled by the prefatory spacing).
#(define opening-shape-keysignature-x-offset -3.5)

#(define ((opening-shape-register key) grob)
   (hash-set! opening-shape-store key grob)
   '())

#(define (opening-shape-at-start? grob)
   (let ((when (ly:grob-property (ly:item-get-column grob) 'when)))
     (and (= (ly:moment-main when) 0)
          (= (ly:moment-grace when) 0))))

#(define ((opening-shape-keysignature key) grob)
   (let ((note (hash-ref opening-shape-store key #f)))
     (if (or (not note) (opening-shape-at-start? grob))
         ;; System 1 blanks here; the note draws the marker itself.
         empty-stencil
         (ly:stencil-translate-axis
          (ly:grob-property note 'stencil)
          (/ (ly:grob-property note 'staff-position) 2)
          Y))))

#(define (choose-opening-shape-pitch low-semitone high-semitone target-semitone . tie-preference)
   (let ((note-name (opening-shape-notename))
         (prefer-higher? (and (pair? tie-preference)
                              (eq? (car tie-preference) 'higher))))
     (if (not note-name)
         #f
         (let* ((transpose-interval (ly:pitch-diff songKey openingShapeSourceDo))
                (candidate-octaves '(-3 -2 -1 0 1 2)))
           (let loop ((octaves candidate-octaves)
                      (best-pitch #f)
                      (best-score #f)
                      (best-semitone #f))
             (if (null? octaves)
                 best-pitch
                 (let* ((base-pitch (ly:make-pitch (car octaves) note-name 0))
                        (printed-pitch (ly:pitch-transpose base-pitch transpose-interval))
                        (printed-semitone (ly:pitch-semitones printed-pitch))
                        (in-range (and (>= printed-semitone low-semitone)
                                       (<= printed-semitone high-semitone)))
                        (distance (abs (- printed-semitone target-semitone)))
                        (score (+ distance (if in-range 0 1000)))
                        (better? (or (not best-score)
                                     (< score best-score)
                                     (and (= score best-score)
                                          best-semitone
                                          prefer-higher?
                                          (> printed-semitone best-semitone)))))
                   (if better?
                       (loop (cdr octaves) base-pitch score printed-semitone)
                       (loop (cdr octaves) best-pitch best-score best-semitone)))))))))

getOpeningShapeTrebleMusic =
#(make-opening-shape-music (choose-opening-shape-pitch 4 17 10 'higher))

getOpeningShapeBassMusic =
#(let ((notename (opening-shape-notename)))
   (make-opening-shape-music
    (if (and notename
             (equal? songMode "major")
             (= (ly:pitch-notename songKey) 5)
             (= (ly:pitch-alteration songKey) 0))
        (ly:make-pitch -2 notename 0)
        (choose-opening-shape-pitch -17 -3 -5))))

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
    \override Staff.KeySignature.stencil = #(opening-shape-keysignature 'treble)
    \once \override NoteHead.before-line-breaking = #(opening-shape-register 'treble)
    \getOpeningShapeTrebleMusic
  }
  \context Staff = alto \new Voice {
    \openingShapeVoiceSettings
    \override Staff.KeySignature.stencil = #(opening-shape-keysignature 'alto)
    \once \override NoteHead.before-line-breaking = #(opening-shape-register 'alto)
    \getOpeningShapeTrebleMusic
  }
  \context Staff = tenor \new Voice {
    \openingShapeVoiceSettings
    \override Staff.KeySignature.stencil = #(opening-shape-keysignature 'tenor)
    \once \override NoteHead.before-line-breaking = #(opening-shape-register 'tenor)
    \getOpeningShapeTrebleMusic
  }
  \context Staff = bass \new Voice {
    \openingShapeVoiceSettings
    \override Staff.KeySignature.stencil = #(opening-shape-keysignature 'bass)
    \once \override NoteHead.before-line-breaking = #(opening-shape-register 'bass)
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
      startRepeatBarType = #".;"
      endRepeatBarType = #";."
      doubleRepeatBarType = ";.;"
    }
    \context {
      \Staff
      \remove "Rest_collision_engraver"
      % KeySignature.stencil is set per staff in printMusicContent (opening shape).
      \override KeySignature.extra-offset = #(cons opening-shape-keysignature-x-offset 0)
      \override KeyCancellation.stencil = ##f
      % Begin-of-line must stay visible so a start-repeat shows its dots at the
      % top of a system; plain barlines have an empty begin-of-line glyph anyway.
      \override BarLine.break-visibility = ##(#t #t #t)
      \override TimeSignature.style = #'single-number
      \override Clef.stencil = ##f
    }
    \context {
      \Lyrics
      \override LyricText.self-alignment-X = #LEFT
    }
  }
}
