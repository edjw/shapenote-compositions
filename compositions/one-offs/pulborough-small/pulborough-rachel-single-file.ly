\language "espanol"
\version "2.26.0"
#(set! paper-alist (cons '("7x4.25" . (cons (* 7 in) (* 4.25 in))) paper-alist))
#(set-default-paper-size "7x4.25")

\paper {
  page-count = #2
  system-count = #2
  print-page-number = ##f
  evenHeaderMarkup = \markup \null
  system-system-spacing = #'((basic-distance . 0) (padding . 6))
  markup-system-spacing = #'((basic-distance . 6) (padding . 1))
  top-margin = 0.75\cm
  bottom-margin = 0.75\cm
}

\header {
  title = \markup \fill-line {
    \null
    \line {
      \bold \smaller "Pulborough"
      \with-dimensions #'(0 . 0) #'(0 . 0)
        \line { \hspace #1.5 \small "7.6.7.6.7.7.7.6" }
    }
    \null
  }
  composer = "Ed Johnson-Williams, May 2026"
  poet = "C Major. John Newton"
  tagline = ##f
}

global = {
  \key do \major
  \sacredHarpHeads
  \numericTimeSignature
  \time 2/4

  \defineBarLine ";" #'("|" ";" " ")
  \defineBarLine ";." #'(#t #f #t)
  \defineBarLine ".;" #'("|" ".;" ".;")
  \defineBarLine ".." #'(".." ".." "..")
  \defineBarLine ";.." #'(";.." ";.." ";..")
  \defineBarLine ";.;" #'(";.;" ";.;" ";.;")

  \autoBeamOff
}

%%%%%%% MUSIC %%%%%%%%%

trebleMusic = \relative do'' {
  \repeat volta 2 {
    mi4. mi8 |
    re4 do |
    sol' sol |
    mi re |
    mi4. mi8 |
    do4 do4 |
    mi2-\tweak font-size #-2 -\tweak font-shape #'italic ^"Fine." |
  }

  sol4. sol8 |
  mi4 sol |
  sol4 mi |
  mi2 |
  do4. la8 |
  sol4 do |
  mi sol |
  sol2-\tweak font-size #-2 -\tweak font-shape #'italic ^"D.C." |
}

altoMusic = \relative do'' {
  \repeat volta 2 {
    sol4. mi8 |
    sol4 mi |
    sol mi |
    do re |
    mi4. mi8 |
    mi4 sol |
    sol2 |
  }

  mi4. mi8 |
  mi4 mi |
  sol sol |
  mi2 |
  sol4. la8 |
  sol4 sol |
  mi4 sol |
  sol2 |
}

tenorMusic = \relative do'' {
  \repeat volta 2 {
    do4. la8 |
    sol4 sol |
    do8[ re] mi4 |
    do sol |
    la4. do8 |
    mi4 do |

    \newSpacingSection
    \override Score.SpacingSpanner.spacing-increment = #0.1
    do2-\tweak font-size #-2 -\tweak font-shape #'italic ^"Fine." |
    \newSpacingSection
    \revert Score.SpacingSpanner.spacing-increment
  }

  \break
  do4. mi8 |
  sol4 mi |
  mi8[ re] do4 |
  mi2 |
  mi4. fa8 |
  sol4 mi |
  la8[ sol] mi4 |

  \newSpacingSection
  \override Score.SpacingSpanner.spacing-increment = #0.1
  re2-\tweak font-size #-2 -\tweak font-shape #'italic ^"D.C."
  \newSpacingSection
  \revert Score.SpacingSpanner.spacing-increment

  \bar ".."
}

bassMusic = \relative do {
  \repeat volta 2 {
    do4. mi8 |
    sol4 mi |
    sol sol |
    la sol |
    la4. sol8 |
    mi4 do |
    do2 |
  }

  do4. do8 |
  sol'4 sol |
  sol sol |
  la2 |
  do4. do8 |
  sol4 mi |
  do4 mi |
  sol2 |
}

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  Stop, poor sin -- ners, stop and think,
  Be -- fore you fur -- ther go!

  On the verge of ru -- in stop!
  Now the friend -- ly warn -- ing take
}

verseOneB = \lyricmode {
  \tiny
  Will you sport up -- on the brink
  Of ev -- er last -- ing woe!
}

verseOneC = \lyricmode {
  \tiny
  Stay your foot -- steps, ere ye drop
  In -- to the burn -- ing lake.
}

verseTwo = \lyricmode {
  \tiny
  Though your heart be made of steel,
  Your fore -- head lined with brass;

  Sin -- ners then in vain will call
  Those who now des -- pise His grace
}

verseTwoB = \lyricmode {
  \tiny
  God at length will make you feel;
  He will not let you pass;
}

verseTwoC = \lyricmode {
  \tiny
  Rocks and moun -- tains, on us fall,
  And hide us from His face.
}

%%%%%%% PRINT SCORE %%%%%%%%%

\score {
  \transpose do do {
    \new ChoirStaff \with {
      % Hide the brace at the far left, as in the small-print version.
      \override SystemStartBrace.stencil = ##f
      \override SystemStartBracket.stencil = ##f
    } <<
      \new Staff = treble <<
        \new Voice = "treble" {
          \global
          \trebleMusic
        }
        \new Lyrics \lyricsto "treble" {
          \set stanza = "1." \verseOne
        }
        \new Lyrics \lyricsto "treble" {
          \verseOneB
        }
        \new Lyrics \lyricsto "treble" {
          \set stanza = "DC." \verseOneC
        }
      >>

      \new Staff = alto <<
        \new Voice = "alto" {
          \global
          \altoMusic
        }
      >>

      \new Staff = tenor <<
        \new Voice = "tenor" {
          \global
          \tenorMusic
        }
        \new Lyrics \lyricsto "tenor" {
          \set stanza = "2." \verseTwo
        }
        \new Lyrics \lyricsto "tenor" {
          \verseTwoB
        }
        \new Lyrics \lyricsto "tenor" {
          \set stanza = "DC." \verseTwoC
        }
      >>

      \new Staff = bass <<
        \clef bass
        \new Voice = "bass" {
          \global
          \bassMusic
        }
      >>
    >>
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
      doubleRepeatBarType = #";.;"
    }
  }
}
