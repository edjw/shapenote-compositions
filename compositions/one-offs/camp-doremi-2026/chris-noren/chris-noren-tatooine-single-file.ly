\language "espanol"
\version "2.26.0"
#(set-default-paper-size "a4landscape")


\header {
  title = \markup \fill-line {
    \line {
      % Set the title
      \bold \smaller "Tatooine"
      \hspace #1.5

      % Set the meter
      \small "CM"
    }
  }
  composer = "Chris Noren, July 2026"
  poet = "F Major. Elizabeth Singer Rowe, 1739"
  tagline = ##f
}

global = {
  % change it to minor if you like here
  \key do \major
  % Change it to \sacredHarpHeads if you want four shapes here
  \aikenHeads
  \numericTimeSignature

  % Change the time signature here
  \time 4/4

  \defineBarLine ";" #'("|" ";" " ")
  \defineBarLine ";." #'(#t #f #t)
  \defineBarLine ".;" #'("|" ".;" ".;")
  \defineBarLine ".." #'(".." ".." "..")
  \defineBarLine ";.." #'(";.." ";.." ";..")
  \defineBarLine ";.;" #'(";.;" ";.;" ";.;")
}

%%%%%%% MUSIC %%%%%%%%%

trebleMusic = \relative do'' {
  sol2 mi4. sol8 |
  do,2. sol'4 |
  sol2 la4(si) |
  do2. do4 |
  sol2 sol4(mi) |
  la2 do4(la) |
  sol1 |

  \repeat volta 2 {
    sol2 sol4. mi8 |
    fa2. sol4 |
    do4(sol) mi(la) |
    sol2. r4 |
    r1 |
    r1 |
    r2. sol4 |
    do si la sol |
    sol2. sol4 |
    fa(sol) la(si) |
    do2 si4(la) |
    sol1 |
  }
}

altoMusic = \relative do'' {
  sol2 mi4. sol8 |
  do,2. do4 |
  mi2 re |
  do2. mi4 |
  do2 do4(sol) |
  la2. do4 |
  do1 |

  \repeat volta 2 {
    mi2 mi4. re8 |
    do2. si4 |
    do2 mi4(do) |
    si2. r4 |
    r1 |
    r2. fa'4 |
    mi re do re |
    mi2. do4 |
    mi fa sol mi |
    do re mi re |
    do2 si |
    do1 |
  }
}

tenorMusic = \relative do'' {
  sol2 mi4. sol8 |
  do,2. do4 |
  si2 la |
  sol2. do4 |
  mi2 do4(mi) |
  fa2 sol4(mi) |
  do1 |

  \repeat volta 2 {
    do2 mi4. do8 |
    fa2. re4 |
    sol4(mi do) mi |
    re2. r4 |
    r2. do4 |
    fa sol la fa |
    sol2. sol4 |
    sol la si sol |
    do2. sol4 |
    do4(la) sol(fa) |
    mi2 re |
    do1 |
  }

  \bar ".."
}

bassMusic = \relative do' {
  sol2 mi4. sol8 |
  do,2. do4 |
  sol2 la |
  do2. do4 |
  do(si) la(sol) |
  fa2. sol4 |
  do1 |

  \repeat volta 2 {
    do2 sol4. sol8 |
    la2. si4 |
    do2 do4(la) |
    sol2. sol4 |
    do re mi do |
    fa2. fa4 |
    do re mi do |
    sol2. sol4 |
    do re mi do |
    fa mi re do |
    sol'2 sol, |
    do1 |
  }
}

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  The glor -- ious arm -- ies of the sky
  To Thee, al -- migh -- ty King!
  Har -- mon -- ious an -- thems con -- se -- crate,
  And hal -- le -- lu -- jahs sing.
  And hal -- le -- lu -- jahs sing.
}

verseTwo = \lyricmode {
  \tiny
  But still their most ex -- alt -- ed flights
  Fall vast -- ly short of Thee:
  How dist -- ant then must hu -- man praise
}

verseTwoTrebleEnding = \lyricmode {
  \tiny
  _ _ _ _ _ _ _ _
  _ _ _ _ _ _
  _ _ _ _ _ _ _ _
  And hal -- le -- lu -- jahs sing.
  And hal -- le -- lu -- jahs sing.
}

verseOneTenorEnding = \lyricmode {
  \tiny
  _ _ _ _ _ _ _ _
  _ _ _ _ _ _
  _ _ _ _ _ _ _ _
  And hal -- le -- lu -- jahs sing.
  And hal -- le -- lu -- jahs sing.
  And hal -- le -- lu -- jahs sing.
}

verseTwoTenorEnding = \lyricmode {
  \tiny
  _ _ _ _ _ _ _ _
  _ _ _ _ _ _
  _ _ _ _ _ _ _ _
  From Thy per -- fect -- ions be.
  From Thy per -- fect -- ions be.
  From Thy per -- fect -- ions be.
}

verseOneAltoEntry = \lyricmode {
  \tiny
  _ _ _ _ _ _ _ _
  _ _ _ _ _ _
  _ _ _ _ _ _ _ _
  And hal -- le -- lu -- jahs sing.
  And hal -- le -- lu -- jahs sing.
  And hal -- le -- lu -- jahs sing.
}

verseTwoAltoEntry = \lyricmode {
  \tiny
  _ _ _ _ _ _ _ _
  _ _ _ _ _ _
  _ _ _ _ _ _ _ _
  From Thy per -- fect -- ions be.
  From Thy per -- fect -- ions be.
  From Thy per -- fect -- ions be.
}

verseOneBassEntry = \lyricmode {
  \tiny
  _ _ _ _ _ _ _ _
  _ _ _ _ _ _
  _ _ _ _ _ _ _ _
  And hal -- le -- lu -- jahs sing.
  And hal -- le -- lu -- jahs sing.
  And hal -- le -- lu -- jahs sing.
  And hal -- le -- lu -- jahs sing.
}

verseTwoBassEntry = \lyricmode {
  \tiny
  _ _ _ _ _ _ _ _
  _ _ _ _ _ _
  _ _ _ _ _ _ _ _
  From Thy per -- fect -- ions be.
  From Thy per -- fect -- ions be.
  From Thy per -- fect -- ions be.
  From Thy per -- fect -- ions be.
}

%%%%%%% SCORE %%%%%%%%%

\score {
  % key signature is set with the fa here
  \transpose do fa {
    \new ChoirStaff  <<
      \new Staff = treble <<
        \new Voice = "treble" {
          \global
          \trebleMusic
        }
        \new Lyrics \lyricsto "treble" {
          \set stanza = "1."
          \verseOne
        }
        \new Lyrics \lyricsto "treble" {
          \verseTwoTrebleEnding
        }
      >>

      \new Staff = alto <<
        \new Voice = "alto" {
          \global
          \altoMusic
        }
        \new Lyrics \lyricsto "alto" {
          \verseOneAltoEntry
        }
        \new Lyrics \lyricsto "alto" {
          \verseTwoAltoEntry
        }
      >>

      \new Staff = tenor <<
        \new Voice = "tenor" {
          \global
          \tenorMusic
        }
        \new Lyrics \lyricsto "tenor" {
          \set stanza = "2."
          \verseTwo
        }
        \new Lyrics \lyricsto "tenor" {
          \verseOneTenorEnding
        }
        \new Lyrics \lyricsto "tenor" {
          \verseTwoTenorEnding
        }
      >>

      \new Staff = bass <<
        \clef bass
        \new Voice = "bass" {
          \global
          \bassMusic
        }
        \new Lyrics \lyricsto "bass" {
          \verseOneBassEntry
        }
        \new Lyrics \lyricsto "bass" {
          \verseTwoBassEntry
        }
      >>
    >>
  }

  \layout {
    indent = 0\cm

    \context {
      \Score
      \remove "Bar_number_engraver"
      \override NoteHead.font-size = #2

      printInitialRepeatBar = ##t
      startRepeatBarType = #";"
      endRepeatBarType = #";."
      doubleRepeatBarType = #";.;"
      sectionBarType = #".."
    }

    \context {
      \Staff
    }

    \context {
      \Lyrics
      \override LyricText.self-alignment-X = #LEFT
    }
  }
}

