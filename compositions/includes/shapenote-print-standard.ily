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
      \override NoteHead.font-size = #2
      startRepeatBarType = #".;"
      endRepeatBarType = #";."
      doubleRepeatBarType = ";.;"
    }
  }
}
