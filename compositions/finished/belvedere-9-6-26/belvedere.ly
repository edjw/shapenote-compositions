% relies on ../includes
\language "espanol"
\version "2.26.0"
#(set-default-paper-size "a4landscape")

% Major: C: do  D: re  E: mi  F: fa  G: sol  A:  la  Bb: sib  Eb: mib
% Minor: A: do  B: re  C#:mi  D: fa  E: sol  F#: la  G: sib   C: mib

songKey = fa
songMode = "major" % "major" or "minor"
songTitle = "Belvedere"
songMeter = "LM"
songComposer = "Ed Johnson-Williams, June 2026"
poetName = "Charles Wesley, 1739"
songFooter = ""
timeSignature = 2/4
noteHeadStyle = "seven" % "seven", "four", or "normal (not supported)"
pickupDuration = "0" % "0" = none, "2" = half, "2." = dotted half, "4" = quarter, "4." = dotted quarter, "8" = eighth, "8." = dotted eighth
midiTempo = 96
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
  sol4 sol8[la] |
  sol4. do8 |
  la4 sol |
  sol2 |
  do4 sol8[la] |
  do4. la8 |
  sol4 sol |
  sol2 | \break
  \repeat volta 2 {
    do4 do8[re]|
    do4. sol8 |
    mi4 re |
    mi2 |
    sol8[la] do[la] |
    sol4 do8[si] |
    do4 sol |
    sol2 |
  }
}

altoMusic = \relative do' {
  mi4 do |
  re4. mi8 |
  mi4 mi |
  do2 |
  do4 do8[re] |
  mi4. mi8 |
  mi4 do |
  re2 |
  \repeat volta 2 {
    do4 mi8[re] |
    mi4. do8 |
    do4 re |
    do2 |
    mi8[re] do[re] |
    mi4 mi8[re] |
    do4 re |
    mi2 |
  }
}

tenorMusic = \relative do' {
  do4 mi8[fa] |
  sol4. sol8 |
  la4 do4 |
  sol2 |
  sol4 mi8[re] |
  do4. do8 |
  do4 mi |
  re2 |
  \repeat volta 2 {
    sol4 la8[si] |
    do4. do8 |
    do8[la] sol[la] |
    do2 |
    sol8[fa] mi[fa] |
    sol8[la] sol8[fa] |
    mi4 re |
    do2 |
  }

  %  \bar ".."
}

bassMusic = \relative do {
  do4 do |
  sol4. do8 |
  do4 do |
  do2 |
  sol4 sol |
  sol4. la8 |
  do4 do8[la] |
  sol2 |
  \repeat volta 2 {
    do4 la8[sol] |
    do4. sol8 |
    la4 sol |
    do2 |
    do8[re] mi[re] |
    do4 sol' |
    sol sol, |
    do2 |
  }
}
%%%%%%%%%%%%%%%%

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  Christ the Lord is risen to -- day
  Earth and heaven in chor -- us say
  Raise your joys and tri -- umphs high
  Sing, ye heavens, and earth re -- ply
}

verseTwo = \lyricmode {
  \tiny
  Hail the Lord of earth and heav'n
  Praise to thee by both be giv'n
  Thee we greet tri -- umph -- ant now
  Hail the Res -- ur -- rect -- ion, thou
}

verseThree = \lyricmode {
  \tiny
  King of glor -- y, soul of bliss
  Ev -- er -- last -- ing life is this
  Thee to know, thy pow'r to prove
  Thus to sing, and thus to love
}

verseFour = \lyricmode {
  \tiny
  % Verse 4 lyrics if needed
}

%%%%%%% LYRICS PLACEMENT %%%%%%%%%
trebleLyrics = <<
  \new Lyrics \lyricsto "treble" {
    \set stanza = "1." \verseOne
  }
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
%\include "shapenote-print-standard.ily"

%%%%%%%%%%%%%%%%


\include "shapenote-midi.ily"
