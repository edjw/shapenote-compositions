\language "espanol"
\version "2.26.0"
#(set-default-paper-size "a4landscape")

% Major: C: do  D: re  E: mi  F: fa  G: sol  A:  la  Bb: sib  Eb: mib
% Minor: A: do  B: re  C#:mi  D: fa  E: sol  F#: la  G: sib   C: mib

%%%%%% QUICK SETTINGS %%%%%%
songKey = sib
songMode = "major"  % "major" or "minor"
songTitle = "Immortal Love"
songMeter = "CM"
songComposer = "Ed Johnson-Williams, April 2026"
poetName = "John Greenleaf Whittier 1866"
timeSignature = 3/4
noteHeadStyle = "seven"  % "seven", "four", or "normal"
pickupDuration = "0"  % "0" = none, "2" = half, "2." = dotted half, "4" = quarter, "4." = dotted quarter, "8" = eighth, "8." = dotted eighth


\include "../../includes/shapenote-common.ily"

%%%%%%% MUSIC %%%%%%%%%
%
% HELPFUL PATTERNS:
% Repeats:         \repeat volta 2 { music }
% Mid-bar:         \bar ";"
% Line break:      \break (after A section)
% Beams:           do8[ re8] (eighth notes and shorter only)
% Slurs:           do8( re8 mi8)
% Combined:        do8([ re8]) (slur and beam together)
% Ties:            do4~ do4
% Dotted notes:    do4. re8
% Octaves:         do'4 (higher) or do,4 (lower)
% Fermatas:        do4\fermata
% Grace notes:     \grace { do8 } re4
% Chords:          <do mi sol>4
% Accidentals:     dis4 or reb4
% Text markings:   do4^\markup { "Fine" }
% Triplets:        \tuplet 3/2 { do8 re8 mi8 }

trebleMusic = \relative do' {
  \newSpacingSection
  \once \override Score.SpacingSpanner.spacing-increment = #0.4

  r2 mi4 |

  \newSpacingSection
  \revert Score.SpacingSpanner.spacing-increment

  sol2 sol4 |
  mi2 do4 |
  re2 mi4 |
  sol2 sol4 |
  mi2 mi4 |
  re2 do4 |
  si2. \break |

  \newSpacingSection
  \once \override Score.SpacingSpanner.spacing-increment = #0.82

  r2 mi4 |

  \newSpacingSection
  \revert Score.SpacingSpanner.spacing-increment

  fa4(mi) re |
  mi2 sol4 |
  sol2 la4 |
  sol2 mi4 |
  re2 mi4 |
  mi2 re4 |
  mi2.
}

altoMusic = \relative do {
  r2  mi4 |
  mi2 sol4 |
  sol2 mi4 |
  sol2 do4 |
  sol2 mi4 |
  sol2 sol4 |
  la2 sol4 |
  sol2. |
  r2 sol4 |
  la2 sol4 |
  sol2 sol4 |
  mi2 fa4 |
  sol2 sol4 |
  sol2 sol4 |
  do2 sol4 |
  sol2.
}

tenorMusic = \relative do'' {
  r2 sol4 |
  mi2 re4 |
  do2 do4 |
  sol'2 mi4 |
  re2 do4 |
  do2 do4 |
  fa2 mi4 |
  re2. |
  r2 do4 |
  do2 re4 |
  mi2 mi4 |
  sol2 fa4 |
  mi2 do4 |
  re2 do4 |
  la2 sol4 |
  do2.
  \bar ".."
}

bassMusic = \relative do, {
  r2  do4 |
  do2 sol'4 |
  do2 la4 |
  sol2 sol4 |
  sol2 do,4 |
  do2 do4 |
  re2 mi4 |
  sol2. |
  r2 sol4 |
  fa4 (mi) re |
  do2 do4 |
  do2 re4 |
  do2 mi4 |
  sol2 do4 |
  la2 sol4 |
  <do do,>2. |
}

%%%%%%%%%%%%%%%%

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  Im -- mor -- tal Love for -- ev -- er full,
  for -- e -- ver flow -- ing free,
  for -- e -- ver shared, for -- e -- ver whole,
  a ne -- ver ebb -- ing sea.
}

verseTwo = \lyricmode {
  \tiny

  In joy of in -- ward peace, or sense
  Of sor -- row o -- ver sin,
  He is His own best e -- vi -- dence,
  His wit -- ness is with -- in.


}

% Additional verses if needed
verseThree = \lyricmode {
  \tiny
  We faint -- ly hear, we dim -- ly see,
  In diff' -- ring phrase we pray;
  But, dim or clear, we own in Thee
  The Light, the Truth, the Way!
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

\include "../../includes/shapenote-voices-and-lyrics.ily"

%%%%%%% PRINT MODE %%%%%%%%%
% Uncomment exactly one of shapenote-print-standard.ily and shapenote-print-experimental.ily.


% This is an experimental layout.
% No clef symbols
% Just a big top number for time signature
% A mi/si at the beginning instead of key signature
\include "../../includes/shapenote-print-experimental.ily"
%%
% \include "../../includes/shapenote-print-standard.ily"

%%%%%%%%%%%%%%%%


\include "../../includes/shapenote-midi.ily"
