\language "espanol"
\version "2.26.0"
#(set-default-paper-size "a4landscape")

% Major: C: do D: re E: mi F: fa G: sol A: la Bb: sib Eb: mib
% Minor: A: do B: re C#:mi D: fa E: sol F#: la G: sib  C: mib

songKey = sib
songMode = "minor" % "major" or "minor"
songTitle = "Harlowbury"
songMeter = "LM"
songComposer = "Ed Johnson-Williams, April 2026"
songFooter = "via Sand Mountain, Lloyds at the Macartes, Erin Johnson-Williams, and 429b Symyadda in the Shenandoah Harmony"
poetName = "Social and Camp-Meeting Songs, 1825"
timeSignature = 6/8
noteHeadStyle = "seven" % "seven", "four", or "normal (not supported)"
pickupDuration = "8" % "0" = none, "2" = half, "2." = dotted half, "4" = quarter, "4." = dotted quarter, "8" = eighth, "8." = dotted eighth
midiTempo = 80
openingShapeStyle = "root" % "seventh" = si/mi marker, "root" = do/la marker. Always choose seventh in four shapes
showKeySignatureWords = "yes" % "yes" or "no"

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

%%%%%%%%%%%%%%%%




trebleMusic = \relative do' {

  mi8 |
  mi4 la8 mi8(sol) sol |
  la8(mi) mi mi4 la8 |
  mi4 sol8 la(sol) re |
  mi4 sol8 la4 mi8 |
  mi4 la8 mi8(sol) sol |
  la8(mi) mi mi4. |

}

altoMusic = \relative do {

  mi8 |
  la4 mi8 mi8(sol) sol |
  la8(mi) sol mi4 la8 |
  la4 si8 la(sol) sol |
  la4 si8 la4 mi8 |
  la4 mi8 mi8(sol) sol |
  la8(mi) sol la4. |

}


tenorMusic = \relative do' {

  la8 |
  mi'4 mi8 si8(re) re8 |
  mi8(la,) si8 la4 \bar ";." mi'8 |
  la4 sol8 mi(re) sol |
  la8(mi) sol8 mi4 la,8 |
  mi'4 mi8 si8(re) re8 |
  mi8(la,) si8 la4. |
  \bar ".."

}


bassMusic = \relative do {

  la8 |
  la4 la8 mi8(sol) sol |
  la8(mi) sol la4 la8 |
  do4 si8 la(sol) sol |
  la8(do) sol la4 la8 |
  la4 la8 mi8(sol) sol |
  la8 (do) sol la4. |

}


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
