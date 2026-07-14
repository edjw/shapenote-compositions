% relies on ../includes
\language "espanol"
\version "2.26.0"
#(set-default-paper-size "a4landscape")

% Major: C: do  D: re  E: mi  F: fa  G: sol  A:  la  Bb: sib  Eb: mib
% Minor: A: do  B: re  C#:mi  D: fa  E: sol  F#: la  G: sib   C: mib

songKey = la
songMode = "minor" % "major" or "minor"
songTitle = "Endless Joy"
songMeter = "LM"
songComposer = "Ed Johnson-Williams, June 2026"
poetName = "Isaac Watts, 1707"
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
% Ties:                 do4~ do4
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
% Repeat+fermata:       \bar ".|:" (put \fermata on last note before it)
% Segno:                do4^\markup { \tiny \musicglyph "scripts.segno" }

trebleMusic = \relative do'' {
  la2 mi4 mi |
  la2. sol4 |
  la2 sol |
  mi2. mi4 |
  do mi mi(sol |
  la2) mi2 |
  mi2 sol2 |
  la2 mi4(sol) |
  la2 sol |
  la2.
  \repeat volta 2 {
    \partial 4 r4
    r2. la4 |
    la sol mi mi |
    mi sol la sol |
    mi mi la2~ |
    la2. la4 |
    sol2 la4(sol) |
    la2. sol4 |
    mi2 sol8([la] sol4)
    la2. la4 |
    mi2 mi4(sol) |
    la2 la4 (sol) |
    la2 sol |

  }
  \alternative {
    {
      mi2.
    }
    {
      mi1
    }

  }
}
altoMusic = \relative do {
  mi2 mi4 la |
  la2. sol4 |
  la2 sol |
  mi2. mi4 |
  sol sol mi(sol |
  la2) do4(la) |
  mi2 sol |
  la mi4(sol) |
  la2 sol |
  mi2.
  \repeat volta 2 {
    \partial 4 mi4 |
    la sol mi la |

    la mi la la8[si] |

    do4 re mi(re |
    do1)~ |
    do2. do4 |
    si2 la4 (si) |
    do2. la4 |
    do2 do4 (si) |
    la2. do4 |
    mi2 do4(sol) |
    la2 la4(sol) |
    la2 sol
  }

  \alternative {
    {
      la2.
    }
    {
      la1
    }
  }
}




tenorMusic = \relative do' {
  mi2 la4 la |
  mi2. re4 |
  do2 si |
  la2. mi'4 |
  sol sol sol8([la sol re] |
  mi2) sol4(mi) |
  do2 re |
  mi la4(mi) |
  do2 si |
  la2.
  \repeat volta 2 {
    \partial 4 r4
    r1
    r2. mi'4
    la4 sol mi re
    do mi8[sol] la2~ |
    la2. mi4 |
    re2 do4(re)
    mi2. mi4
    do2 mi4(sol)
    mi2. mi8[sol]
    la2 sol8([la] sol4)
    mi2 mi4(re)
    do2 si
  }
  \alternative {
    {
      la2.
    }
    {
      la1
    }
  }
  \bar ".."
}

bassMusic = \relative do {
  la2 la4 la |
  la2. sol4 |
  la4(sol) mi2 |
  la2. la4 |
  do do do2( |
  la2) do4(la) |
  mi2 mi4(sol) |
  la2 mi4(sol) |
  la4(sol) mi2 |
  la2.
  \repeat volta 2 {
    \partial 4 la4
    do do la mi
    mi sol la2(
    do2. sol4 |
    la1)~ |
    la2. la4
    sol2 la4(sol)
    la2. la4
    do2 do4(re)
    mi2. do4
    la2 do2
    la2 mi4(sol)
    la4(sol) mi2

  }
  \alternative {
    {
      la2.
    }
    {
      la1
    }
  }

}
%%%%%%%%%%%%%%%%

%%%%%%% LYRICS %%%%%%%%%

verseOneTreble = \lyricmode {
  \tiny
  Why should we start and fear to die?
  What tim -- rous worms __ we mor -- tals are
  we mor -- tals are
  Death is the gate
  Death is the gate to end -- less joy
  And yet we dread
  And yet we dread
  And yet we dread to en -- ter there.


}

verseOneAlto = \lyricmode {
  \tiny
  \repeat unfold 20 { \skip 1 }
  Death is the gate
  Death is the gate
  to end -- less joy __

}

verseOneTenor = \lyricmode {
  \tiny
  Why should we start and fear to die?
  What tim -- rous worms __ we mor -- tals are
  we mor -- tals are
  Death is the gate to end -- less joy
  And yet we dread
  And yet we dread
  And yet we __ dread to en -- ter there.
}

verseOneBass = \lyricmode {
  \tiny
  \repeat unfold 20 { \skip 1 }
  Death is the gate to end -- less joy __
}


%%%%%%% LYRICS PLACEMENT %%%%%%%%%
trebleLyrics = <<
  \new Lyrics \lyricsto "treble" {  \verseOneTreble }


>>

altoLyrics = <<


  \new Lyrics \lyricsto "alto" { \verseOneAlto }


>>

tenorLyrics = <<
  \new Lyrics \lyricsto "tenor" {
    \verseOneTenor
  }





>>

bassLyrics = <<
  \new Lyrics \lyricsto "bass" { \verseOneBass }


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
