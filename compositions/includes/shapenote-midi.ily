#(define (shape-note-midi-supported-meter? sig)
   (member sig
           '(;; Common meters
              (2 . 4) (2 . 2) (3 . 2) (3 . 4) (4 . 4) (6 . 4) (6 . 8)
              ;; Rare meters
              (3 . 8) (4 . 2) (9 . 8) (12 . 8))))

#(if (not (defined? 'shapeNoteMidiBeatExtraVelocity))
     (module-define! (current-module) 'shapeNoteMidiBeatExtraVelocity
                     (if (and (defined? 'timeSignature)
                              (shape-note-midi-supported-meter? timeSignature))
                         5
                         0)))

#(if (not (defined? 'shapeNoteMidiBarExtraVelocity))
     (module-define! (current-module) 'shapeNoteMidiBarExtraVelocity
                     (if (and (defined? 'timeSignature)
                              (shape-note-midi-supported-meter? timeSignature))
                         3
                         0)))

% Optional music appended only to MIDI playback (for D.C., codas, etc.).
#(if (not (defined? 'trebleMidiSuffix))
     (module-define! (current-module) 'trebleMidiSuffix #{ #}))
#(if (not (defined? 'altoMidiSuffix))
     (module-define! (current-module) 'altoMidiSuffix #{ #}))
#(if (not (defined? 'tenorMidiSuffix))
     (module-define! (current-module) 'tenorMidiSuffix #{ #}))
#(if (not (defined? 'bassMidiSuffix))
     (module-define! (current-module) 'bassMidiSuffix #{ #}))

shapeNoteMidiBeatStructure =
#(cond
  ((equal? timeSignature '(2 . 4)) #{ \set Timing.beatStructure = #'(2) #})
  ((equal? timeSignature '(2 . 2)) #{ \set Timing.beatStructure = #'(2) #})
  ((equal? timeSignature '(3 . 4)) #{ \set Timing.beatStructure = #'(2 1) #})
  ((equal? timeSignature '(3 . 2)) #{ \set Timing.beatStructure = #'(2 1) #})
  ((equal? timeSignature '(4 . 4)) #{ \set Timing.beatStructure = #'(2 2) #})
  ((equal? timeSignature '(6 . 4)) #{ \set Timing.beatStructure = #'(3 3) #})
  ((equal? timeSignature '(6 . 8)) #{ \set Timing.beatStructure = #'(3 3) #})
  ((equal? timeSignature '(3 . 8)) #{ \set Timing.beatStructure = #'(2 1) #})
  ((equal? timeSignature '(4 . 2)) #{ \set Timing.beatStructure = #'(2 2) #})
  ((equal? timeSignature '(9 . 8)) #{ \set Timing.beatStructure = #'(6 3) #})
  ((equal? timeSignature '(12 . 8)) #{ \set Timing.beatStructure = #'(6 6) #})
  (else #{ #}))

trebleMidiStaff =
#(if hasTreble
     #{
       \new Staff \with {
         midiInstrument = #"soprano sax"
         instrumentName = "Treble"
         %         midiMinimumVolume = #0.38
         %         midiMaximumVolume = #0.52
         midiPanPosition = #-0.45
       } {
         \new Voice = "treble" {
           \global
           \shapeNoteMidiBeatStructure
           \trebleMusic
           \trebleMidiSuffix
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
         %         midiMinimumVolume = #0.33
         %         midiMaximumVolume = #0.47
         midiPanPosition = #-0.65
       } {
         \new Voice = "treble-low" {
           \global
           \shapeNoteMidiBeatStructure
           \transpose do do, {
             \trebleMusic
             \trebleMidiSuffix
           }
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
         %         midiMinimumVolume = #0.40
         %         midiMaximumVolume = #0.55
         midiPanPosition = #0.75
       } {
         \new Voice = "alto" {
           \global
           \shapeNoteMidiBeatStructure
           \altoMusic
           \altoMidiSuffix
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
         %         midiMinimumVolume = #0.48
         %         midiMaximumVolume = #0.66
         midiPanPosition = #-0.12
       } {
         \new Voice = "tenor" {
           \global
           \shapeNoteMidiBeatStructure
           \tenorMusic
           \tenorMidiSuffix
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
         %         midiMinimumVolume = #0.43
         %         midiMaximumVolume = #0.61
         midiPanPosition = #0.12
       } {
         \new Voice = "tenor-low" {
           \global
           \shapeNoteMidiBeatStructure
           \transpose do do, {
             \tenorMusic
             \tenorMidiSuffix
           }
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
           \bassMidiSuffix
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
