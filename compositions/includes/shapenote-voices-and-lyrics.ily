staffMusic = <<
  \new Staff = treble <<
    \new Voice = "treble" {
      \global
      \trebleMusic
    }
    \trebleLyrics
  >>

  \new Staff = alto <<
    \new Voice = "alto" {
      \global
      \altoMusic
    }
    \altoLyrics
  >>

  \new Staff = tenor <<
    \new Voice = "tenor" {
      \global
      \tenorMusic
    }
    \tenorLyrics
  >>

  \new Staff = bass <<
    \clef bass
    \new Voice = "bass" {
      \global
      \bassMusic
    }
    \bassLyrics
  >>
>>
