% relies on ../includes
\language "espanol"
\version "2.26.0"
#(set-default-paper-size "a4landscape")

songKey = "e major" % e.g. "e minor", "f# major", "bb major"
songTitle = "Sunlight"
songMeter = ""
songComposer = "Ed Johnson-Williams, July 2026"
poetName = "Judson W. Van De Venter, 1897"
songFooter = ""
timeSignature = 4/4
noteHeadStyle = "seven" % "seven", "four", or "normal (not supported)"
pickupDuration = "2"
% "0" = none, "2" = half, "2." = dotted half, "4" = quarter
%"4." = dotted quarter, "8" = eighth, "8." = dotted eighth
midiTempo = 120
openingShapeStyle = "root" % "seventh" = si/mi marker, "root" = do/la marker.
%Always choose seventh in four shapes
showKeySignatureWords = "yes" % "yes" or "no"
% showChoirBrace = ##f
% hide the left brace in standard print mode (default ##t)

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
  sol2 |
  sol4 sol do si |
  la do mi do |
  mi4 do do si |
  do2 sol |
  sol4 sol sol fa |
  mi fa sol do |
  mi do do si |
  do2. do4 |
  do2 mi |
  mi8(do4.) sol4. sol8 |
  sol4 sol mi mi |
  sol2. do4 |
  do2 mi2 |
  mi8(do4.) sol4. sol8 |
  mi4 sol do sol |


  sol1



}

altoMusic = \relative do' {

  mi2 |

  mi4 mi mi fa |
  fa fa mi mi |
  sol mi mi fa |
  sol2 mi |
  mi4 mi mi re |
  do do mi mi |
  mi re do re |
  mi2. mi4 |
  fa2 sol2 mi8(do4.) do4. re8 |
  mi4 mi sol sol |
  fa2. mi4 |
  fa2 sol |
  mi8(do4.) do4. si8 |
  do4 do do si |

  do1 |
}

tenorMusic = \relative do'' {
  sol2 |
  do4 do do sol
  la la la sol |
  do do mi re |
  do2 sol2 |
  do4 do do sol |
  la la do do |
  do do mi re | \break
  do2.

  sol4 |
  la2 do |
  la8 (sol4.) mi'4. re8 |
  do4 do do mi |
  re2. sol,4 |
  la2 do |
  la8 (sol4.) mi'4. re8 |
  do4 do mi re |

  do1  |





  \bar ".."
}

bassMusic = \relative do {
  do2 |
  do4 do do re |
  do do do do |
  sol' sol sol, sol |
  do2 do |
  do4 do do re |
  mi do do do |
  sol' sol sol sol |
  do,2. do4 |
  fa2 do |
  la8(do4.) do4. do8 |
  do4 do do do |
  sol2. do4 |
  fa2 do la8(do4.) do4. re8 |
  mi4 do sol' sol, |

  do1 |
}
%%%%%%%%%%%%%%%%

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  I wan -- dered in the shades of night,
  Till Je -- sus came to me,
  And with the sun -- light of His love
  Bid all my dark -- ness flee.
}

verseTwo = \lyricmode {
  \tiny
  Tho' clouds may ga -- ther in the sky,
  And bil -- lows round me roll,
  How -- ev -- er dark the world may be,
  I've sun -- light in my soul.
}

verseThree = \lyricmode {
  \tiny
  I cross the wide ex -- tend -- ed fields,
  I jour -- ney o'er the plain,
  And in the sun -- light of His love
  I reap the gold -- en grain.
}

chorus = \lyricmode {
  \tiny
  _ _ _ _ _ _ _ _
  _ _ _ _ _ _
  _ _ _ _ _ _ _ _
  _ _ _ _ _ _
  \set stanza = "Chorus. "
  Sun -- light, sun -- light sun -- light in my soul to -- day,
  Sun -- light, sun -- light sun -- light all a -- long the way. Sun- way
}

%%%%%%% LYRICS PLACEMENT %%%%%%%%%
trebleLyrics = <<
  \new Lyrics \lyricsto "treble" { \set stanza = "1." \verseOne }
  \new Lyrics \lyricsto "treble" {
    \chorus
  }
>>

altoLyrics = <<
  \new Lyrics \lyricsto "alto" { \set stanza = "2." \verseTwo }
>>

tenorLyrics = <<
  %  \new Lyrics \lyricsto "tenor" {
  %    \set stanza = "1." \verseThree
  %}


  \new Lyrics \lyricsto "tenor" { \set stanza = "3." \verseThree }

  \new Lyrics \lyricsto "tenor" {
    \chorus
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
