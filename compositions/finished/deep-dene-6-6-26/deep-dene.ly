% relies on ../includes
\language "espanol"
\version "2.26.0"
#(set-default-paper-size "a4landscape")

songKey = "E minor" % e.g. "e minor", "f# major", "bb major"
songTitle = "Deep Dene"
songMeter = "8.8.6.8.8.6"
songComposer = "Ed Johnson-Williams, July 2026"
poetName = "Charles Wesley, 1749"
songFooter = ""
timeSignature = 6/4
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
  mi4 |
  mi2 sol4 sol2 mi4 |
  sol2 mi4 mi2 mi4 |
  mi2 do8[mi]  sol2 mi4 |
  sol2 mi4 la2 mi4 |
  sol2 do4 si2 sol4 |
  mi2.~ mi2 mi4 |
  mi2 sol4 la2 do4 |
  la2.~ la2 la8[sol] |
  mi2 la4 sol2 do8[si] |
  la2 la8[sol] la2 mi4 |
  la2 mi4 sol2 do8[si] |
  do2 si4 la2 mi4 |
  sol2 sol4 la2 sol4 |
  mi2.~ mi2 mi4 |
  mi2 sol4 mi2 re4 |
  mi1. |
}

altoMusic = \relative do' {
  la4 |
  do2 do4 re2 do4 |
  si2 la4 la2 la4 |
  do2 do4 re2 do4 |
  si2 do4 mi2 mi4 |
  do2 sol4 sol2 sol4 |
  la2.~ la2 la4 |
  do2 sol4 la2 do4 |
  la2.~ la2 la4 |
  do2 do4 si2 si4 |
  la2 la8[si] do2 la4 |
  do2 do8[la] sol2 sol4 |
  sol2 sol4 la2 la4 |
  do2 mi4 mi2 do8[si] |
  la2.~la2 la4 |
  do2 sol4 sol2 si4 |
  la1. |
}

tenorMusic = \relative do' {
  la4 |
  do2 mi4  re2 la4 |
  re2 do8[si]  la2 la4 |
  do2 mi4 re2 la4 |
  re2 do8[si] la2 la4 |
  do2 mi4 re2 sol4 |
  la2.~ la2 la4 |
  sol2 mi4 mi4(re) do8[si] |
  la2.~ la2 la8[do] |
  mi2 do8[mi] sol2 mi8[re] |
  mi2 do8[si] la2 la8[do] |
  mi2 do8[mi] sol2 mi4 |
  mi2 mi8[sol] la2 la4 |
  sol2 sol4 mi2 do8[re] |
  mi2.~ mi2 la4 |
  sol2 sol4 mi2 sol4 |
  la1. |
  \bar ".."
}

bassMusic = \relative do {
  la4 |
  la2 mi4 sol2 la4 |
  sol2 mi4 la2 la4 |
  la2 mi4 sol2 la4 |
  sol2 mi4 la2 la4 |
  do2 do4 sol2 mi8[sol] |
  la2.~ la2 la4 |
  do2 sol4 la2 sol4 |
  la2.~ la2 la4 |
  la2 la4 mi2 sol4 |
  do2 la8[sol] la2 la4 |
  la2 la4 mi2 sol4 |
  do2 sol4 la2 la4 |
  do2 mi4 mi2 do8[sol] |
  la4(do si la2) la4 |
  do2 mi,4 mi2 mi8[sol] |
  la1. |
}
%%%%%%%%%%%%%%%%

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  O love di -- vine, how sweet thou art!
  When shall I find my long -- ing heart
  all tak -- en up by thee,
  all tak -- en up by thee?

  I thirst, I faint, I die to prove
  the great -- ness of re -- deem -- ing love,
  the love of Christ to me.
  the love of Christ to me.
}

verseTwo = \lyricmode {
  \tiny
  Thy on -- ly love do I re -- quire,
  no -- thing on earth be -- neath de -- sire,
  no -- thing in heaven a -- bove
  no -- thing in heaven a -- bove

  let earth and heaven, and all things go,
  give me thine on -- ly love to know,
  give me thine on -- ly love.
  give me thine on -- ly love.
}


%%%%%%% LYRICS PLACEMENT %%%%%%%%%
trebleLyrics = <<
  \new Lyrics \lyricsto "treble" {
    \set stanza = "1." \verseOne
  }
>>

altoLyrics = <<
  % \new Lyrics \lyricsto "alto" { \set stanza = "2." \verseTwo }
>>

tenorLyrics = <<
  \new Lyrics \lyricsto "tenor" {
    \set stanza = "2." \verseTwo
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
%\include "shapenote-print-standard.ily"

%%%%%%%%%%%%%%%%


\include "shapenote-midi.ily"
