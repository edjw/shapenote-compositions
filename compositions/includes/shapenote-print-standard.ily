printMusicContent =
#(if showChoirBrace
     #{ \new ChoirStaff << \staffMusic >> #}
     #{ \new ChoirStaff \with {
          \override SystemStartBrace.stencil = ##f
          \override SystemStartBracket.stencil = ##f
        } << \staffMusic >> #})

\score {
  \transpose do \songKey {
    \printMusicContent
  }

  \layout {
    indent = 0\cm
    \context {
      \Score
      \remove "Bar_number_engraver"
      \override TimeSignature.break-visibility = ##(#f #t #t)
      \override TimeSignature.space-alist.staff-bar = #'(extra-space . 0.8)
      \override NoteHead.font-size = #2
      printInitialRepeatBar = ##t
      startRepeatBarType = #";"
      endRepeatBarType = #";."
      doubleRepeatBarType = ";.;"
      sectionBarType = ".."
    }
    \context {
      \Staff
      \override BarLine.space-alist.first-note = #'(fixed-space . 0.6)
    }
    \context {
      \Lyrics
      \override LyricText.self-alignment-X = #LEFT
      \override StanzaNumber.padding = #0.5
    }
  }
}
