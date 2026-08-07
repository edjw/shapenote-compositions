% relies on ../includes
\language "espanol"
\version "2.26.0"
#(set-default-paper-size "a4landscape")

songKey = "Bb major" % e.g. "e minor", "f# major", "bb major"
songTitle = "Sugar Loaf"
songMeter = "8.7.8.7.8.8"
songComposer = "Ed Johnson-Williams, July 2026"
poetName = "Vernon J. Charlesworth, 1885"
songFooter = ""
timeSignature = 4/4
noteHeadStyle = "seven" % "seven", "four", or "normal (not supported)"
pickupDuration = "0" % "0" = none, "2" = half, "2." = dotted half, "4" = quarter, "4." = dotted quarter, "8" = eighth, "8." = dotted eighth
midiTempo = 100
openingShapeStyle = "root" % "seventh" = si/mi marker, "root" = do/la marker. Always choose seventh in four shapes
showKeySignatureWords = "yes" % "yes" or "no"
% showChoirBrace = ##f % hide the left brace in standard print mode (default ##t)

\include "shapenote-common.ily"

%%%%%%% MUSIC %%%%%%%%%
%
% Beams:                do8[re] (eighth notes and shorter only)
% Dotted notes:         do4. re8
% Octaves:              do'4 (higher) | do,4 (lower)
% Slurs:                do8( re8 mi8)
% Repeats:              \repeat volta 2 { music }
% Ties:                 do4~ do4 (don't tie rests)
% Octave doubling:      <do do,>2 (bass root + octave below)
% Text markings:        do4^\markup { "Fine" }
% Combined:              do8([ re8]) (slur and beam together)
% Rests:                r1 | r2 | r4 | r1. | r2.
% Fermatas:             do4\fermata
% Fine/D.C.:            \mark \markup { \tiny \italic "Fine." }
%                       \mark \markup { \italic \tiny "D.C." }
% Chords:               <do mi sol>4
% Ending barlines:      \bar ".." (standard) | \bar "|." (final) | \bar ".;" (repeat start)
% Line break:           \break (after A section)
% Mid-bar:              \bar ";"
% Alternative endings:  \alternative { { ending1 } { ending2 } }
% Accidentals:          fas4 or sib4 (sharps add s, flats add b)
% Triplets:             \tuplet 3/2 { do8 re8 mi8 }
% Time signature:       \bar ".." \time 3/2
% Repeat+fermata:       \bar ".|:" (put \fermata on last note before it)
% Segno:                do4^\markup { \tiny \musicglyph "scripts.segno" }

trebleMusic = \relative do' {
  r2 mi |

  \repeat volta 2 {

    mi4 mi do si |
    do la sol do |
    sol' la sol do, |
  }

  \alternative {
    {
      mi2 mi4 mi |
    }
    {
      mi2 do |
    }
  }

  do2 re4 mi |
  sol2 mi |
  sol mi |
  sol2. sol4 |
  mi4 re mi re |

  do8[si] la8[si] do4 do

  sol' mi mi mi |
  mi2 sol |
  mi1 |

}

altoMusic = \relative do' {
  r2 sol |
  \repeat volta 2 {
    la4 la la sol |
    sol la sol sol |
    mi mi sol la |

  }

  \alternative {
    {
      sol2 sol4 sol |

    }
    {
      sol2 la |

    }
  }

  do2 sol4 sol |
  sol2 sol |
  mi2 sol |
  sol2. si4 |
  do la8[sol] la4 la |
  sol la8[sol] sol4 sol |
  sol la sol sol |
  sol4(la) si2 |
  sol1 |

}

tenorMusic = \relative do' {
  r2 do |
  \repeat volta 2 {

    la4 la do re |
    mi mi re do |
    do do mi8[re] do8[la] |
  }

  \alternative {
    {
      do2 do4 do |
    }
    { do2 do |  }
  }

  sol'2 sol4 mi |
  re2 do |
  mi sol |
  re2. re4 |
  mi re do la |
  do mi sol do, |
  mi8[re] do[la] do4 do  |
  do2 re |
  do1 |
  \bar ".."
}

bassMusic = \relative do {
  r2 do |
  \repeat volta 2 {

    la4 la la sol |
    do do sol sol |
    do la sol mi |
  }
  \alternative {
    {
      do2 do4 do |
    }
    { do2 do |  }
  }

  do'2 do4 la |
  sol2 la |
  do do |
  sol2. sol4 |
  do8[si] la[sol] do4 re |
  do la sol sol |
  sol la do sol |
  do4(la) sol2 |
  <do do,>1 |

}
%%%%%%%%%%%%%%%%

%%%%%%% LYRICS %%%%%%%%%


% https://hymnary.org/hymn/PH1870/446
% 8, 7, 8 7, 8, 8
verseOne = \lyricmode {
  \tiny
  How blest in Je -- sus' name to meet
  In joy -- ful ad -- or -- at -- ion, And
  _ _
  Though dis -- cord mars the song we raise,
  He loves to hear He loves to hear
  He loves to hear us sing his praise.
}

verseOneRepeat = \lyricmode {
  \tiny

  _ while his mer -- cy we re -- peat,
  And sing his great sal -- _ _ _ va -- tion,

}


verseTwo = \lyricmode {
  \tiny
  We'll cast our crowns, con -- ferred by grace,
  And with the saints a -- dore him; And

  _ _
  No jarr -- ing dis -- cord then we'll raise.
  But per -- fect strains  But per -- fect strains
  But per -- fect strains of heav'n -- ly praise.

}

verseTwoRepeat = \lyricmode {
  \tiny
  _ when we see him face to face,
  In gol -- den show'rs be -- _ _ _ fore him,
}




%%%%%%% LYRICS PLACEMENT %%%%%%%%%
trebleLyrics = <<
  \new Lyrics \lyricsto "treble" { \set stanza = "1." \verseOne }
  \new Lyrics \lyricsto "treble" {
    \verseOneRepeat
  }
>>



tenorLyrics = <<
  \new Lyrics \lyricsto "tenor" {
    \set stanza = "2." \verseTwo
  }

  \new Lyrics \lyricsto "tenor" {
    \verseTwoRepeat
  }
>>


%%%%%%%%%%%%%%%%

\include "shapenote-voices-and-lyrics.ily"

%%%%%%% PRINT MODE %%%%%%%%%
% Uncomment exactly one of shapenote-print-standard.ily and shapenote-print-experimental.ily.


% This is an experimental layout.
% No clef symbols
% Just a big top number for time signature
% A mi/si at the beginning instead of key signature
\include "shapenote-print-experimental.ily"
%%
% \include "shapenote-print-standard.ily"

%%%%%%%%%%%%%%%%


\include "shapenote-midi.ily"
