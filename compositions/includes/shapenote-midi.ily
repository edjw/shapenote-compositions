#(define (shape-note-midi-supported-meter? sig)
   (member sig '((2 . 4) (2 . 2) (3 . 4) (4 . 4) (6 . 4) (6 . 8))))

#(if (not (defined? 'shapeNoteMidiBeatExtraVelocity))
     (module-define! (current-module) 'shapeNoteMidiBeatExtraVelocity
                     (if (and (defined? 'timeSignature)
                              (shape-note-midi-supported-meter? timeSignature))
                         9
                         0)))

#(if (not (defined? 'shapeNoteMidiBarExtraVelocity))
     (module-define! (current-module) 'shapeNoteMidiBarExtraVelocity
                     (if (and (defined? 'timeSignature)
                              (shape-note-midi-supported-meter? timeSignature))
                         4
                         0)))

shapeNoteMidiBeatStructure =
#(cond
  ((equal? timeSignature '(4 . 4)) #{ \set Timing.beatStructure = #'(2 2) #})
  ((equal? timeSignature '(2 . 2)) #{ \set Timing.beatStructure = #'(1 1) #})
  ((equal? timeSignature '(2 . 4)) #{ \set Timing.beatStructure = #'(2) #})
  ((equal? timeSignature '(3 . 4)) #{ \set Timing.beatStructure = #'(2 1) #})
  ((equal? timeSignature '(6 . 4)) #{ \set Timing.beatStructure = #'(3 3) #})
  ((equal? timeSignature '(6 . 8)) #{ \set Timing.beatStructure = #'(3 3) #})
  (else #{ #}))

trebleMidiStaff =
#(if hasTreble
     #{
       \new Staff \with {
         midiInstrument = #"soprano sax"
         instrumentName = "Treble"
         midiMinimumVolume = #0.38
         midiMaximumVolume = #0.52
         midiPanPosition = #-0.45
       } {
         \new Voice = "treble" {
           \global
           \shapeNoteMidiBeatStructure
           \trebleMusic
         }
       }
     #}
     #{ #})

trebleLowMidiStaff =
#(if hasTreble
     #{
       \new Staff \with {
         midiInstrument = #"tenor sax"
         instrumentName = "Treble (low)"
         midiMinimumVolume = #0.20
         midiMaximumVolume = #0.30
         midiPanPosition = #-0.65
       } {
         \new Voice = "treble-low" {
           \global
           \shapeNoteMidiBeatStructure
           \transpose do do, { \trebleMusic }
         }
       }
     #}
     #{ #})

altoMidiStaff =
#(if hasAlto
     #{
       \new Staff \with {
         midiInstrument = #"alto sax"
         instrumentName = "Alto"
         midiMinimumVolume = #0.36
         midiMaximumVolume = #0.50
         midiPanPosition = #0.75
       } {
         \new Voice = "alto" {
           \global
           \shapeNoteMidiBeatStructure
           \altoMusic
         }
       }
     #}
     #{ #})

tenorMidiStaff =
#(if hasTenor
     #{
       \new Staff \with {
         midiInstrument = #"trumpet"
         instrumentName = "Tenor"
         midiMinimumVolume = #0.48
         midiMaximumVolume = #0.66
         midiPanPosition = #-0.12
       } {
         \new Voice = "tenor" {
           \global
           \shapeNoteMidiBeatStructure
           \tenorMusic
         }
       }
     #}
     #{ #})

tenorLowMidiStaff =
#(if hasTenor
     #{
       \new Staff \with {
         midiInstrument = #"trombone"
         instrumentName = "Tenor (low)"
         midiMinimumVolume = #0.20
         midiMaximumVolume = #0.30
         midiPanPosition = #0.12
       } {
         \new Voice = "tenor-low" {
           \global
           \shapeNoteMidiBeatStructure
           \transpose do do, { \tenorMusic }
         }
       }
     #}
     #{ #})

bassMidiStaff =
#(if hasBass
     #{
       \new Staff \with {
         midiInstrument = #"tuba"
         instrumentName = "Bass"
         midiMinimumVolume = #0.40
         midiMaximumVolume = #0.54
         midiPanPosition = #0.55
       } {
         \clef bass
         \new Voice = "bass" {
           \global
           \shapeNoteMidiBeatStructure
           \bassMusic
         }
       }
     #}
     #{ #})

\score {
  \unfoldRepeats
  \transpose do \songKey {
    <<
      \new ChoirStaff <<
        \trebleMidiStaff
        \trebleLowMidiStaff
        \altoMidiStaff
        \tenorMidiStaff
        \tenorLowMidiStaff
        \bassMidiStaff
      >>
    >>
  }

  \midi {
    \context {
      \Score
      tempoWholesPerMinute = #(/ midiTempo 4)
    }
    \context {
      \Voice
      \consists "Beat_performer"
      beatExtraVelocity = #shapeNoteMidiBeatExtraVelocity
      barExtraVelocity = #shapeNoteMidiBarExtraVelocity
    }
  }
}
