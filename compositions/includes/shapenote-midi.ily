\score {
  \unfoldRepeats
  \transpose do \songKey {
    <<
      \new ChoirStaff <<
        \new Staff \with {
          midiInstrument = #"soprano sax"
          instrumentName = "Treble"
          midiMinimumVolume = #0.38
          midiMaximumVolume = #0.52
          midiPanPosition = #-0.45
        } {
          \new Voice = "treble" {
            \global
            \trebleMusic
          }
        }
        \new Staff \with {
          midiInstrument = #"tenor sax"
          instrumentName = "Treble (low)"
          midiMinimumVolume = #0.20
          midiMaximumVolume = #0.30
          midiPanPosition = #-0.65
        } {
          \new Voice = "treble-low" {
            \global \transpose do do, { \trebleMusic }
          }
        }

        \new Staff \with {
          midiInstrument = #"alto sax"
          instrumentName = "Alto"
          midiMinimumVolume = #0.36
          midiMaximumVolume = #0.50
          midiPanPosition = #0.75
        } {
          \new Voice = "alto" {
            \global
            \altoMusic
          }
        }
        \new Staff \with {
          midiInstrument = #"trumpet"
          instrumentName = "Tenor"
          midiMinimumVolume = #0.48
          midiMaximumVolume = #0.66
          midiPanPosition = #-0.12
        } {
          \new Voice = "tenor" {
            \global
            \tenorMusic
          }
        }
        \new Staff \with {
          midiInstrument = #"trombone"
          instrumentName = "Tenor (low)"
          midiMinimumVolume = #0.20
          midiMaximumVolume = #0.30
          midiPanPosition = #0.12
        } {
          \new Voice = "tenor-low" {
            \global \transpose do do, { \tenorMusic }
          }
        }

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
            \bassMusic
          }
        }
      >>
    >>
  }

  \midi {
    \context {
      \Score
      tempoWholesPerMinute = #(/ midiTempo 4)
    }
  }
}
