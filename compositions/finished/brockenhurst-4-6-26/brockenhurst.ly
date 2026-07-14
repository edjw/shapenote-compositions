% relies on ../includes
\language "espanol"
\version "2.26.0"
#(set-default-paper-size "a4landscape")

% Major: C: do  D: re  E: mi  F: fa  G: sol  A:  la  Bb: sib  Eb: mib
% Minor: A: do  B: re  C#:mi  D: fa  E: sol  F#: la  G: sib   C: mib

songKey = mi
songMode = "major" % "major" or "minor"
songTitle = "Brockenhurst"
songMeter = "LM"
songComposer = "Ed Johnson-Williams, July 2026"
poetName = "James Allen 1757 and Walter Shirley 1770"
songFooter = ""
timeSignature = 4/4
noteHeadStyle = "seven" % "seven", "four", or "normal (not supported)"
pickupDuration = "0" % "0" = none, "2" = half, "2." = dotted half, "4" = quarter, "4." = dotted quarter, "8" = eighth, "8." = dotted eighth
midiTempo = 100
openingShapeStyle = "root" % "seventh" = si/mi marker, "root" = do/la marker. Always choose seventh in four shapes
showKeySignatureWords = "yes" % "yes" or "no"
% showChoirBrace = ##f % hide the left brace in standard print mode (default ##t)

\include "shapenote-common.ily"

\paper {
  system-count = #2
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
% Time signature:       \bar ".." \time 3/2
% Repeat+fermata:       \bar ".|:" (put \fermata on last note before it)
% Segno:                do4^\markup { \tiny \musicglyph "scripts.segno" }

trebleMusic = \relative do'' {

  \repeat volta 2 {
    sol4. do8
    sol4 sol mi mi
    sol sol sol4. do8
    re4 do mi do
    do2
  }

  sol4. sol8 mi4 mi
  sol sol mi mi
  sol4. sol8 la4 do
  re re mi2
  sol,4. sol8
  mi4 sol
  do do mi do
  do4. re8
  do4 sol
  la sol
  sol2


}


tenorMusic = \relative do' {

  \repeat volta 2 {
    do4. mi8
    sol4 sol la la
    sol sol do,4. mi8
    sol4 sol la la


    sol2

  }


  do4. si8 la4 la
  sol sol la la
  do4. si8 la4 la
  sol sol la2

  mi4. re8

  do4 mi
  sol sol
  la sol
  mi4. re8
  do4 do
  mi re
  do2


  \bar ".."
}


bassMusic = \relative do {

  \repeat volta 2 {

    do4. do8 sol4 do
    la la do do
    do4. do8 sol4 sol
    la4 la



    do2
  }

  sol4. sol8 la4 la
  do do do do
  sol'4. mi8 re4 do
  sol sol
  la2

  do4. sol8 la4 do
  sol sol la do
  do4. sol8 la4 do
  do sol
  do2

}
%%%%%%%%%%%%%%%%

%%%%%%% LYRICS %%%%%%%%%


verseOne = \lyricmode {
  \tiny
  Sweet the mo -- ments, rich in bless -- ing,
  Which be -- fore the cross I spend,

  Here I’ll sit, for -- ev -- er view -- ing
  Mer -- cy's streams in streams of blood.

  Prec -- ious drops, my soul be -- dew -- ing,
  Plead and claim my peace with God.}

  verseOneRepeat = \lyricmode {
    \tiny
    Life, and health, and peace poss -- ess -- ing,
    From the sin -- ner's dy -- ing Friend.
  }



  verseTwo = \lyricmode {
    \tiny
    Tru -- ly bless -- èd is the stat -- ion,
    Low be -- fore His cross to lie,

    Lord, in cease -- less con -- tem -- plat -- ion
    Fix my thank -- ful heart on Thee,
    Till I taste Thy full sal -- vat -- ion
    And Thine un -- veil -- ed glor -- y see.
  }

  verseTwoRepeat = \lyricmode {
    \tiny
    While I see di -- vine com -- pass -- ion,
    Beam -- ing in His grac -- ious eye.

  }



%%%%%%% LYRICS PLACEMENT %%%%%%%%%
  trebleLyrics = <<
    \new Lyrics \lyricsto "treble" { \set stanza = "1." \verseOne }


    \new Lyrics \lyricsto "treble" {
      \verseOneRepeat
    }

  >>



  tenorLyrics = <<
    \new Lyrics \lyricsto "tenor" {
      \set stanza = "2." \verseTwo
    }
    \new Lyrics \lyricsto "tenor" {
      \verseTwoRepeat
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
  %   \include "shapenote-print-standard.ily"

%%%%%%%%%%%%%%%%


  \include "shapenote-midi.ily"
