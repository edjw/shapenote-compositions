#(if (not (defined? 'showChoirBrace))
     (module-define! (current-module) 'showChoirBrace #t))

% songKey can be written as a plain key name string, e.g.
%   songKey = "e minor"    songKey = "f# major"    songKey = "bb major"
% It is parsed here into the movable-do transposition pitch (for minor keys,
% "do" is the relative major's tonic) plus the text shown top-left on the page.
% The old style (songKey = sol / songMode = "minor") still works unchanged.
#(define (parse-song-key str)
   ;; -> (list do-pitch mode display-text) or #f if unrecognised
   (let* ((parts (filter (lambda (p) (not (string-null? p)))
                         (string-split (string-downcase (string-trim-both str))
                                       #\space))))
     (and (= (length parts) 2)
          (let* ((note (car parts))
                 (mode (cadr parts))
                 (letter (string-ref note 0))
                 (notename (string-index "cdefgab" letter))
                 (alteration
                  (cond
                   ((= (string-length note) 1) 0)
                   ((and (= (string-length note) 2)
                         (memv (string-ref note 1) '(#\# #\♯))) 1/2)
                   ((and (= (string-length note) 2)
                         (memv (string-ref note 1) '(#\b #\♭))) -1/2)
                   (else #f)))
                 (accidental-markup
                  (cond ((eqv? alteration 1/2)
                         (markup #:override '(font-name . "STIXGeneral") "♯"))
                        ((eqv? alteration -1/2)
                         (markup #:override '(font-name . "STIXGeneral") "♭"))
                        (else ""))))
            (and notename alteration (member mode '("major" "minor"))
                 (let* ((tonic (ly:make-pitch -1 notename alteration))
                        (do-pitch
                         (if (string=? mode "minor")
                             ;; relative major tonic, kept in the same octave
                             ;; as the old syllable table (bare do..si)
                             (let ((rel (ly:pitch-transpose
                                         tonic (ly:make-pitch 0 2 -1/2))))
                               (ly:make-pitch -1
                                              (ly:pitch-notename rel)
                                              (ly:pitch-alteration rel)))
                             tonic)))
                   (list do-pitch
                         mode
                         (make-concat-markup
                          (list (string (char-upcase letter))
                                accidental-markup
                                " "
                                (if (string=? mode "minor")
                                    "Minor"
                                    "Major"))))))))))

#(define (key-label-markup text)
   (let ((sharp-position (string-index text #\♯))
         (flat-position (string-index text #\♭)))
     (cond
      (sharp-position
       (make-concat-markup
        (list (substring text 0 sharp-position)
              (markup #:override '(font-name . "STIXGeneral") "♯")
              (substring text (+ sharp-position 1)))))
      (flat-position
       (make-concat-markup
        (list (substring text 0 flat-position)
              (markup #:override '(font-name . "STIXGeneral") "♭")
              (substring text (+ flat-position 1)))))
      (else text))))

#(if (and (defined? 'songKey) (string? songKey))
     (let ((parsed (parse-song-key songKey)))
       (if parsed
           (begin
             (module-define! (current-module) 'songKeyText (caddr parsed))
             (module-define! (current-module) 'songMode (cadr parsed))
             (module-define! (current-module) 'songKey (car parsed)))
           (ly:error "Unrecognised songKey ~s — expected e.g. \"e minor\", \"f# major\" or \"bb major\"" songKey))))

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

getKeySignature =
#(if (defined? 'songKeyText)
   songKeyText
   (let* ((key-pitch (if (defined? 'songKey) songKey (ly:make-pitch 0 0 0)))
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
       (key-label-markup (cdr result))
       "Unknown Key")))

\paper {
  page-count = #1
  system-count = #2
  system-system-spacing = #'((basic-distance . 0) (padding . 6))
  markup-system-spacing = #'((basic-distance . 12) (padding . 4))
  top-margin = 1.25\cm
  bottom-margin = 1.25\cm
}

\header {
  title = \markup \fill-line {
    \null
    \line {
      \bold \smaller #songTitle
      \with-dimensions #'(0 . 0) #'(0 . 0)
      \line { \hspace #1.5 \small #songMeter }
    }
    \null
  }
  composer = #songComposer
  tagline =
  #(if (defined? 'songFooter)
       #{ \markup { \tiny #songFooter } #}
       #f)
  poet = \markup{
    \concat {
      #(if (and (defined? 'showKeySignatureWords)
                (equal? showKeySignatureWords "no"))
           ""
           getKeySignature)
      #(if (and (not (and (defined? 'showKeySignatureWords)
                          (equal? showKeySignatureWords "no")))
                (not (string-null? poetName)))
           ". "
           "")
      #(if (not (string-null? poetName))
           poetName
           "")
    }
  }
}

setShapeHeads =
#(cond
  ((equal? noteHeadStyle "seven") #{ \aikenHeads #})
  ((equal? noteHeadStyle "four") #{ \sacredHarpHeads #})
  (else #{ #}))

global = {
  \key do \major
  \setShapeHeads
  \setPickup
  \numericTimeSignature
  \time #timeSignature
  \defineBarLine ";" #'("|" ";" " ")
  \defineBarLine ";." #'(#t "" #t)
  \defineBarLine ".;" #'("|" ".;" ".;")
  \defineBarLine ".." #'(".." ".." "..")
  \defineBarLine ";.." #'(";.." ";.." ";..")
  \defineBarLine ";.;" #'(";.;" ";.;" ";.;")
  \autoBeamOff
}
