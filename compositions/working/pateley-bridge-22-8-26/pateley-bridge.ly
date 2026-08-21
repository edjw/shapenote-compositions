% relies on ../includes
\language "espanol"
\version "2.26.0"
#(set-default-paper-size "a4landscape")

songKey = "f major" % e.g. "e minor", "f# major", "bb major"
songTitle = "Pateley Bridge"
songMeter = "LM"
songComposer = "Ed Johnson-Williams, August 2026"
poetName = "Charlotte Elliott, 1836"
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
% Ending barline:       automatic ".." | override with \bar "|."
% Line break:           \break (after A section)
% Mid-bar:              \bar ";"
% Alternative endings:  \alternative { { ending1 } { ending2 } }
% Accidentals:          fas4 or sib4 (sharps add s, flats add b)
% Triplets:             \tuplet 3/2 { do8 re8 mi8 }
% Time signature:       \bar ".." \time 3/2
% Repeat+fermata:       \bar ".|:" (put \fermata on last note before it)
% Segno:                do4^\markup { \tiny \musicglyph "scripts.segno" }

trebleMusic = \relative do'' {
  sol2 mi4 do |
  mi2 sol |
  mi sol |
  mi1 |
  re2 mi4 sol |
  mi2 re |
  sol mi |
  re1 |
  sol2 la4 sol |
  la2 sol |
  do2 sol |
  mi1 |
  sol2 la4 sol |
  sol2 sol |
  sol1 |
}

altoMusic = \relative do' {
  sol2 do4 do |
  do2 sol |
  la sol |
  sol1 |
  sol2 do4 re |
  mi2 re |
  do la |
  sol1 |
  sol2 do4 do |
  mi2 re |
  do re |
  mi1 |
  do2 do4 do |
  re2 mi |
  mi1 |
}

tenorMusic = \relative do' {
  do2 sol'4 sol |
  mi2 re |
  mi re |
  do1 |
  sol'2 sol4 sol |
  la2 sol |
  mi la |
  sol1 |
  mi2 fa4 sol |
  la2 sol |
  la si |
  do1 |
  sol2 fa4 mi |
  re2 mi |
  do1 |
}

bassMusic = \relative do {
  do2 do4 do |
  do2 sol |
  la si |
  do1 |
  sol2 do4 si |
  la2 sol |
  sol2 la |
  sol1 |
  do2 do4 do |
  la2 sol |
  fa sol |
  do1 |
  do2 do4 do |
  si2 do |
  do1 |
}
%%%%%%%%%%%%%%%%

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  Just as I am, with -- out one plea,
  But that Thy blood was shed for me,
  And that Thou bidst me come to Thee,
  O Lamb of God, I come.
}

verseTwo = \lyricmode {
  \tiny
  Just as I am, and wait -- ing not
  to rid my soul of one dark blot,
  to thee, whose blood can cleanse each spot,
  O Lamb of God, I come.
}

verseThree = \lyricmode {
  \tiny
  Just as I am, thou wilt re -- ceive,
  wilt wel -- come, par -- don, cleanse, re -- lieve:
  be -- cause thy prom -- ise I be -- lieve,
  O Lamb of God, I come.
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
