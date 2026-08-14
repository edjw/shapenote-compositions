% relies on ../includes
\language "espanol"
\version "2.26.0"
#(set-default-paper-size "a4landscape")

songKey = "bb major" % e.g. "e minor", "f# major", "bb major"
songTitle = "Skirrid"
songMeter = "LM"
songComposer = "Ed Johnson-Williams, July 2026"
poetName = "Isaac Watts, 1715"
songFooter = \markup \center-column {
  "\"The Skirrid / Ysgyryd Fawr\" is a hill and pilgrimage site near Abergavenny, Wales."
  "Ysgyryd means something that has shattered or trembled. Part of the mountain is said to have broken off when Jesus was crucified."
}

timeSignature = 2/2
noteHeadStyle = "four" % "seven", "four", or "normal (not supported)"
%pickupDuration = "" % "0" = none, "2" = half, "2." = dotted half, "4" = quarter, "4." = dotted quarter, "8" = eighth, "8." = dotted eighth
midiTempo = 100
openingShapeStyle = "root" % "seventh" = si/mi marker, "root" = do/la marker. Always choose seventh in four shapes
showKeySignatureWords = "yes" % "yes" or "no"
% showChoirBrace = ##f % hide the left brace in standard print mode (default ##t)

\include "shapenote-common.ily"

%\paper {
%  system-count = #1
%}


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
  r2 do2 |
  do sol |
  do re |
  mi re |
  mi1 |
  r2 do |
  mi mi |
  sol, sol |
  do mi |
  re1 |
  r2 do |
  do mi |
  do4(la) sol2 |
  do re |
  sol1 |
  r2 mi |
  re mi |
  mi do |
  sol sol |
  do1 |
}

altoMusic = \relative do' {
  r2  sol2 |
  sol mi |
  mi sol |
  sol la |
  sol1 |
  r2 sol |
  la la |
  sol mi |
  mi mi |
  sol1 |
  r2 sol |
  sol mi |
  mi sol |
  sol la4(si) |
  do1 |
  r2 do |
  sol la |
  la sol |
  sol sol |
  sol1 |
}

tenorMusic = \relative do' {
  r2 sol2 |
  do do |
  mi re |
  do la |
  sol1 |
  r2 sol |
  la la |
  do do |
  do mi |
  re1 | \break
  r2 mi4(fa) |
  sol2 sol |
  la sol |
  mi re |
  mi1 |
  r2 mi |
  re do |
  la do |
  re mi |
  do1 |

  \bar ".."
}

bassMusic = \relative do, {
  r2 do2 |
  do mi |
  sol sol |
  do re |
  do1 |
  r2 do |
  la la |
  sol sol |
  do la |
  sol1 |
  r2 do, |
  do' sol |
  la do |
  do sol |
  do1 |
  r2 do4(la) |
  sol2 la |
  mi sol |
  sol do, |
  do1 |

}
%%%%%%%%%%%%%%%%

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  Lord, how de -- light -- ful ‘tis to see
  A whole as -- sem -- bly wor -- ship thee!
  At once they sing, at once they pray.
  They hear of heav'n, and learn the way.
}

verseTwo = \lyricmode {
  \tiny
  With thoughts of Christ and things di -- vine,
  Fill up this fool -- ish heart of mine.
  That hop -- ing par -- don through his blood,
  I may lie down and wake with God.
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
  %  \new Lyrics \lyricsto "tenor" {
  %    \set stanza = "1." \verseOne
  %  }
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
