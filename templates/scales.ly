\language "espanol"
%%%%%% Sacred Harp Scale Reference %%%%%%
% Common scales for Sacred Harp and Christian Harmony shape-note singing
% Using Aiken shape noteheads

\version "2.16.00"
#(set-default-paper-size "a4landscape")

\paper {
  ragged-last = ##t
  ragged-bottom = ##t
  system-system-spacing = #'((basic-distance . 4) (padding . 1))
  markup-system-spacing = #'((basic-distance . 2) (padding . 1))
  top-margin = 0.3\in
  bottom-margin = 0.3\in
  left-margin = 0.5\in
  right-margin = 0.5\in
  print-page-number = ##f
  page-count = #1
}

\header {
  title = \markup{ \bold "Sacred Harp Scale Reference" }
  tagline = ##f
}

%%%%%%% MAJOR SCALES %%%%%%%

% C Major
trebleScaleC = \relative do' {
  \key do \major
  \aikenHeads
  \omit TimeSignature
  \cadenzaOn
  do4 re mi fa sol la si do 
  re mi fa sol la si do \bar "||"
}

bassScaleC = \relative do {
  \key do \major
  \aikenHeads
  \omit TimeSignature
  \cadenzaOn
  do4 re mi fa sol la si do 
  re mi fa sol la si do \bar "||"
}

% G Major
trebleScaleG = \relative sol' {
  \key sol \major
  \aikenHeads
  \omit TimeSignature
  \cadenzaOn
  sol4 la si do re mi fas sol 
  la si do re mi fas sol \bar "||"
}

bassScaleG = \relative sol, {
  \key sol \major
  \aikenHeads
  \omit TimeSignature
  \cadenzaOn
  sol4 la si do re mi fas sol 
  la si do re mi fas sol \bar "||"
}

% D Major
trebleScaleD = \relative re' {
  \key re \major
  \aikenHeads
  \omit TimeSignature
  \cadenzaOn
  re4 mi fas sol la si dos re 
  mi fas sol la si dos re \bar "||"
}

bassScaleD = \relative re {
  \key re \major
  \aikenHeads
  \omit TimeSignature
  \cadenzaOn
  re4 mi fas sol la si dos re 
  mi fas sol la si dos re \bar "||"
}

% A Major
trebleScaleA = \relative la {
  \key la \major
  \aikenHeads
  \omit TimeSignature
  \cadenzaOn
  la4 si dos re mi fas sols la 
  si dos re mi fas sols la \bar "||"
}

bassScaleA = \relative la, {
  \key la \major
  \aikenHeads
  \omit TimeSignature
  \cadenzaOn
  la4 si dos re mi fas sols la 
  si dos re mi fas sols la \bar "||"
}

% F Major
trebleScaleF = \relative fa' {
  \key fa \major
  \aikenHeads
  \omit TimeSignature
  \cadenzaOn
  fa4 sol la sib do re mi fa 
  sol la sib do re mi fa \bar "||"
}

bassScaleF = \relative fa {
  \key fa \major
  \aikenHeads
  \omit TimeSignature
  \cadenzaOn
  fa4 sol la sib do re mi fa 
  sol la sib do re mi fa \bar "||"
}

% Bb Major
trebleScaleBb = \relative sib {
  \key sib \major
  \aikenHeads
  \omit TimeSignature
  \cadenzaOn
  sib4 do re mib fa sol la sib 
  do re mib fa sol la sib \bar "||"
}

bassScaleBb = \relative sib, {
  \key sib \major
  \aikenHeads
  \omit TimeSignature
  \cadenzaOn
  sib4 do re mib fa sol la sib 
  do re mib fa sol la sib \bar "||"
}

%%%%%%% MINOR SCALES %%%%%%%

% A minor
trebleScaleAm = \relative la {
  \key la \minor
  \aikenHeads
  \omit TimeSignature
  \cadenzaOn
  la4 si do re mi fa sol la 
  si do re mi fa sol la \bar "||"
}

bassScaleAm = \relative la, {
  \key la \minor
  \aikenHeads
  \omit TimeSignature
  \cadenzaOn
  la4 si do re mi fa sol la 
  si do re mi fa sol la \bar "||"
}

% E minor
trebleScaleEm = \relative mi' {
  \key mi \minor
  \aikenHeads
  \omit TimeSignature
  \cadenzaOn
  mi4 fas sol la si do re mi 
  fas sol la si do re mi \bar "||"
}

bassScaleEm = \relative mi {
  \key mi \minor
  \aikenHeads
  \omit TimeSignature
  \cadenzaOn
  mi4 fas sol la si do re mi 
  fas sol la si do re mi \bar "||"
}

% D minor
trebleScaleDm = \relative re' {
  \key re \minor
  \aikenHeads
  \omit TimeSignature
  \cadenzaOn
  re4 mi fa sol la sib do re 
  mi fa sol la sib do re \bar "||"
}

bassScaleDm = \relative re {
  \key re \minor
  \aikenHeads
  \omit TimeSignature
  \cadenzaOn
  re4 mi fa sol la sib do re 
  mi fa sol la sib do re \bar "||"
}

% G minor
trebleScaleGm = \relative sol' {
  \key sol \minor
  \aikenHeads
  \omit TimeSignature
  \cadenzaOn
  sol4 la sib do re mib fa sol 
  la sib do re mib fa sol \bar "||"
}

bassScaleGm = \relative sol {
  \key sol \minor
  \aikenHeads
  \omit TimeSignature
  \cadenzaOn
  sol4 la sib do re mib fa sol 
  la sib do re mib fa sol \bar "||"
}

%%%%%%%%% LAYOUT %%%%%%%%%%%

% Major scales header
\markup {
  \vspace #0.5
  \bold \large "Major Scales"
  \vspace #0.3
}

% First row
\markup {
  \fill-line {
    % C Major
    \column {
      \bold "C Major"
      \score {
        <<
          \new Staff \with {
            \remove "Time_signature_engraver"
            \override StaffSymbol.staff-space = #0.8
          } {
            \new Voice {
              \trebleScaleC
            }
          }
          \new Staff \with {
            \remove "Time_signature_engraver"
            \override StaffSymbol.staff-space = #0.8
          } {
            \clef bass
            \new Voice {
              \bassScaleC
            }
          }
        >>
        \layout {
          indent = 0\cm
          line-width = 8\cm
          \context {
            \Score
            \remove "Bar_number_engraver"
            \override NoteHead.font-size = #-1
          }
          \context {
            \Staff
            \override VerticalAxisGroup.staff-staff-spacing = #'((basic-distance . 5) (padding . 1))
          }
        }
      }
    }
    
    % G Major
    \column {
      \bold "G Major"
      \score {
        <<
          \new Staff \with {
            \remove "Time_signature_engraver"
            \override StaffSymbol.staff-space = #0.8
          } {
            \new Voice {
              \trebleScaleG
            }
          }
          \new Staff \with {
            \remove "Time_signature_engraver"
            \override StaffSymbol.staff-space = #0.8
          } {
            \clef bass
            \new Voice {
              \bassScaleG
            }
          }
        >>
        \layout {
          indent = 0\cm
          line-width = 8\cm
          \context {
            \Score
            \remove "Bar_number_engraver"
            \override NoteHead.font-size = #-1
          }
          \context {
            \Staff
            \override VerticalAxisGroup.staff-staff-spacing = #'((basic-distance . 5) (padding . 1))
          }
        }
      }
    }
    
    % D Major
    \column {
      \bold "D Major"
      \score {
        <<
          \new Staff \with {
            \remove "Time_signature_engraver"
            \override StaffSymbol.staff-space = #0.8
          } {
            \new Voice {
              \trebleScaleD
            }
          }
          \new Staff \with {
            \remove "Time_signature_engraver"
            \override StaffSymbol.staff-space = #0.8
          } {
            \clef bass
            \new Voice {
              \bassScaleD
            }
          }
        >>
        \layout {
          indent = 0\cm
          line-width = 8\cm
          \context {
            \Score
            \remove "Bar_number_engraver"
            \override NoteHead.font-size = #-1
          }
          \context {
            \Staff
            \override VerticalAxisGroup.staff-staff-spacing = #'((basic-distance . 5) (padding . 1))
          }
        }
      }
    }
  }
}

\markup {
  \vspace #0.8
}

% Second row
\markup {
  \fill-line {
    % A Major
    \column {
      \bold "A Major"
      \score {
        <<
          \new Staff \with {
            \remove "Time_signature_engraver"
            \override StaffSymbol.staff-space = #0.8
          } {
            \new Voice {
              \trebleScaleA
            }
          }
          \new Staff \with {
            \remove "Time_signature_engraver"
            \override StaffSymbol.staff-space = #0.8
          } {
            \clef bass
            \new Voice {
              \bassScaleA
            }
          }
        >>
        \layout {
          indent = 0\cm
          line-width = 8\cm
          \context {
            \Score
            \remove "Bar_number_engraver"
            \override NoteHead.font-size = #-1
          }
          \context {
            \Staff
            \override VerticalAxisGroup.staff-staff-spacing = #'((basic-distance . 5) (padding . 1))
          }
        }
      }
    }
    
    % F Major
    \column {
      \bold "F Major"
      \score {
        <<
          \new Staff \with {
            \remove "Time_signature_engraver"
            \override StaffSymbol.staff-space = #0.8
          } {
            \new Voice {
              \trebleScaleF
            }
          }
          \new Staff \with {
            \remove "Time_signature_engraver"
            \override StaffSymbol.staff-space = #0.8
          } {
            \clef bass
            \new Voice {
              \bassScaleF
            }
          }
        >>
        \layout {
          indent = 0\cm
          line-width = 8\cm
          \context {
            \Score
            \remove "Bar_number_engraver"
            \override NoteHead.font-size = #-1
          }
          \context {
            \Staff
            \override VerticalAxisGroup.staff-staff-spacing = #'((basic-distance . 5) (padding . 1))
          }
        }
      }
    }
    
    % Bb Major
    \column {
      \bold "B♭ Major"
      \score {
        <<
          \new Staff \with {
            \remove "Time_signature_engraver"
            \override StaffSymbol.staff-space = #0.8
          } {
            \new Voice {
              \trebleScaleBb
            }
          }
          \new Staff \with {
            \remove "Time_signature_engraver"
            \override StaffSymbol.staff-space = #0.8
          } {
            \clef bass
            \new Voice {
              \bassScaleBb
            }
          }
        >>
        \layout {
          indent = 0\cm
          line-width = 8\cm
          \context {
            \Score
            \remove "Bar_number_engraver"
            \override NoteHead.font-size = #-1
          }
          \context {
            \Staff
            \override VerticalAxisGroup.staff-staff-spacing = #'((basic-distance . 5) (padding . 1))
          }
        }
      }
    }
  }
}

% Minor scales header
\markup {
  \vspace #1
  \bold \large "Minor Scales"
  \vspace #0.3
}

% Third row
\markup {
  \fill-line {
    % A minor
    \column {
      \bold "A minor"
      \score {
        <<
          \new Staff \with {
            \remove "Time_signature_engraver"
            \override StaffSymbol.staff-space = #0.8
          } {
            \new Voice {
              \trebleScaleAm
            }
          }
          \new Staff \with {
            \remove "Time_signature_engraver"
            \override StaffSymbol.staff-space = #0.8
          } {
            \clef bass
            \new Voice {
              \bassScaleAm
            }
          }
        >>
        \layout {
          indent = 0\cm
          line-width = 8\cm
          \context {
            \Score
            \remove "Bar_number_engraver"
            \override NoteHead.font-size = #-1
          }
          \context {
            \Staff
            \override VerticalAxisGroup.staff-staff-spacing = #'((basic-distance . 5) (padding . 1))
          }
        }
      }
    }
    
    % E minor
    \column {
      \bold "E minor"
      \score {
        <<
          \new Staff \with {
            \remove "Time_signature_engraver"
            \override StaffSymbol.staff-space = #0.8
          } {
            \new Voice {
              \trebleScaleEm
            }
          }
          \new Staff \with {
            \remove "Time_signature_engraver"
            \override StaffSymbol.staff-space = #0.8
          } {
            \clef bass
            \new Voice {
              \bassScaleEm
            }
          }
        >>
        \layout {
          indent = 0\cm
          line-width = 8\cm
          \context {
            \Score
            \remove "Bar_number_engraver"
            \override NoteHead.font-size = #-1
          }
          \context {
            \Staff
            \override VerticalAxisGroup.staff-staff-spacing = #'((basic-distance . 5) (padding . 1))
          }
        }
      }
    }
    
    \null
  }
}

\markup {
  \vspace #0.8
}

% Fourth row
\markup {
  \fill-line {
    % D minor
    \column {
      \bold "D minor"
      \score {
        <<
          \new Staff \with {
            \remove "Time_signature_engraver"
            \override StaffSymbol.staff-space = #0.8
          } {
            \new Voice {
              \trebleScaleDm
            }
          }
          \new Staff \with {
            \remove "Time_signature_engraver"
            \override StaffSymbol.staff-space = #0.8
          } {
            \clef bass
            \new Voice {
              \bassScaleDm
            }
          }
        >>
        \layout {
          indent = 0\cm
          line-width = 8\cm
          \context {
            \Score
            \remove "Bar_number_engraver"
            \override NoteHead.font-size = #-1
          }
          \context {
            \Staff
            \override VerticalAxisGroup.staff-staff-spacing = #'((basic-distance . 5) (padding . 1))
          }
        }
      }
    }
    
    % G minor
    \column {
      \bold "G minor"
      \score {
        <<
          \new Staff \with {
            \remove "Time_signature_engraver"
            \override StaffSymbol.staff-space = #0.8
          } {
            \new Voice {
              \trebleScaleGm
            }
          }
          \new Staff \with {
            \remove "Time_signature_engraver"
            \override StaffSymbol.staff-space = #0.8
          } {
            \clef bass
            \new Voice {
              \bassScaleGm
            }
          }
        >>
        \layout {
          indent = 0\cm
          line-width = 8\cm
          \context {
            \Score
            \remove "Bar_number_engraver"
            \override NoteHead.font-size = #-1
          }
          \context {
            \Staff
            \override VerticalAxisGroup.staff-staff-spacing = #'((basic-distance . 5) (padding . 1))
          }
        }
      }
    }
    
    \null
  }
}