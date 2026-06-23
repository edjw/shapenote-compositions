% relies on ../includes
\language "espanol"
\version "2.26.0"
#(set-default-paper-size "a4landscape")

% Major: C: do  D: re  E: mi  F: fa  G: sol  A:  la  Bb: sib  Eb: mib
% Minor: A: do  B: re  C#:mi  D: fa  E: sol  F#: la  G: sib   C: mib

songKey = sol
songMode = "major" % "major" or "minor"
songTitle = "Determination"
songMeter = "LM"
songComposer = "Ed Johnson-Williams, June 2026"
poetName = ""
songFooter = ""
timeSignature = 3/4
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
  r2 sol4 |
  sol4. sol8 la4 |
  sol4 sol mi |
  sol sol mi |
  re2 sol4 |
  sol4. sol8 la4 |
  do4 la sol |
  la sol mi |
  sol2 sol4 |
  mi2 re8 mi |
  sol4 mi sol |
  do la sol |
  sol2 sol4 |
  sol4. sol8 la4 |
  sol4 sol mi |
  sol sol sol |
  sol2.

}

altoMusic = \relative do' {
  r2 sol4 |
  do4. re8 do4 |
  re4 do la |
  sol do do |
  sol2 sol4 |
  do4. re8 do4 |
  do4 do sol |
  do re mi |
  re2 re4 |
  do2 re8 mi8 |
  mi4 mi mi |
  do do do |
  sol2 sol4 |
  do4. re8 do4 |
  sol4 do la |
  sol sol sol |
  do2.
}

tenorMusic = \relative do' {
  r2  do8[re] |
  mi4. re8 mi4 |
  re4 do la |
  do do la |
  sol2 do8[re] |
  mi4. re8 mi4 |
  fa4 fa mi |
  fa sol la |
  sol2 sol4 |
  la2 sol8 la |
  do4 la sol |
  fa fa mi |
  re2 do8[re] |
  mi4. re8 mi4 |
  re4 do la |
  do do re |
  do2. |
  \bar ".."
}

bassMusic = \relative do {
  r2 do4 |
  do4. sol8 la4 |
  sol4 sol la |
  do do la |
  sol2 do4 |
  do4. sol8 la4 |
  fa4 fa mi |
  fa sol la |
  sol2 sol4 |
  la2 sol8 la |
  do4 la do |
  fa, fa do' |
  sol2 do4 |
  do4. sol8 la4 |
  sol4 sol la |
  do sol sol |
  do2. |
}
%%%%%%%%%%%%%%%%

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  I love thee, my Sav -- ior, I love thee, my Lord,
  I love thy dear peo -- ple, thy ways, and thy word;
  With ten -- der e -- mo -- tion I love sin -- ners too,
  Since Je -- sus has died to re -- deem them from woe.
}

verseTwo = \lyricmode {
  \tiny
  I find him in sing -- ing, I find him in prayer,
  In sweet med -- i -- tat -- ion he al -- ways is near;
  My con -- stant com -- pan -- ion, O may we ne'er part!
  All glor -- y to Je -- sus, he dwells in my heart.
}

verseThree = \lyricmode {
  \tiny
  % Verse 3 lyrics if needed
}

verseFour = \lyricmode {
  \tiny
  % Verse 4 lyrics if needed
}

%%%%%%% LYRICS PLACEMENT %%%%%%%%%
trebleLyrics = <<
  \new Lyrics \lyricsto "treble" { \set stanza = "1." \verseOne }
>>

altoLyrics = <<
  % \new Lyrics \lyricsto "alto" { \set stanza = "2." \verseTwo }
>>

tenorLyrics = <<
  %  \new Lyrics \lyricsto "tenor" {
  %    \set stanza = "1." \verseOne
  %  }
  \new Lyrics \lyricsto "tenor" { \set stanza = "2." \verseTwo }
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
