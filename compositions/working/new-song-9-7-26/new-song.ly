% relies on ../includes
\language "espanol"
\version "2.26.0"
#(set-default-paper-size "a4landscape")

songKey = "bb major" % e.g. "e minor", "f# major", "bb major"
songTitle = ""
songMeter = "CM"
songComposer = "Ed Johnson-Williams, July 2026"
poetName = "John Newton, 1779"
songFooter = ""
timeSignature = 6/4
noteHeadStyle = "seven" % "seven", "four", or "normal (not supported)"
pickupDuration = "4" % "0" = none, "2" = half, "2." = dotted half, "4" = quarter, "4." = dotted quarter, "8" = eighth, "8." = dotted eighth
midiTempo = 100
openingShapeStyle = "root" % "seventh" = si/mi marker, "root" = do/la marker. Always choose seventh in four shapes
showKeySignatureWords = "yes" % "yes" or "no"
% showChoirBrace = ##f % hide the left brace in standard print mode (default ##t)

\include "shapenote-common.ily"


trebleMusic = \relative do' {
  do4
  mi2 do4
  si2 do4
  do2 do4
  do2 mi4
  do2 sol'4
  mi2 re4
  do2.
  r2 do4
  mi2 do4
  mi2 re4
  do2 do4
  mi2 sol4
  fa2 mi4
  re2 do4
  do2 do4
  re2 mi4
  re2 mi4
  mi2.
}

altoMusic = \relative do' {
  sol4
  mi2 mi4
  sol2 sol4
  la2 sol4
  sol2 sol4
  la2 sol4
  mi2 sol4
  sol2.
  r2 sol4
  sol2 la4
  la2 si4
  do2 la4
  sol2 sol4
  la2 la4
  sol2 la4
  sol2 sol4
  la2 sol4
  sol2 sol4
  sol2.
}

tenorMusic = \relative do' {
  do4
  sol'2 do,4
  re2 mi4
  fa2 mi4
  do2 do4
  fa2 do4
  do2 re4
  do2.
  r2 do4
  sol'2 fa4
  mi2 sol4
  fa2 mi4
  do2 do4
  re2 mi4
  sol2 fa4
  mi2 sol4
  fa2 mi4
  re2 do4
  do2.
  \bar ".."
}

bassMusic = \relative do, {
  do4
  do2 mi4
  sol2 sol4
  fa2 mi4
  do2 mi4
  fa2 sol4
  la2 si4
  do2.
  r2 do4
  do2 do4
  la2 sol4
  fa2 la4
  do2 do4
  re2 do4
  sol2 fa4
  mi2 do4
  re2 mi4
  sol2 mi4
  do2.
}
%%%%%%%%%%%%%%%%

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  A -- maz -- ing grace how sweet the sound
  that saved a wretch like me!
  I once was lost, but now am found,
  was blind, but now I see,
  was blind, but now I see.
}

verseTwo = \lyricmode {
  \tiny
  'Twas grace that taught my heart to fear,
  and grace my fears re -- lieved;
  how prec -- ious did that grace ap -- pear
  the hour I first be -- lieved,
  the hour I first be -- lieved!
}

verseThree = \lyricmode {
  \tiny
  Through ma -- ny dan -- gers, toils and snares
  I have al -- read -- y come.
  'Tis grace has brought me safe thus far,
  and grace will lead me home,
  and grace will lead me home.
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
