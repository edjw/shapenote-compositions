% relies on ../includes
\language "espanol"
\version "2.26.0"
#(set-default-paper-size "a4landscape")

songKey = "a major" % e.g. "e minor", "f# major", "bb major"
songTitle = "Blackwater"
songMeter = "CM"
songComposer = "Ed Johnson-Williams, July 2026"
poetName = "Isaac Watts, 1707"
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
  system-count = #1
  ragged-last = ##f
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

trebleMusic = \relative do' {
  mi4 mi8 do do4. re8 |
  mi4 sol la2 |
  mi4 do8 re mi4 mi |
  re1 |
  \repeat volta 2 {
    mi4 do8 mi sol4. la8 |
    sol4 la sol2 |
    mi4 do8 si do4 re |
    mi1 |
  }
}

altoMusic = \relative do' {
  sol4 sol8 la8 sol4. si8 |
  do4 sol la2 |
  sol4 sol8 la8  do4 do |
  si1 |
  \repeat volta 2 {
    la4 la8 sol8 sol4. la8 |
    do4 do si2 |
    do4 do8 sol8 sol4 sol |
    sol1 |
  }
}

tenorMusic = \relative do' {
  do4 sol8 la  do4. sol8 |
  do4 mi re2 |
  mi4 mi8 re do4 mi |
  sol1 |

  \repeat volta 2 {
    la4 la8 sol mi4. re8 |
    do8[re] mi[do] re2 |
    mi4 mi8 re do4 si |
    do1 |
  }
  \bar ".."
}

bassMusic = \relative do {
  do4 do8 la sol4. sol8 |
  do,4 mi re2 |
  do4 do'8 la8 sol4 la |
  sol1 |
  \repeat volta 2 {
    la4 la8 do8 do4. re8 |
    do4 la sol2 |
    la4 la8 sol  do4 sol |
    <do do,>1
  }
}
%%%%%%%%%%%%%%%%

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  Thee we a -- dore, e -- ter -- nal name,
  And humb -- ly own to Thee,
  How fee -- ble is our mor -- tal frame,
  What dy -- ing worms are we!

}

verseTwo = \lyricmode {
  \tiny
  The year rolls round, and steals a -- way
  The breath that first it gave;
  What -- e'er we do, wher -- e'er we be,
  We're trav' -- ling to the grave.
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
