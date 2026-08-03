% relies on ../includes
\language "espanol"
\version "2.26.0"
#(set-default-paper-size "a4landscape")

songKey = "f major" % e.g. "e minor", "f# major", "bb major"
songTitle = "Safe in the Promised Land"
songMeter = "PM"
songComposer = \markup \right-column {
  "Arr. Ed Johnson-Williams, July 2026"
  "from Original Sacred Harp, 1966, from B. F. White, 1844."
}
poetName = "The Sacred Harp, 1844."
songFooter = ""
timeSignature = 4/4
noteHeadStyle = "seven" % "seven", "four", or "normal (not supported)"
pickupDuration = "0" % "0" = none, "2" = half, "2." = dotted half, "4" = quarter, "4." = dotted quarter, "8" = eighth, "8." = dotted eighth
midiTempo = 120
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

trebleMusic = \relative do'' {
  sol2 sol4 sol4 |
  do sol mi sol |
  sol2 sol4 do8[si] |
  do4 do si do |
  do2 la4 sol |
  sol la la sol |
  do2 sol4 mi |
  sol sol sol2 |
  \repeat volta 2 {
    sol4 sol do sol |
    mi sol do do |
    sol sol sol sol |
    sol sol mi mi |
    mi4. sol8 la4 do |
    sol la do do |
    la2 sol4 mi |
    sol sol sol2 |
  }
}

altoMusic = \relative do' {
  do2 do4 si |
  do do do do |
  si2 si4 sol |
  sol4 sol sol sol |
  la2 do4 do4 |
  mi mi mi do |
  mi2 mi4 do |

  do si do2 |
  \repeat volta 2 {
    do4 do do do |
    mi do do do |
    si si si do8[re] |
    mi4 mi do sol |
    la4. sol8 do4 do |
    do do do do  |
    re2 mi4 mi |
    do si sol2 |
  }


}

tenorMusic = \relative do' {
  mi2 mi4 re8[mi] |
  sol4 mi mi8[re] do4 |
  re2 re4 do8[re] |
  mi4 mi sol mi |
  la2 la4 sol8[la] |
  do4 la la8[sol] mi4 |
  la4. (mi8) sol4 la |
  mi4 re mi2 |
  \repeat volta 2 {
    mi4 mi mi re8[mi] |
    sol4 mi mi8[re] do4 |
    re re re do8[re] |
    mi4 mi sol mi |
    la4. si8 la4 sol |
    do4 la la8[sol] mi4 |
    la2 sol4 la |
    mi4 re mi2 |
  }


  \bar ".."
}

bassMusic = \relative do {
  do2 do4 sol4 |
  do4 do do do |
  sol2 sol4 sol |
  do mi sol mi |
  fa2 fa4 do |
  do la la8[si] do4 |

  do2 do4 do |
  do re do2 |
  \repeat volta 2 {
    do4 do sol sol |
    do mi sol do, |
    sol sol sol do8[si] |
    do4 do do do |
    do4. mi8 fa4 sol |
    do, mi mi8[re] do4 |
    re2 do4 la |
    sol sol do2 |
  }
}
%%%%%%%%%%%%%%%%

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny


  Where is our bless -- ed Sav -- ior?
  Where is our bless -- ed Sav -- ior?
  Where is our bless -- ed Sav -- ior?
  Safe in the prom -- ised land.
  He was scourged and cru -- ci -- fi -- ed,
  He by Ro -- mans was de -- rid -- ed,
  Thus the Lord of glor -- y di  -- ed,
  To raise our souls a -- bove.


  %  Where are the He -- brew child -- ren?
  %  Where are the He -- brew child -- ren?
  %  Where are the He -- brew child -- ren?
  %  Safe in the prom -- ised land.
  %  Though the fur -- nace flamed a -- round them,
  %  God, while in their trou -- bles, found them;
  %  He with love and mer -- cy bound them,
  %  Safe in the prom -- ised land.
}

verseTwo = \lyricmode {
  \tiny

  %  Where are the twelve a -- post -- les?
  %  Safe in the prom -- ised land.
  %  They went up through pain and sigh -- ing,
  %  Scoff -- ing, scourg -- ing, cru -- ci -- fy -- ing,
  %  No -- bly for their Mas -- ter dy -- ing,
  %  Safe in the prom -- ised land.
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
  \new Lyrics \lyricsto "treble" {
    %    \set stanza = "1." \verseOne
    \verseOne
  }
>>

altoLyrics = <<
  % \new Lyrics \lyricsto "alto" { \set stanza = "2." \verseTwo }
>>

tenorLyrics = <<
  \new Lyrics \lyricsto "tenor" {
    \verseOne
    %    \set stanza = "2." \verseTwo
  }
  % \new Lyrics \lyricsto "tenor" { \set stanza = "3." \verseThree }
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
