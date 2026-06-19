% relies on ../includes
\language "espanol"
\version "2.26.0"
#(set-default-paper-size "a4landscape")

% Major: C: do  D: re  E: mi  F: fa  G: sol  A:  la  Bb: sib  Eb: mib
% Minor: A: do  B: re  C#:mi  D: fa  E: sol  F#: la  G: sib   C: mib

songKey = fa
songMode = "major" % "major" or "minor"
songTitle = "Shields"
songMeter = "6.6.8.6"
songComposer = "Ed Johnson-Williams, June 2026"
poetName = "Isaac Watts, 1707"
songFooter = ""
timeSignature = 4/4
noteHeadStyle = "seven" % "seven", "four", or "normal (not supported)"
pickupDuration = "0" % "0" = none, "2" = half, "2." = dotted half, "4" = quarter, "4" = dotted quarter, "" = eighth, "." = dotted eighth
midiTempo = 100
openingShapeStyle = "root" % "seventh" = si/mi marker, "root" = do/la marker. Always choose seventh in four shapes
showKeySignatureWords = "yes" % "yes" or "no"
% showChoirBrace = ##f % hide the left brace in standard print mode (default ##t)

\include "shapenote-common.ily"

\paper {
  system-count = #1
}

%%%%%%% MUSIC %%%%%%%%%
%
% Beams:                do[re] (eighth notes and shorter only)
% Dotted notes:         do4 re
% Octaves:              do'4 (higher) | do,4 (lower)
% Slurs:                do( re mi)
% Repeats:              \repeat volta 2 { music }
% Ties:                 do4~ do4
% Octave doubling:      <do do,>2 (bass root + octave below)
% Text markings:        do4^\markup { "Fine" }
% Combined:              do([ re]) (slur and beam together)
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
% Triplets:             \tuplet 3/2 { do re mi }
% Repeat+fermata:       \bar ".|:" (put \fermata on last note before it)
% Segno:                do4^\markup { \tiny \musicglyph "scripts.segno" }

trebleMusic = \relative do'' {
  sol2 sol4 sol |
  la2 la |
  sol2. sol4 |
  do sol sol do |
  sol2. sol4 |
  do sol mi sol |
  la2 la |
  do2. do4 |
  sol sol do4. do8 |
  sol1

}

altoMusic = \relative do' {
  mi2 do4 do |
  do2 mi |
  mi2. do4 |
  mi do mi mi |
  re2. re4|
  mi mi do mi |
  do2 mi |
  do2. do4 |
  mi do mi4. do8 |
  do1 |

}

tenorMusic = \relative do' {
  do2 mi4 sol |
  mi2 do |
  do2. mi4 |
  sol sol mi do |
  re2. re4 |
  mi mi sol sol |
  la2 mi |
  la2. la4 |
  sol sol sol4. mi8 |
  do1 |

  \bar ".."
}

bassMusic = \relative do {
  do2 do4 sol |
  la2 la |
  do2. sol4 |
  do do do sol |
  sol2. sol4 |
  do do mi do |
  la2 la |
  la2. la4 |
  do sol sol4. do8 |
  do1

}
%%%%%%%%%%%%%%%%

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  Come, we that love the Lord,
  and let our joys be known;
  Join in a song with sweet a -- ccord,
  and thus sur -- round the throne.
}

verseTwo = \lyricmode {
  \tiny
  Let those re -- fuse to sing
  who ne -- ver knew our God;
  But chil -- dren of the heav'n -- ly King
  may speak their joys a -- broad.
}

verseThree = \lyricmode {
  \tiny
  The hill of Zi -- on yields
  a thou -- sand sa -- cred sweets
  Be -- fore we reach the heav'n -- ly fields,
  or walk the gold -- en streets.
}

verseFour = \lyricmode {
  \tiny
  Then let our songs a -- bound,
  and ev -- 'ry tear be dry;
  We're march -- ing through Em -- man -- uel's ground
  to fair -- er worlds on high.
}

%%%%%%% LYRICS PLACEMENT %%%%%%%%%
trebleLyrics = <<
  \new Lyrics \lyricsto "treble" { \set stanza = "1." \verseOne }
>>

altoLyrics = <<
  \new Lyrics \lyricsto "alto" { \set stanza = "2." \verseTwo }
>>

tenorLyrics = <<

  \new Lyrics \lyricsto "tenor" { \set stanza = "3." \verseThree }
  \new Lyrics \lyricsto "tenor" { \set stanza = "4" \verseFour }

>>

bassLyrics = <<
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
