% relies on ../includes
\language "espanol"
\version "2.26.0"
#(set! paper-alist (cons '("7x4.25" . (cons (* 7 in) (* 4.25 in))) paper-alist))
#(set-default-paper-size "7x4.25")

% Major: C: do  D: re  E: mi  F: fa  G: sol  A:  la  Bb: sib  Eb: mib
% Minor: A: do  B: re  C#:mi  D: fa  E: sol  F#: la  G: sib   C: mib

songKey = do
songMode = "major" % "major" or "minor"
songTitle = "Pulborough"
songMeter = "7.6.7.6.7.7.7.6"
songComposer = "Ed Johnson-Williams, May 2026"
poetName = "John Newton"
%songFooter = ""
timeSignature = 2/4
noteHeadStyle = "four" % "seven", "four", or "normal (not supported)"
%pickupDuration = "0" % "0" = none, "2" = half, "2." = dotted half, "4" = quarter, "4." = dotted quarter, "8" = eighth, "8." = dotted eighth
midiTempo = 80
%openingShapeStyle = "root" % "seventh" = si/mi marker, "root" = do/la marker. Always choose seventh in four shapes
%showKeySignatureWords = "yes" % "yes" or "no"

\include "shapenote-common.ily"

showChoirBrace = ##f

\paper {
  system-count = #2
  page-count = #2
  print-page-number = ##f
  evenHeaderMarkup = \markup \null
  markup-system-spacing = #'((basic-distance . 6) (padding . 1))
  top-margin = 0.75\cm
  bottom-margin = 0.75\cm
  %    left-margin = 0.75\cm
  %  right-margin= 0.75\cm
}

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

trebleMusic = \relative do'' {
  \repeat volta 2 {

    mi4. mi8 |
    re4 do |
    sol' sol |
    mi re |
    mi4. mi8 |
    do4 do 4 |
    mi2-\tweak font-size #-2 -\tweak font-shape #'italic ^"Fine." |
  }


  sol4. sol8 |
  mi4 sol |
  sol4 mi |
  mi2 |
  do4. la8 |
  sol4 do
  mi sol |
  sol2-\tweak font-size #-2 -\tweak font-shape #'italic ^"D.C." |

}

altoMusic = \relative do'' {
  \repeat volta 2 {
    sol4. mi8 |
    sol4 mi |
    sol mi |
    do re |
    mi4. mi8 |
    mi4 sol |
    sol2 |
  }

  mi4. mi8 |
  mi4 mi |
  sol sol |
  mi2 |
  sol4. la8 |
  sol4 sol |
  mi4 sol |
  sol2

}

tenorMusic = \relative do'' {
  \repeat volta 2 {


    do4. la8 |
    sol4 sol |
    do8[re] mi4|
    do sol |
    la4. do8 |
    mi4 do |



    \newSpacingSection
    \override Score.SpacingSpanner.spacing-increment = #0.1
    do2-\tweak font-size #-2 -\tweak font-shape #'italic ^"Fine." |
    \newSpacingSection
    \revert Score.SpacingSpanner.spacing-increment

  }
  \break  do4.   mi8 |
  sol4 mi |
  mi8[re] do4|
  mi2 |
  mi4. fa8 |
  sol4 mi |
  la8[sol] mi4 |

  \newSpacingSection
  \override Score.SpacingSpanner.spacing-increment = #0.1
  re2-\tweak font-size #-2 -\tweak font-shape #'italic ^"D.C."
  \newSpacingSection
  \revert Score.SpacingSpanner.spacing-increment

  \bar ".."
}

bassMusic = \relative do {
  \repeat volta 2 {
    do4. mi8 |
    sol4 mi |
    sol sol |
    la sol |
    la4. sol8 |
    mi4 do |
    do2 |
  }

  do4. do8 |
  sol'4 sol |
  sol sol |
  la2 |
  do4. do8 |
  sol4 mi |
  do4 mi |
  sol2 |
}
%%%%%%%%%%%%%%%%

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  Stop, poor sin -- ners, stop and think,
  Be -- fore you fur -- ther go!

  On the verge of ru -- in stop!
  Now the friend -- ly warn -- ing take

}

verseOneB = \lyricmode {
  \tiny
  Will you sport up -- on the brink
  Of ev -- er last -- ing woe!
}

verseOneC = \lyricmode {
  \tiny
  Stay your foot -- steps, ere ye drop
  In -- to the burn -- ing lake.
}


verseTwo = \lyricmode {
  \tiny
  Though your heart be made of steel,
  Your fore -- head lined with brass;

  Sin -- ners then in vain will call
  Those who now des -- pise His grace
}

verseTwoB = \lyricmode {
  \tiny
  God at length will make you feel;
  He will not let you pass;
}

verseTwoC = \lyricmode {
  \tiny
  Rocks and moun -- tains, on us fall,
  And hide us from His face.
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
    \set stanza = "1." \verseOne
  }
  \new Lyrics \lyricsto "treble" {
    \verseOneB
  }

  \new Lyrics \lyricsto "treble" {
    \set stanza = "DC." \verseOneC
  }

>>

altoLyrics = <<
  % \new Lyrics \lyricsto "alto" { \set stanza = "2." \verseTwo }
>>

tenorLyrics = <<
  \new Lyrics \lyricsto "tenor" {
    \set stanza = "2." \verseTwo
  }
  \new Lyrics \lyricsto "tenor" {
    \verseTwoB
  }

  \new Lyrics \lyricsto "tenor" {
    \set stanza = "DC." \verseTwoC
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
%\include "shapenote-print-experimental.ily"
%%
\include "shapenote-print-standard.ily"


%%%%%%%%%%%%%%%%


\include "shapenote-midi.ily"
