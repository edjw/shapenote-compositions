% relies on ../includes
\language "espanol"
\version "2.26.0"
#(set-default-paper-size "a4landscape")

songKey = "bb major" % e.g. "e minor", "f# major", "bb major"
songTitle = "Obscuration"
songMeter = "CM"
songComposer = "Ed Johnson-Williams, August 2026"
poetName = "Isaac Watts, 1724"
songFooter = ""
timeSignature = 3/4
noteHeadStyle = "seven" % "seven", "four", or "normal (not supported)"
pickupDuration = "4" % "0" = none, "2" = half, "2." = dotted half, "4" = quarter, "4." = dotted quarter, "8" = eighth, "8." = dotted eighth
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
% Ending barline:       automatic ".." | override with \bar "|."
% Line break:           \break (after A section)
% Mid-bar:              \bar ";"
% Alternative endings:  \alternative { { ending1 } { ending2 } }
% Accidentals:          fas4 or sib4 (sharps add s, flats add b)
% Triplets:             \tuplet 3/2 { do8 re8 mi8 }
% Time signature:       \bar ".." \time 3/2
% Repeat+fermata:       \bar ".|:" (put \fermata on last note before it)
% Segno:                do4^\markup { \tiny \musicglyph "scripts.segno" }

trebleMusic = \relative do' {
  mi4 |
  sol2 mi4 |
  re2 mi8[re] |
  do2 do4 |
  mi2 mi4 |
  sol2 mi8[re] |
  mi2 mi4 |
  sol2. |
  r2 sol8[fa] |
  mi2 mi4 |
  mi2 sol4 |
  sol2 mi4 |
  sol2 sol8[la] |
  sol2 mi4 |
  re2 mi4 |
  mi2. |

}

altoMusic = \relative do' {
  sol8[mi] |
  mi2 sol4 |
  sol2 sol4 |
  sol2 mi4 |
  sol2 sol4 |
  sol2 do8[si] |
  sol2 sol8[la] |
  sol2. |
  r2 sol8[la] |
  sol2 la4 |
  la2 sol8[la] |
  do4(si) la4 |
  sol2 sol4 |
  sol2 la4 |
  sol2 sol8[la] |
  sol2. |
}

tenorMusic = \relative do' {
  sol8[la]
  do2 do4 |
  re2 do8[re] |
  mi2 sol,8[la] |
  do2 do4 |
  re2 do8[re] |
  mi2 sol8[mi] |
  re2. | \break
  r2 mi8[fa] |
  sol2 la8[sol] |
  mi2 mi8[re] |
  do4(re) mi4 |
  re2 mi8[re] |
  do4.(re8) mi4 |
  re2 sol,8[la] |
  do2. |
}

bassMusic = \relative do, {
  do4 |
  do2 mi4 |
  sol2 sol4 |
  do,2 do4 |
  do2 mi4 |
  sol2 sol4 |
  do2 do4 |
  sol2. |
  r2 do4 |
  do2 do4 |
  la2 do8[la] |
  sol2 la4 |
  sol2 sol4|
  mi4.(sol8) la4 |
  sol2 do,4 |
  do2. |

}
%%%%%%%%%%%%%%%%

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  Am I a sold -- ier of the cross,
  a fol -- l'wer of the Lamb,
  and shall I fear to own His cause,
  or blush to speak His name?
}

verseTwo = \lyricmode {
  \tiny
  Must I be car -- ried to the skies
  on flow -- 'ry beds of ease,
  while oth -- ers fought to win the prize,
  and sailed thro' blood -- y seas?
}

verseThree = \lyricmode {
  \tiny
  Are there no foes for me to face?
  Must I not stem the flood?
  Is this vile world a friend to grace,
  to help me on to God?
}



%%%%%%% LYRICS PLACEMENT %%%%%%%%%
trebleLyrics = <<
  \new Lyrics \lyricsto "treble" { \set stanza = "1." \verseOne }
>>

altoLyrics = <<
  \new Lyrics \lyricsto "alto" { \set stanza = "2." \verseTwo }
>>

tenorLyrics = <<
  %  \new Lyrics \lyricsto "tenor" {
  %    \set stanza = "1." \verseOne
  %  }
  \new Lyrics \lyricsto "tenor" { \set stanza = "3." \verseThree }
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
