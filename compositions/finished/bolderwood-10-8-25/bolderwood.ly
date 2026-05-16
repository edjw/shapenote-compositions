% relies on ../includes
\language "espanol"
\version "2.26.0"
#(set-default-paper-size "a4landscape")

% Major: C: do  D: re  E: mi  F: fa  G: sol  A:  la  Bb: sib  Eb: mib
% Minor: A: do  B: re  C#:mi  D: fa  E: sol  F#: la  G: sib   C: mib

songKey = la
songMode = "major" % "major" or "minor"
songTitle = "Bolderwood"
songMeter = "CM"
songComposer = "Ed Johnson-Williams, August 2025"
poetName = "Isaac Watts"
songFooter = ""
timeSignature = 6/4
noteHeadStyle = "seven" % "seven", "four", or "normal (not supported)"
pickupDuration = "4" % "0" = none, "2" = half, "2." = dotted half, "4" = quarter, "4." = dotted quarter, "8" = eighth, "8." = dotted eighth
midiTempo = 100
openingShapeStyle = "root" % "seventh" = si/mi marker, "root" = do/la marker. Always choose seventh in four shapes
showKeySignatureWords = "yes" % "yes" or "no"

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

trebleMusic = \relative do' {
  mi4 |
  sol2 mi4 do2 sol'4 |
  sol2 sol4 mi2\fermata do4 |
  re2 do4 sol'2 mi4 |
  re2. r2 do4 |
  mi2 sol4 do2 si4 |
  do2 la4 sol2\fermata sol4 | \bar ".|:"

  \repeat volta 2 {
    do,4(re) mi sol2 mi4 |
  }
  \alternative {
    { sol2.(mi2)\fermata sol4 | }
    { mi1. | }
  }
}

altoMusic = \relative do' {
  sol4 |
  do2 do4 sol2 sol4 |
  sol2 do4 do2\fermata do4 |
  si2 la4 sol2 do4 |
  si2. r2 do4 |
  do2 do4 sol2 sol4 |
  do2 la4 sol2\fermata do4 | \bar ".|:"

  \repeat volta 2 {
    do4(si) do do2 do4 |
  }
  \alternative {
    { sol2.(do2)\fermata sol4 | }
    { sol1. | }
  }
}

tenorMusic = \relative do' {
  sol4 |
  do2 la4 sol2 do4 |
  mi2 sol4 do,2\fermata la4 |
  sol2 do4 mi2 sol4 |
  sol2. r2 sol4 |
  la2 sol4 mi2 sol4 \break |
  sol2 mi4 re2\fermata mi4 | \bar ".|:"

  \repeat volta 2 {
    mi4(re) do sol2 la4 |
  }
  \alternative {
    { do2.(mi2)\fermata mi4 | }
    { do1. | }
  }
  \bar "|."
}

bassMusic = \relative do {
  do4 |
  sol2 la4 do2 mi4 |
  do2 sol4 sol2\fermata la4 |
  sol2 la4 do2 do4 |
  sol2. r2 sol4 |
  la2 do4 do2 sol4 |
  do2 la4 sol2\fermata <do do,>4 | \bar ".|:"

  \repeat volta 2 {
    sol2 sol4 do2 do4 |
  }
  \alternative {
    { do2.(sol2)\fermata <do do,>4 | }
    { <do do,>1. | }
  }
}
%%%%%%%%%%%%%%%%

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  Now shall my in -- ward joys a -- rise,
  And burst in -- to a song;
  Al -- migh -- ty love in -- spires my heart,
  And plea -- sure tunes my tongue.
  And
  tongue.
}

verseTwo = \lyricmode {
  \tiny
  God, on His thir -- sty Zi -- on’s hill,
  Some mer -- cy drops has thrown;
  And so -- lemn oaths have bound His love
  To show’r sal -- va -- tion down.
  To
  down.
}

verseThree = \lyricmode {
  \tiny
  Why do we then in -- dulge our fears,
  Sus -- pic -- ions and com -- plaints?
  Is He a God, and shall His grace
  Grow wea -- ry of His saints?
  Grow
  saints?
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
