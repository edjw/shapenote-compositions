% relies on ../includes
\language "espanol"
\version "2.26.0"
#(set-default-paper-size "a4landscape")

% Major: C: do  D: re  E: mi  F: fa  G: sol  A:  la  Bb: sib  Eb: mib
% Minor: A: do  B: re  C#:mi  D: fa  E: sol  F#: la  G: sib   C: mib

songKey = sol
songMode = "major" % "major" or "minor"
songTitle = "Chalfont"
songMeter = ""
songComposer = "Ed Johnson-Williams, June 2026"
poetName = "Isaac Penington, 1661"
songFooter = "An early Quaker text. See 'Quaker faith & practice' 26.70"
timeSignature = 4/4
noteHeadStyle = "seven" % "seven", "four", or "normal (not supported)"
pickupDuration = "0" % "0" = none, "2" = half, "2." = dotted half, "4" = quarter, "4." = dotted quarter, "8" = eighth, "8." = dotted eighth
midiTempo = 90

\include "shapenote-common.ily"

\paper {
  page-count = #3
  system-count = #6
  left-margin = 1.25\cm
  right-margin = 1.25\cm

}

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
% Repeat+fermata:       \bar ".|:" (put \fermata on last note before it)
% Segno:                do4^\markup { \tiny \musicglyph "scripts.segno" }

trebleMusic = \relative do'' {
  sol2 sol |
  mi2 la4 la |
  sol2 mi |
  sol do |
  la2 sol4 la |
  sol2 sol |
  do2 do |
  do4 sol mi sol |
  sol2 mi |
  sol4(la) sol2~ |
  sol2 sol |
  la1 |
  sol4 la sol2~ |
  sol1
  \time 6/8
  r2 r8 sol |
  sol4 mi8 re8[mi] sol |
  sol4.~ sol4 sol8 |
  do4 sol8 la8[do] la8 |
  sol4.~ sol4 sol8 |
  sol4 mi8 mi8[sol] do8 |
  do4.~ do4 sol8 |
  mi4 mi8 mi4 sol8 |
  sol4.~ sol4 sol8 |
  \repeat volta 2 {
    do4 do8 la4 sol8 |
    la4.~ la4 sol8 |
    mi4 mi8 sol4 la8 |
  }
  \alternative {
    {
      sol4 la8 sol4 sol8 |
    }
    {
      sol4. sol4. |
    }
  }
  sol2. |

  r2. |
  r2 r8 sol8 |
  do4 do8 do8 sol r |
  r2 r8 do |
  sol4 la8 do do r  |
  r2 r8 sol8 |
  do4 sol8 do4 la8 |
  sol4.~ sol4 sol8 |
  \time 4/4
  \repeat volta 2 {
    sol4 la sol sol8[la] |
    sol4 mi8[sol] do4 sol |
    do4 sol sol do8[la] |
    sol2. sol4 |
    do4 sol2 la4 |
    do2. sol4 |
    sol2. la4 |
    sol2. do4 |
    sol2. mi4 |
    sol8[(mi do mi] sol4) mi |

    sol2 mi |
    la2.(sol4) |
  }
  \alternative {
    {sol2. sol4}]{  sol1 |}
  }

}

altoMusic = \relative do' {
  mi4(re) do2 |
  sol2 la4 do |
  re2 do |
  re4(mi) mi2 |
  mi2 do4 la |
  sol2 sol |
  sol4(la) do2 |
  do4 do la sol |
  do2 do |
  do2 re2~ |
  re2 mi |
  mi1 |
  mi4 re do2~ |
  do1 |
  \time 6/8
  r2 r8 sol |
  sol4 sol8 sol4 sol8 |
  do4.~ do4 do8 |
  do4 re8 mi4 mi8 |
  re4.~ re4 re8 |
  mi4 do8 sol4 sol8 |
  sol4.~ sol4 sol8 |
  la4 sol8 sol4 sol8 |
  do4.~ do4 sol8 |
  \repeat volta 2 {
    do4 do8 mi4 re8 |
    mi4.~ mi4 re8 |
    do4 la8 sol4 la8 |


  }

  \alternative {
    {
      do4 do8 sol4 sol8
    }
    {
      do4. re4. |
    }
  }
  mi2. |
  r2 r8 do8 |
  mi4 re8 do4 r8 |
  r2 r8 do8 |
  sol4 sol8 do4 r8 |
  r2 r8 sol8 |
  do4 re8 mi4 mi8 |
  mi8[re] do8 sol4 la8 |
  sol4.~ sol4 sol8 |
  \time 4/4
  \repeat volta 2 {
    do4 do re mi |
    mi8[re] do[re] mi4 do |
    sol4 sol sol do |
    re2. re4 |
    mi4 mi2 do4 |
    mi4(do2) mi4 |
    re2. do4 |
    re2. do4 |
    sol2. sol4 |
    do2. do4 |
    re2 do |
    do4.(re8 mi4 re) |
  }
  \alternative {
    {  do2. do4|}
    {  do1 |}
  }

}

tenorMusic = \relative do' {
  do4(re) mi2 |
  mi2 fa4 mi |
  re2 do |
  re4(do) la2 |
  la2 do4 mi |
  re2 re |
  do4(mi) sol2 |
  mi4 sol la sol |
  mi2 do |
  do4(mi) re2~ |
  re2 do |
  la1 |
  sol4 la do2~ |
  do1 \break |
  \time 6/8
  r2 r8 sol
  do4 do8 re[do] re |
  mi4.~ mi4 sol8 |
  sol4 sol8 la[sol] mi |
  re4.~ re4 sol,8
  do4 do8 mi[re] mi |
  sol4.~ sol4 sol8 |
  la4 sol8 mi4 re8 |
  do4.~ do4 sol'8 |
  \break
  \repeat volta 2 {
    sol4 sol8 la4 sol8 |
    la4.~ la4 sol8 |
    do4 la8 sol4 fa8 |
  }

  \alternative {
    {
      mi4 mi8 mi8[re] mi
    }
    {
      mi4. re4. |
    }
  }
  do2. \break |
  r2. |
  r2 r8 sol'8 |
  sol4 la8 sol mi8 r8 |
  r2 r8 la8 |
  do4 la8 sol mi r |
  r2 r8 sol8 |
  sol4 mi8 sol4 mi8 |
  re4.~ re4 do8 \break |
  \time 4/4
  \repeat volta 2 {
    do4 mi re sol,8[la] |
    do8[si] la[sol] do4 do |
    do mi re mi8[fa] |
    sol2. sol4 |
    la4 do2 la4 |
    sol4(mi2) sol4|
    sol2. la4 |
    sol2. sol4 |
    do2. sol4 |
    do8[(la sol la] do4) la |
    sol2 la |
    mi4.(re8 do4 re)
  }

  \alternative {
    {  do2. do4|}
    {  do1 |}
  }


  \bar ".."
}

bassMusic = \relative do {
  do2 do |
  do2 do4 la |
  sol2 sol |
  sol2 la |
  la2 do4 la |
  sol2 sol |
  do2 do |
  do4 sol do re |
  mi2 do |
  do4(la) sol2~ |
  sol2 do |
  do1 |
  mi4 re4 do2~ |
  do1 |
  \time 6/8
  r2 r8 sol |
  do4 do8 sol4 sol8 |
  do4.~ do4 do8 |
  sol4 sol8 mi4 mi8 |
  sol4.~ sol4 sol8 |
  do4 do8 sol4 sol8 |
  do4.~ do4 do8 |
  la4 sol8 sol4 sol8 |
  do4.~ do4 do8 |


  \repeat volta 2 {
    do4 sol8 mi4 sol8 |
    la4.~ la4 sol8 |
    do4 mi8 do4 do8 |
  }

  \alternative {
    {

      do4 la8 sol4 do8
    }
    {
      do4. sol4.

    }
  }

  do2. |

  r2 r8 sol8 |
  do4 re8 mi4 r8 |
  r2 r8 sol,8 |
  do4 re8 mi4 r8 |
  r2 r8 sol,8 |
  mi'4 re8 do4 do8 |
  do4 do8 do4 do8  |
  sol4.~ sol4 do8 |
  \time 4/4
  \repeat volta 2 {
    do4 la sol  sol8[mi] |
    sol4 la8[sol] do4 sol |
    do mi re do |
    sol2. sol4 |
    la do2 mi4 |
    do2. mi4 |
    re2. do4 |
    sol2. sol4 |
    do2. do4 |
    do2. la4 |
    sol2 la |
    la2.(sol4) |
  }

  \alternative {
    {  do2. do4|}
    {  do1 |}
  }
  \bar ".."
}

%%%%%%%%%%%%%%%%

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  Give o -- ver thine own will -- ing,
  give o -- ver thy own runn -- ing,
  give o -- ver thine own de -- sir -- ing
  to know or be a -- ny -- thing
  and sink down to the
  seed which God sows in the heart,
  and sink down to the
  seed which God sows in the heart,
  and let that grow in thee
  and be in thee and breathe in thee and
  act in thee;
  %  and thou shalt find
  by sweet ex -- per -- ience
  %  and thou shalt find
  by sweet ex -- per -- ience
  %  and thou shalt find
  by sweet ex -- per -- ience
  that the Lord knows that and loves and owns that,
  and will lead it to
  the in -- her -- it -- ance of Life,
  of Life,
  of Life,
  of Life, __
  which is its por -- tion. the
  -tion
}

bassAltoFindLyrics = \lyricmode {
  \tiny
  \repeat unfold 71 { \skip 1 }
  and thou shalt find
  and thou shalt find
  and thou shalt find
}

%%%%%%% LYRICS PLACEMENT %%%%%%%%%
trebleLyrics = <<
  \new Lyrics \lyricsto "treble" {  \verseOne }
>>

altoLyrics = <<
  \new Lyrics \lyricsto "alto" {
    \bassAltoFindLyrics
  }
>>

tenorLyrics = <<
  \new Lyrics \lyricsto "tenor" {
    \verseOne
  }
>>

bassLyrics = <<
  \new Lyrics \lyricsto "bass" {
    \bassAltoFindLyrics
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
%\include "shapenote-print-experimental.ily"
%%
\include "shapenote-print-standard.ily"

%%%%%%%%%%%%%%%%


\include "shapenote-midi.ily"
