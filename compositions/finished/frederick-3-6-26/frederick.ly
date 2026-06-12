\language "espanol"
\version "2.26.0"
#(set-default-paper-size "a4landscape")

% Major: C: do  D: re  E: mi  F: fa  G: sol  A:  la  Bb: sib  Eb: mib
% Minor: A: do  B: re  C#:mi  D: fa  E: sol  F#: la  G: sib   C: mib

songKey = do
songMode = "minor" % "major" or "minor"
songTitle = "Frederick"
songMeter = "8.6.8.6"
songComposer = "Ed Johnson-Williams, April 2026"
poetName = "John Reynell Wreford, 1837"
songFooter = ""
timeSignature = 3/4
noteHeadStyle = "seven" % "seven", "four", or "normal (not supported)"
pickupDuration = "4" % "0" = none, "2" = half, "2." = dotted half, "4" = quarter, "4." = dotted quarter, "8" = eighth, "8." = dotted eighth
midiTempo = 80
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
% Octaves:              do'4 (higher)  do,4 (lower)
% Slurs:                do8( re8 mi8)
% Repeats:              \repeat volta 2 { music }
% Ties:                 do4~ do4
% Octave doubling:      <do do,>2 (bass root + octave below)
% Text markings:        do4^\markup { "Fine" }
% Combined:              do8([ re8]) (slur and beam together)
% Rests:                r1  r2  r4  r1.  r2.
% Fermatas:             do4\fermata
% Fine/D.C.:            \mark \markup { \tiny \italic "Fine." }
%                       \mark \markup { \italic \tiny "D.C." }
% Chords:               <do mi sol>4
% Ending barlines:      \bar ".." (standard)  \bar "." (final)  \bar ".;" (repeat start)
% Line break:           \break (after A section)
% Mid-bar:              \bar ";"
% Alternative endings:  \alternative { { ending1 } { ending2 } }
% Accidentals:          fas4 or sib4 (sharps add s, flats add b)
% Triplets:             \tuplet 3/2 { do8 re8 mi8 }
% Repeat+fermata:       \bar ".:" (put \fermata on last note before it)
% Segno:                do4^\markup { \tiny \musicglyph "scripts.segno" }

trebleMusic = \relative do'' {

  mi4 |
  mi2 do4 |
  do2 mi8[do] |
  sol'2 sol4 |
  mi2 mi8[re] |
  mi2 mi4 |
  sol2 sol4 |
  mi2
  \repeat volta 2 {
    do4
    mi2 mi8[re] |
    do2 mi8[sol] |
    mi2 mi4 |
    sol2 do,8[re] |
    mi2 mi4 |
    do2 re4 |
  }
  \alternative {
    { mi2 } { mi2. }
  }
}


altoMusic = \relative do' {

  mi4 |
  do2 do8[mi] |
  mi2 mi8[re] |
  mi2 re4 |
  do2 re4 |
  mi2 do4 |
  do2 re4 |
  mi2
  \repeat volta 2 {
    mi4
    do2 do8[re] |
    mi2 mi8[sol]
    la2 la4 |
    la2 la4 |
    mi2 mi4 |
    mi2 re4 |
    \alternative {
      { mi2 } { mi2. }
    }
  }
  \bar ".."

}
tenorMusic = \relative do'' {
  la8[sol] |
  mi2 sol4 |
  la2 la8[sol] |
  do2 re4 |
  mi2 mi8[re] |
  do2 la4 |
  mi2 sol4 |
  la2
  \repeat volta 2 {
    la8[sol]
    mi2 sol4 |
    la2 do8[re] |
    do2 do4 |
    mi2 mi8[re] |
    do2 mi4 |
    mi2 sol,4 |
    \alternative {
      { la2 } { la2. }
    }
  }
}
bassMusic = \relative do' {

  la4 |
  la2 do8[sol] |
  la2 do4 |
  do2 sol4 |
  la2 la8[sol] |
  la2 do4 |
  do2 sol4 |
  la2
  \repeat volta 2 {
    la4
    la2 sol4 |
    mi2 sol4 |
    la2 la4 |
    la2 la8[sol] |
    la2 la4 |
    do2 sol4 |
  }
  \alternative {
    { la2 } { la2. }
  }


}
%%%%%%%%%%%%%%%%

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  O may we, Lord, be one in You
  in know -- ledge, truth and love.
  And let our songs of free -- dom rise
  from earth to heav'n a -- bove.
}

verseTwo = \lyricmode {
  \tiny
  U -- nite us in the sa -- cred love
  Of know  -- ledge truth and Thee.
  And let our hills and val -- leys shout
  The song of lib -- er  -- ty.
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
  \new Lyrics \lyricsto "tenor" {
    \set stanza = "2."  \verseTwo
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
%\include "shapenote-print-standard.ily"

%%%%%%%%%%%%%%%%


\include "shapenote-midi.ily"
