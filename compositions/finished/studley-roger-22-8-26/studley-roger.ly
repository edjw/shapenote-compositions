% relies on ../includes
\language "espanol"
\version "2.26.0"
#(set-default-paper-size "a4landscape")

songKey = "c major" % e.g. "e minor", "f# major", "bb major"
songTitle = "Studley Roger"
songMeter = "8.6.8.6"
songComposer = "Ed Johnson-Williams, August 2026"
poetName = ""
songFooter = ""
timeSignature = 4/4
noteHeadStyle = "seven" % "seven", "four", or "normal (not supported)"
pickupDuration = "0" % "0" = none, "2" = half, "2." = dotted half, "4" = quarter, "4." = dotted quarter, "8" = eighth, "8." = dotted eighth
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

trebleMusic = \relative do'' {
  sol1 |
  do4 mi sol sol |
  mi re mi re |
  do mi mi sol |
  mi2. \repeat volta 2 {
    r4 |
    r2. mi4 |
    mi re do si |
    sol2. la4 |
    do2. mi4 |
    sol2. r4 |
    r1 |
    r2. do,4 |
    mi re do la |
    do mi sol mi |
    mi2. sol4 |
    mi2 re |
  }
  \alternative { { mi2. } { mi1 |  } }

}

altoMusic = \relative do'' {
  sol1 |
  sol4 la sol sol |
  sol fa mi sol |
  sol la sol sol |
  sol2. \repeat volta 2 {
    r4
    r2. sol4 |
    sol fa mi re |
    do2. do4 |
    mi2. sol4 |
    sol2. sol4 |
    do2 do |
    si2. sol4 |
    sol fa mi do |
    mi sol sol sol |
    sol2. sol4 |
    la2 sol
  }

  \alternative { { sol2. } { sol1 |  } }

}

tenorMusic = \relative do'' {
  sol1 |
  do4 do do re |
  mi re do sol |
  do la sol sol |
  do2.
  \repeat volta 2 {
    r4 |
    r1 |
    r2. sol4 |
    do re mi fa |
    sol2. mi4 |
    re2. r4 |
    r1 |
    r2. sol,4 |
    do re mi fa |
    sol mi do do |
    do2. re4 |
    mi2 sol, |
  }

  \alternative { { do2. } { do1 |  } }

}

bassMusic = \relative do' {

  do1 |
  do4 la sol sol |
  mi sol do sol |
  sol mi do do |
  do2.
  \repeat volta 2 {
    sol'4 |
    la si do do |
    sol1~ |
    sol2. fa4 |
    mi2. do4 |
    sol'1 ~ |
    sol1~
    sol2. do4 |
    do sol sol fa |
    mi do do do |
    do2. sol'4 |
    la2 sol
  }

  \alternative { { do,2. } { do1 |  } }


}
%%%%%%%%%%%%%%%%

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  As pants the hart for cool -- ing streams,
  when heat -- ed in the chase.
  So longs my soul, O God for thee
  So longs my soul, O God for thee,
  and thy re -- fresh -- ing grace grace.
}

verseOneTreble = \lyricmode {
  \tiny
  As pants the hart for cool -- ing streams,
  when heat -- ed in the chase.
  So longs my soul O God, O God for thee,
  So longs my soul O God for thee,
  and thy re -- fresh -- ing grace grace.

}

verseOneAlto = \lyricmode {
  \tiny
  _ _ _ _ _ _ _ _ _ _ _ _ _ _
  So longs my soul, O God O God for thee
  O God for thee


}

verseOneBass = \lyricmode {
  \tiny
  _ _ _ _ _ _ _ _ _ _ _ _ _ _
  So longs my soul O "God__" \skip 1 \skip 1
  for thee __

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
  \new Lyrics \lyricsto "treble" {  \verseOneTreble }
>>

altoLyrics = <<
  \new Lyrics \lyricsto "alto" {
    \verseOneAlto
  }
>>

tenorLyrics = <<
  \new Lyrics \lyricsto "tenor" {
    \verseOne
  }
  % \new Lyrics \lyricsto "tenor" { \set stanza = "3." \verseThree }
>>

bassLyrics = <<
  \new Lyrics \with { alignAboveContext = "bass" } \lyricsto "bass" {

    \verseOneBass
  }
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
