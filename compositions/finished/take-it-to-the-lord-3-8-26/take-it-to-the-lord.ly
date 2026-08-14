% relies on ../includes
\language "espanol"
\version "2.26.0"
#(set-default-paper-size "a4landscape")

songKey = "Bb major" % e.g. "e minor", "f# major", "bb major"
songTitle = "Take it to the Lord"
songMeter = "8.7.8.7 D"
songComposer = "Ed Johnson-Williams, August 2026"
poetName = "Joseph Medlicott Scriven, 1855"
songFooter = ""
timeSignature = 2/4
noteHeadStyle = "seven" % "seven", "four", or "normal (not supported)"
pickupDuration = "2" % "0" = none, "2" = half, "2." = dotted half, "4" = quarter, "4." = dotted quarter, "8" = eighth, "8." = dotted eighth
midiTempo = 100
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
% Ending barline:       automatic ".." | override with \bar "|."
% Line break:           \break (after A section)
% Mid-bar:              \bar ";"
% Alternative endings:  \alternative { { ending1 } { ending2 } }
% Accidentals:          fas4 or sib4 (sharps add s, flats add b)
% Triplets:             \tuplet 3/2 { do8 re8 mi8 }
% Time signature:       \bar ".." \time 3/2
% Repeat+fermata:       \bar ".|:" (put \fermata on last note before it)
% Segno:                do4^\markup { \tiny \musicglyph "scripts.segno" }

trebleMusic = \relative do' {

  \repeat volta 2 {
    mi4 mi |
    mi4. re8 do4 mi |
    re4 re do mi |
    sol4. sol8 la4 sol |
    mi2 |
  }

  mi4 mi |
  sol4. la8 la4 sol |
  mi4 do do mi |
  re4. re8 do8[re] mi4 |
  sol2 mi4 mi |
  sol4. la8 la4 sol |
  sol4 sol mi sol |
  mi4. re8 do8[re] mi[re] |
  mi2 |
}

altoMusic = \relative do' {
  \repeat volta 2 {
    sol4 mi |
    sol4. la8 sol4 mi |
    re4 re mi mi |
    sol4. sol8 mi4 sol |
    sol2
  }
  sol4 sol |
  sol4. la8 la4 sol |
  sol4 mi sol mi |
  sol4. sol8 sol4 mi |
  re2 sol4 mi |
  mi4. re8 mi4 mi |
  sol sol mi sol |
  sol4. sol8 sol4 mi8[sol] |
  sol2 |

}

tenorMusic = \relative do' {
  \repeat volta 2 {
    sol4 la |
    do4. la8 do4 la |
    sol4 sol sol la |
    do4. re8 mi4 re |
    do2
  }
  do4 do |
  re4. re8 mi4 re |
  do4 sol do mi |
  sol4. sol8 mi8[re] do[mi] |
  re2 sol,4 la |
  do4. la8 do4 mi |
  re4 re mi re |
  do4. re8 mi8[re] do[re] |
  do2 |
}

bassMusic = \relative do, {
  \repeat volta 2 {
    do4 mi |
    do4. re8 do4 mi |
    sol4 sol do la |
    sol4. sol8 la4 sol |
    do,2
  }
  do4 mi |
  sol4. la8 la4 sol |
  do4 do do la |
  sol4. sol8 sol4 mi |
  re2 do4 mi |
  do4. re8 do4 mi |
  sol4 sol la sol |
  mi4. sol8 sol4 mi8[re] |
  do2 |

}
%%%%%%%%%%%%%%%%

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  What a friend we have in Je -- sus,
  all our sins and griefs to bear!

  O what peace we of -- ten for -- feit,
  O what need -- less pain we bear.
  All be -- cause we do not car -- ry
  ev' -- ry -- thing to God in prayer!

}

verseOneOpeningRepeat = \lyricmode {
  \tiny
  What a priv -- i -- lege to car -- ry
  ev' -- ry -- thing to God in prayer!

}

verseTwo = \lyricmode {
  \tiny
  Have we tri -- als and temp -- ta -- tions?
  Is there trou -- ble a -- ny -- where?

  Can we find a friend so faith -- ful
  Who will all our sor -- rows share?
  Je -- sus knows our ev' -- ry weak -- ness.
  Take it to the Lord in prayer!

}

verseTwoOpeningRepeat = \lyricmode {
  \tiny
  We should ne -- ver be dis -- cour -- aged.
  Take it to the Lord in prayer!


}

verseThree = \lyricmode {
  \tiny
  Are we weak and hea -- vy la -- den,
  cum -- bered with a load of care?

  Do your friends de -- spise, for -- sake you?
  Take it to the Lord in prayer!
  In his arms he'll take and shield you.
  You will find a sol -- ace there.

}

verseThreeOpeningRepeat = \lyricmode {
  \tiny
  Prec -- ious Sav -- ior, still our re -- fuge.
  Take it to the Lord in prayer!


}






verseFour = \lyricmode {
  \tiny
  % Verse 4 lyrics if needed
}

%%%%%%% LYRICS PLACEMENT %%%%%%%%%
trebleLyrics = <<
  \new Lyrics \lyricsto "treble" {
    \set stanza = "1. " \verseOne
  }

  \new Lyrics \lyricsto "treble" {
    \verseOneOpeningRepeat
  }
>>

altoLyrics = <<
  \new Lyrics \lyricsto "alto" {
    \set stanza = "2. " \verseTwo
  }

  \new Lyrics \lyricsto "alto" {
    \verseTwoOpeningRepeat
  }
>>

tenorLyrics = <<
  \new Lyrics \lyricsto "tenor" {
    \set stanza = "3." \verseThree
  }

  \new Lyrics \lyricsto "tenor" {
    \verseThreeOpeningRepeat
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
