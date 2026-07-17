% relies on ../includes
\language "espanol"
\version "2.26.0"
#(set-default-paper-size "a4landscape")

songKey = "G major" % e.g. "e minor", "f# major", "bb major"
songTitle = "Holly Blue"
songMeter = "7s & 6s"
songComposer = "Ed Johnson-Williams, July 2026"
poetName = "John Leland, 1793"
songFooter = ""
timeSignature = 6/8
noteHeadStyle = "seven" % "seven", "four", or "normal (not supported)"
pickupDuration = "8" % "0" = none, "2" = half, "2." = dotted half, "4" = quarter, "4." = dotted quarter, "8" = eighth, "8." = dotted eighth
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

  mi8 |
  sol4 sol8 mi4 re8 |
  mi16 do8.~ do4.
  mi8 sol4 sol8 mi4 mi8 |
  sol4.~sol4 mi8 |
  sol4 sol8 mi4 re8 |
  mi16 do8.~ do4.
  mi8 sol4 sol8 sol4 fa8 |
  mi4.~mi4 do'8 |
  la4 la8 sol4 fa8 |
  mi16 sol8.~ sol4. la8 |
  sol4 sol8 do4 sol8 |
  sol4.~sol4 mi8 |
  sol4 sol8 mi4 re8 |
  %  mi16  do16~ do4 mi4. |
  la8(do8 mi) fa4 la8 |
  sol4 sol8 sol4 fa8 |
  mi2. |
}

altoMusic = \relative do' {
  sol8 |
  do4 do8 do4 re8 |
  do16 la8.~ la4. mi'8 |
  re4 mi8 do4 sol8 |
  re'4.~re4 do8 |
  do4 do8 do4 re8 |
  do16 la8.~ la4. mi'8 |
  re4 do8 do4 si8 |
  sol4.~sol4 sol8 |
  do4 do8 re4 re8 |
  do16 re8.~ re4. mi8 |
  re4 do8 do4 sol8 |
  re'4.~re4 sol,8 |
  do4 do8 do4 si8 |
  %  do16  la16~la4 do4. |
  la8(do8 mi) fa4 mi8 |
  do4 do8 do4 si8 |
  sol2. |
}

tenorMusic = \relative do' {


  mi8
  sol4 mi8 do4 si8
  la16 fa'8.~ fa4. la,8
  sol4 do8
  do4 mi8 re4.~ re4 mi8
  sol4 mi8 do4 si8
  la16 fa'8.~ fa4. la,8 sol4 mi'8
  mi4 re8 do4.~ do4 mi8
  fa4 fa8 fa4 fa8
  mi16 re8.~ re4. mi8 sol4 mi8
  sol4 do,8 re4.~ re4 mi8
  sol4 mi8 do4 si8
  la8(do8 mi) fa4 la8 sol4
  do,8 mi4 re8
  do2.


  \bar ".."
}

bassMusic = \relative do {

  do8 |
  do4 do8 sol4 sol8 |
  la16 fa8.~ fa4. la8 |
  sol4 do8 do4 do8 |
  sol4.~ sol4 do8 do4 do8 sol4 sol8 |
  la16 fa8.~ fa4. do'8 |
  sol4 sol8 sol4 sol8 |
  do4.~do4 do8 |
  do4 do8 sol4 sol8 |
  la16 sol8.~ sol4. la8 |
  sol4 do8 mi4 do8 |
  sol4.~sol4 do8 do4 do8 sol4 sol8 |
  %  la16 fa16~ fa4 do'4. |
  la8(do8 mi) fa4 mi8 |
  do4 do8 do4 sol8 |
  do2.
}
%%%%%%%%%%%%%%%%

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  And if you meet with trou -- bles
  And tri -- als on the way,
  Then cast your care on Je -- sus,
  And don't for -- get to pray.

  Gird on the heav'n -- ly ar -- mor
  Of faith, and hope, and love;
  And when the com -- bat's end -- ed,
  He'll take you up a -- bove.
}

verseTwo = \lyricmode {
  \tiny
  Through grace I am de -- ter -- mined
  To con -- quer though I die;
  And then a -- way to Je -- sus
  On wings of love I'll fly.

  Fare -- well to sin and sor -- row,
  I bid you all a -- dieu,
  Then O my friends, prove faith -- ful,
  And on your way pur -- sue.
}



%%%%%%% LYRICS PLACEMENT %%%%%%%%%
trebleLyrics = <<
  \new Lyrics \lyricsto "treble" { \set stanza = "1." \verseOne }
>>



tenorLyrics = <<
  \new Lyrics \lyricsto "tenor" {
    \set stanza = "2." \verseTwo
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
\include "shapenote-print-experimental.ily"
%%
% \include "shapenote-print-standard.ily"

%%%%%%%%%%%%%%%%


\include "shapenote-midi.ily"
