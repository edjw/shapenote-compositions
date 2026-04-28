\language "espanol"
\version "2.26.0"
#(set-default-paper-size "a4landscape")

% Major: C: do D: re E: mi F: fa G: sol A: la Bb: sib Eb: mib
% Minor: A: do B: re C#:mi D: fa E: sol F#: la G: sib  C: mib

songKey = sib
songMode = "major" % "major" or "minor"
songTitle = "Thy Life Was Giv'n For Me"
songMeter = "6s	"
songComposer = "Ed Johnson-Williams, April 2026"
poetName = "Frances Ridley Havergal, 1859"
timeSignature = 4/4
noteHeadStyle = "seven" % "seven", "four", or "normal (not supported)"
pickupDuration = "0" % "0" = none, "2" = half, "2." = dotted half, "4" = quarter, "4." = dotted quarter, "8" = eighth, "8." = dotted eighth
midiTempo = 100
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

trebleMusic = \relative do'' {
  sol4 mi8 sol sol4 mi4 |
  do2 do2 |
  mi4. mi8 mi4 do |
  re1 |
  sol4 mi8 sol sol4 mi4 |
  do2 do2 |
  mi4. do8 sol'4 fa |
  mi1 |
  fa4 fa8 fa8 mi4 re |
  sol2 sol |
  do,4 mi sol mi |
  re1 |
  sol4 mi8 sol sol4 mi4 |
  do2 do2 |
  re4. do8 mi4 re |
  mi1
}

altoMusic = \relative do' {
  sol4 sol8 mi sol4 sol4 |
  la2 la2 |
  sol4. mi8 sol4 sol4 |
  sol1 |
  sol4 sol8 mi sol4 sol4 |
  la2 la2 |
  sol4. sol8 do4 sol |
  sol1 |
  sol4 sol8 sol mi4 sol4 |
  sol2 mi2 |
  sol4 sol do sol |
  sol1 |
  mi4 sol8 mi sol4 sol4 |
  la2 la2 |
  sol4. mi8 sol4 sol |
  sol1 |
}

tenorMusic = \relative do' {
  mi4 mi8 mi re4 do |
  fa2 la,2 |
  sol4. sol8 do4 mi |
  re1 |
  mi4 mi8 mi re4 do |
  fa2 la,2 |
  sol4. mi'8 mi4 re |
  do1 |
  re4 re8 re8 do4 re |
  mi2 mi2 |
  sol4 sol mi4 do |
  re1 |
  mi4 mi8 mi re4 do |
  fa2 la2 |
  sol4. do,8 mi4 re |
  do1 |
  \bar ".."
}

bassMusic = \relative do, {
  do4  do8 do re4 mi |
  fa2 fa |
  do4. do8 do4 do |
  sol'1 |
  do,4  do8 do re4 mi |
  fa2 fa |
  do4. do8 sol'4 sol |
  do,1 |
  sol'4 sol8 sol sol4 sol |
  do,2 do |
  do4 do mi do |
  sol'1 |
  do,4  do8 do re4 mi |
  fa2 fa2 |
  sol4. sol8 sol4 sol |
  do,1 |
}
%%%%%%%%%%%%%%%%

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  Thy life was giv'n for me,
  thy blood, O Lord, was shed,
  that I might ran -- somed be,
  and quick -- ened from the dead;
  thy life was giv'n for me;
  what have I giv'n for thee?
  Thy life was giv'n for me,
  thy blood, O Lord, was shed
}

verseTwo = \lyricmode {
  \tiny
  And thou hast brought to me
  down from thy home a -- bove
  sal -- vat -- ion full and free,
  thy pard -- on and thy love;
  great gifts thou brought -- est me;
  what have I brought to thee?
  And thou hast brought to me
  down from thy home a -- bove
}

verseThree = \lyricmode {
  \tiny
  O let my life be giv'n
  my years for thee be spent;
  world fett -- ers all be riv'n,
  and joy with suff' -- ring blent:
  thou gav'st thy -- self for me,
  I give my -- self to thee.
  O let my life be giv'n
  my years for thee be spent;
}


%%%%%%% LYRICS PLACEMENT %%%%%%%%%
trebleLyrics = <<
  \new Lyrics \lyricsto "treble" {
    \set stanza = "1." \verseOne
  }
>>

altoLyrics = <<
  \new Lyrics \lyricsto "alto" {
    \set stanza = "2." \verseTwo
  }
>>

tenorLyrics = <<
  \new Lyrics \lyricsto "tenor" {
    \set stanza = "3." \verseThree
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
