% This is an experimental layout.
% No clef symbols
% Just a big top number for time signature
% A mi/si at the beginning instead of key signature
%


#(define openingShapeSourceDo (ly:make-pitch -1 0 0))

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

#(define opening-shape-treble-pitch (choose-opening-shape-pitch 4 17 10 'higher))

#(define opening-shape-bass-pitch
   (let ((notename (opening-shape-notename)))
     (if (and notename
              (equal? songMode "major")
              (= (ly:pitch-notename songKey) 5)
              (= (ly:pitch-alteration songKey) 0))
         (ly:make-pitch -2 notename 0)
         (choose-opening-shape-pitch -17 -3 -5))))

% Scale degree -> notehead glyph, mirroring \aikenHeads / \sacredHarpHeads
% in shapenote-common.ily. select-head-glyph is LilyPond's own style->glyph
% function (shared with the \note markup command).
#(define (opening-shape-glyph-name degree)
   (let ((styles (if (equal? noteHeadStyle "four")
                     #(fa sol la fa sol la mi)
                     #(do re miMirror fa sol la ti))))
     (string-append "noteheads.s"
                    (select-head-glyph (vector-ref styles degree) 2))))

% Staff position (in half staff-spaces, 0 = middle line) of the printed
% pitch: diatonic steps from B4 on a treble staff, from D3 on a bass staff.
#(define (opening-shape-staff-position base-pitch bass?)
   (let* ((printed (ly:pitch-transpose base-pitch
                                       (ly:pitch-diff songKey openingShapeSourceDo)))
          (steps (+ (* 7 (ly:pitch-octave printed))
                    (ly:pitch-notename printed))))
     (- steps (if bass? -6 6))))

#(define (opening-shape-marker base-pitch bass?)
   (and base-pitch
        (let ((glyph (opening-shape-glyph-name (ly:pitch-notename base-pitch)))
              (pos (opening-shape-staff-position base-pitch bass?)))
          (markup #:translate (cons 0 (/ pos 2))
                  #:combine
                  (#:override '(font-size . 2) #:musicglyph glyph)
                  (#:override '(font-size . 1) #:translate '(1.8 . -0.58) "›")))))

#(define (opening-shape-name-music staff-name marker)
   (if marker
       #{
         \context Staff = $staff-name {
           \set Staff.instrumentName = $marker
           \set Staff.shortInstrumentName = $marker
         }
       #}
       #{ #}))

trebleOpeningShape =
#(if hasTreble (opening-shape-name-music "treble" (opening-shape-marker opening-shape-treble-pitch #f)) #{ #})

altoOpeningShape =
#(if hasAlto (opening-shape-name-music "alto" (opening-shape-marker opening-shape-treble-pitch #f)) #{ #})

tenorOpeningShape =
#(if hasTenor (opening-shape-name-music "tenor" (opening-shape-marker opening-shape-treble-pitch #f)) #{ #})

bassOpeningShape =
#(if hasBass (opening-shape-name-music "bass" (opening-shape-marker opening-shape-bass-pitch #t)) #{ #})

printMusicContent = <<
  \staffMusic
  \trebleOpeningShape
  \altoOpeningShape
  \tenorOpeningShape
  \bassOpeningShape
>>

\score {
  \transpose do \songKey {
    \printMusicContent
  }

  \layout {
    indent = 0\cm
    short-indent = 0\cm
    \context {
      \Score
      \remove "Bar_number_engraver"
      \override SpanBar.stencil = ##f
      \override TimeSignature.break-visibility = ##(#f #t #t)
      % Put begin-of-line barlines before hidden prefatory slots so a system-opening
      % start-repeat sits on the left edge instead of after invisible time/key space.
      \override BreakAlignment.break-align-orders =
      #(vector
        '(staff-ellipsis left-edge cue-end-clef ambitus breathing-sign optional-material-end-bracket signum-repetitionis clef cue-clef staff-bar key-cancellation key-signature time-signature optional-material-start-bracket custos)
        '(staff-ellipsis left-edge optional-material-end-bracket cue-end-clef ambitus breathing-sign signum-repetitionis clef cue-clef staff-bar key-cancellation key-signature time-signature optional-material-start-bracket custos)
        '(staff-ellipsis left-edge optional-material-end-bracket ambitus breathing-sign signum-repetitionis clef staff-bar key-cancellation key-signature time-signature cue-clef optional-material-start-bracket custos))
      \override VoltaBracket.shorten-pair = #'(0 . 0)
      \override NoteHead.font-size = #2
      startRepeatBarType = #".;"
      endRepeatBarType = #";."
      doubleRepeatBarType = ";.;"
    }
    \context {
      \Staff
      \remove "Rest_collision_engraver"
      % No key signature in this notation; the margin marker replaces it.
      \override KeySignature.stencil = ##f
      \override KeySignature.extra-spacing-width = #'(0 . 0)
      \override KeySignature.X-extent = #'(0 . 0)
      \override KeySignature.space-alist = #'((ambitus . (extra-space . 0.3))
                                              (key-cancellation . (extra-space . 0.3))
                                              (time-signature . (extra-space . 0.3))
                                              (signum-repetitionis . (extra-space . 0.3))
                                              (staff-bar . (extra-space . 0.3))
                                              (cue-clef . (extra-space . 0.3))
                                              (optional-material-end-bracket . (extra-space . 0.3))
                                              (optional-material-start-bracket . (extra-space . 0.3))
                                              (right-edge . (extra-space . 0.3))
                                              (first-note . (extra-space . 0.3)))
      \override BarLine.space-alist = #'((ambitus . (extra-space . 0.3))
                                         (time-signature . (extra-space . 0.3))
                                         (custos . (minimum-space . 0.3))
                                         (clef . (extra-space . 0.3))
                                         (key-signature . (extra-space . 0.3))
                                         (key-cancellation . (extra-space . 0.3))
                                         (optional-material-end-bracket . (extra-space . 0.3))
                                         (optional-material-start-bracket . (extra-space . 0.3))
                                         (first-note . (extra-space . 0.3))
                                         (next-note . (semi-fixed-space . 0.9))
                                         (right-edge . (extra-space . 0.0)))
      \override TimeSignature.style = #'single-number
      \override TimeSignature.space-alist = #'((ambitus . (extra-space . 0.3))
                                               (cue-clef . (extra-space . 0.3))
                                               (custos . (minimum-space . 0.3))
                                               (first-note . (extra-space . 0.3))
                                               (optional-material-start-bracket . (extra-space . 0.3))
                                               (right-edge . (extra-space . 0.3))
                                               (signum-repetitionis . (extra-space . 0.3))
                                               (staff-bar . (extra-space . 0.3)))
      \override Clef.stencil = ##f
      % Marker placement: the markup already carries its own vertical
      % translation (staff position), so pin the grob to the staff centre
      % instead of centring the markup's ink.
      \override InstrumentName.self-alignment-Y = ##f
      \override InstrumentName.padding = #0.3
    }
    \context {
      \Lyrics
      \override LyricText.self-alignment-X = #LEFT
      \override StanzaNumber.padding = #0.35
    }
  }
}
