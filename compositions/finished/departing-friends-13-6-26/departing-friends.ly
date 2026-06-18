% relies on ../includes
\language "espanol"
\version "2.26.0"
#(set-default-paper-size "a4landscape")

% Major: C: do  D: re  E: mi  F: fa  G: sol  A:  la  Bb: sib  Eb: mib
% Minor: A: do  B: re  C#:mi  D: fa  E: sol  F#: la  G: sib   C: mib

songKey = sol
songMode = "major" % "major" or "minor"
songTitle = "Departing Friends"
songMeter = "CM"
songComposer = "Ed Johnson-Williams, June 2026"
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
  sol2 mi4 sol |
  sol2 la |
  sol4.(la8 sol4) mi |
  sol2 sol |
  do4.(la8) sol4(la) |
  la2. sol4 |
  sol1 |
  r2 sol2 |
  mi4(sol) do(la) |
  sol4.(la8 sol4) mi |
  mi2. mi4 |
  la2.
  \repeat volta 2 {
    la4
    sol2 sol
    la4(sol) sol4.(fa8) |

    \alternative { { sol2.  } { mi1 } }
  }

}

altoMusic = \relative do' {
  sol2 do4 mi |
  re2 do |
  do2. mi4 |
  re2 re |
  do re4(mi) |
  mi4.(re8 mi4) re |
  do1 |
  r2 re2|
  mi4(re) do2 |
  do2. la4 |
  do2. la4 |
  do4(re do)
  \repeat volta 2 {
    do4
    re2 do |
    la4(do) re2

    \alternative {
      { mi2.  } { do1 }
    }
  }
}

tenorMusic = \relative do' {
  re4.(do8) sol'4 mi |
  re2 do |
  mi4.(fa8 sol4) la |
  sol2 sol |
  la2 sol4(la) |
  mi4.(re8 do4) re |
  do1 | \break
  r2 re4.(do8) |
  do4(re) sol(fa) |
  mi2. mi4 |
  sol4(la sol) la |
  fa2.
  \repeat volta 2 {
    sol4
    sol(fa) mi(re) |
    do2 re |

    \alternative {
      { mi2.  } { do1 }
    }
  }

  \bar ".."
}

bassMusic = \relative do {
  sol2 do4 do |
  sol2 la |
  do2. la4 |
  sol2 sol |
  fa2 sol4(la) |
  la2. sol4 |
  do1 |
  r2 sol2 |
  sol2 do |
  do2. la4 |
  do2. la4 |
  fa2.
  \repeat volta 2 {
    do'4
    sol2 do |
    la sol |

    \alternative {
      { sol2.  } { do1 }
    }
  }

}
%%%%%%%%%%%%%%%%

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  Why do we mourn de -- part -- ing friends,
  Or shake at death's a -- larms?
  'Tis but the voice that Je -- sus sends
  To call them to his arms.
}

verseTwo = \lyricmode {
  \tiny
  Are we not tend -- ing up -- ward too
  As fast as time can move?
  Nor would we wish the hours more slow
  To keep us from our love.
}

verseThree = \lyricmode {
  \tiny
  Why should we trem -- ble to con -- vey
  Their bod -- ies to the tomb?
  There the dear flesh of Je -- sus lay,
  And left a long per -- fume.
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
  \new Lyrics \lyricsto "alto" { \set stanza = "2." \verseTwo }
>>

tenorLyrics = <<

  \new Lyrics \lyricsto "tenor" { \set stanza = "3." \verseThree }
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
