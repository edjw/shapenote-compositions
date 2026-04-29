\language "espanol"
\version "2.26.0"
#(set-default-paper-size "a4landscape")

% Major: C: do D: re E: mi F: fa G: sol A: la Bb: sib Eb: mib
% Minor: A: do B: re C#:mi D: fa E: sol F#: la G: sib  C: mib

songKey = mib
songMode = "major" % "major" or "minor"
songTitle = "Hello Barry"
songMeter = "LM"
songComposer = "Ed Johnson-Williams, April 2026"
poetName = "Social and Camp-Meeting Songs, 1825"
timeSignature = 3/4
noteHeadStyle = "seven" % "seven", "four", or "normal (not supported)"
pickupDuration = "4" % "0" = none, "2" = half, "2." = dotted half, "4" = quarter, "4." = dotted quarter, "8" = eighth, "8." = dotted eighth
midiTempo = 100
openingShapeStyle = "root" % "seventh" = si/mi marker, "root" = do/la marker. Always choose seventh in four shapes
showKeySignatureWords = "no" % "yes" or "no"


\include "shapenote-common.ily"

%%%%%%% MUSIC %%%%%%%%%
%
% Beams:        do8[re] (eighth notes and shorter only)
% Dotted notes:     do4. re8
% Octaves:       do'4 (higher) | do,4 (lower)
% Slurs:        do8( re8 mi8)
% Repeats:       \repeat volta 2 { music }
% Ties:         do4~ do4
% Octave doubling:   <do do,>2 (bass root + octave below)
% Text markings:    do4^\markup { "Fine" }
% Combined:       do8([ re8]) (slur and beam together)
% Rests:        r1 | r2 | r4 | r1. | r2.
% Fermatas:       do4\fermata
% Fine/D.C.:      \mark \markup { \tiny \italic "Fine." }
%            \mark \markup { \italic \tiny "D.C." }
% Chords:        <do mi sol>4
% Ending barlines:   \bar ".." (standard) | \bar "|." (final) | \bar ".;" (repeat start)
% Line break:      \break (after A section)
% Mid-bar:       \bar ";"
% Alternative endings: \alternative { { ending1 } { ending2 } }
% Accidentals:     fas4 or sib4 (sharps add s, flats add b)
% Triplets:       \tuplet 3/2 { do8 re8 mi8 }
% Repeat+fermata:    \bar ".|:" (put \fermata on last note before it)
% Segno:        do4^\markup { \tiny \musicglyph "scripts.segno" }

trebleMusic = \relative do'' {


  la4 |
  do2 mi4 do2 sol4 |
  do(mi) do8(si)



  la2 \bar ";" do4


  sol2 sol4 la2 sol4 |

  do4(la) sol la2 la4 |
  do2 mi4 do2 sol4 |
  do4(mi) do8(si) la2. |

}

altoMusic = \relative do' {

  mi4 |
  mi2 mi4 do2 re4 |
  mi(do) do8(re)

  mi2 \bar ";" mi4

  do2 do8(mi) re2 do4 |

  mi2 mi4 re2 mi4 |
  mi2 mi8(do) mi2 re4 |

  mi4(do4) do8(re) mi2. |

}


tenorMusic = \relative do' {

  mi4 |
  la2 la8(sol) mi2 sol4 |
  la4(sol) mi8(re)

  mi2 \bar ";" la4

  do2 do8(si) la2 sol4 |
  la4(do) si4 la2 la4 |
  la2 la8(sol) mi2 sol4 |
  la4(mi) sol4 la2. |

}


bassMusic = \relative do {

  la4 |
  la2 la8(do) la2 sol4 |
  la(do) sol4

  la2 \bar ";" la4

  do2 mi4 re2 do4 |

  la4(do) mi4 re2 la4 |

  la2 la8(sol) la2 sol4 |
  la2 sol4 la2. |

}
%%%%%%%%%%%%%%%%

%%%%%%% LYRICS %%%%%%%%%


verseOneA = \lyricmode {
  \tiny
  A few more days on earth to spend,

  I'll join with those who've gone be -- fore,
  Who sing and shout their suff' -- rings o'er,
}

verseOneB = \lyricmode {
  \tiny
  And all my toils and cares shall end;
}

verseTwoA = \lyricmode {
  \tiny

  No more to sigh or shed a tear,

  Then O my soul, des -- pond no more,
  The storms of life will soon be o'er;

}

verseTwoB = \lyricmode {
  \tiny

  No more to suf -- fer pain or fear.

}


verseThreeA = \lyricmode {
  \tiny
  To earth -- ly cares I bid fare -- well,

  O hap -- py day, O joy -- ful hour,
  When freed from earth my soul shall tow'r.

}


verseThreeB = \lyricmode {
  \tiny
  And tri -- umph o -- ver death and hell;

}



%%%%%%% LYRICS PLACEMENT %%%%%%%%%
trebleLyrics = <<
  \new Lyrics \lyricsto "treble" {
    \set stanza = "1." \verseOneA
  }

  \new Lyrics \lyricsto "treble" {
    \verseOneB
  }
>>

altoLyrics = <<
  \new Lyrics \lyricsto "alto" {
    \set stanza = "2." \verseTwoA
  }

  \new Lyrics \lyricsto "alto" {
    \verseTwoB
  }
>>

tenorLyrics = <<
  \new Lyrics \lyricsto "tenor" {
    \set stanza = "3." \verseThreeA
  }

  \new Lyrics \lyricsto "tenor" {
    \verseThreeB
  }
>>

bassLyrics = <<
  % \new Lyrics \lyricsto "bass" { \set stanza = "4." \verseFour }
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
