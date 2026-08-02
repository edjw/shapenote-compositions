% relies on ../includes
\language "espanol"
\version "2.26.0"
#(set-default-paper-size "a4landscape")

songKey = "bb major" % e.g. "e minor", "f# major", "bb major"
songTitle = "The Day"
songMeter = ""
songComposer = "Ed Johnson-Williams, July 2026"
poetName = "Psalm 118:24, The Bible (King James Version)"
songFooter = ""
timeSignature = 2/2
noteHeadStyle = "seven" % "seven", "four", or "normal (not supported)"
pickupDuration = "0" % "0" = none, "2" = half, "2." = dotted half, "4" = quarter, "4." = dotted quarter, "8" = eighth, "8." = dotted eighth
midiTempo = 100
openingShapeStyle = "root" % "seventh" = si/mi marker, "root" = do/la marker. Always choose seventh in four shapes
showKeySignatureWords = "yes" % "yes" or "no"
% showChoirBrace = ##f % hide the left brace in standard print mode (default ##t)

\include "shapenote-common.ily"

\paper {
  system-count = #1
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
  mi2 do4 re |
  mi1 |
  sol2 do,4 re |
  do1 |
  re2 do4 do |
  sol2 sol'4 la |
  sol2 re |
  do1 |
  mi2 do4 re |
  mi1 |
  sol2 la4 sol |
  mi1 |
  do2 do4 sol |
  sol'2 mi4 sol |
  mi2 re |
  mi1 |
}

altoMusic = \relative do' {
  sol2 sol4 sol |
  sol1 |
  do2 do4 si |
  sol1 |
  sol2 mi4 mi |
  mi2 sol4 fa |
  mi2 sol |
  sol1 |
  sol2 sol4 sol |
  sol1 |
  do2 do4 si |
  do1 |
  do2 do4 do |
  si2 do4 si |
  sol2 sol |
  sol1 |
}

tenorMusic = \relative do' {
  do2 do4 sol |
  do1 |
  mi2 mi4 re |
  do1 |
  sol'2 sol4 mi |
  do2 mi4 fa |
  sol2 re |
  do1 |
  do2 do4 sol |
  do1 |
  mi2 do4 re |
  mi1 |
  %  sol2 mi4 fa |
  %  sol1 |
  sol2 fa4 mi |
  re2 do4 re |
  mi2 re |
  do1 |
  \bar ".."
}

bassMusic = \relative do, {
  do2 mi4 sol |
  do,1 |
  do'2 la4 sol |
  do,1 |
  sol'2 sol4 la |
  do,2 do4 do |
  sol'2 sol |
  do,1 |
  do2 mi4 sol |
  do,1 |
  do'2 la4 sol |
  sol1 |
  do2 do,4 do |
  sol'2 sol4 sol |
  do2 sol |
  do,1 |
}
%%%%%%%%%%%%%%%%

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  This is the day
  This is the day
  This is the day that the Lord has made;
  We will re -- joice
  We will re -- joice
  We will re -- joice and be glad in it.
}

verseTwo = \lyricmode {
  \tiny
  % Verse 2 lyrics
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
  \new Lyrics \lyricsto "treble" { \verseOne }
>>

altoLyrics = <<
  % \new Lyrics \lyricsto "alto" { \set stanza = "2." \verseTwo }
>>

tenorLyrics = <<
  \new Lyrics \lyricsto "tenor" {
    \verseOne
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
