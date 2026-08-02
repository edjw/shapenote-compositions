% relies on ../includes
\language "espanol"
\version "2.26.0"
#(set-default-paper-size "a4landscape")

songKey = "F major" % e.g. "e minor", "f# major", "bb major"
songTitle = "And Hallelujahs Sing"
songMeter = "CM"
songComposer = "Tom Sprackland, July 2026"
poetName = "Elizabeth Singer Rowe, 1739"
songFooter = ""
timeSignature = 2/4
noteHeadStyle = "seven" % "seven", "four", or "normal (not supported)"
pickupDuration = "0" % "0" = none, "2" = half, "2." = dotted half, "4" = quarter, "4." = dotted quarter, "8" = eighth, "8." = dotted eighth
midiTempo = 100
%openingShapeStyle = "root" % "seventh" = si/mi marker, "root" = do/la marker. Always choose seventh in four shapes
%showKeySignatureWords = "yes" % "yes" or "no"
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

  \repeat volta 2 {
    r4 sol |
    mi4 mi8[fa] |
    sol4. la8 |
    sol4 mi |
    mi2~ |
    mi4 do |
    sol'4. fa8 |
    mi8[re] do4 |
    sol'2 |
  }

  \repeat volta 2 {

    r4 sol4 |
    do,4. re8 |
    mi4 sol |
    mi2 |
    r4 fa |
    mi8[sol] sol[la] |
    sol4 la |
    si2 |
    r4 mi, |
    sol la |
    sol4. sol8 |
    mi4 do |
    mi2~ |
    mi4 mi |
    mi8[sol] sol8[la] |
    sol4 la |
    sol2 |

  }

}

altoMusic = \relative do' {

  \repeat volta 2 {
    r4 mi |
    do do |
    re4. do8 |
    do4 mi |
    do2~ |
    do4 mi |
    do mi8[re] |
    do4 re |
    mi2
  }

  \repeat volta 2 {

    r4 mi |
    do4. re8 |
    do4 do |
    mi2 |
    r4 mi |
    do4. re8 |
    mi4 mi |
    re2 |
    r4 do |
    do do |
    si4. do8 |
    mi4 mi |
    do2~ |
    do4 mi |
    do4. re8 |
    do4 re |
    mi2 |

  }
}



tenorMusic = \relative do' {
  \repeat volta 2 {
    r4 sol8[la] |
    do4 mi |
    re4. mi8 |
    do4 mi |
    sol2~ |
    sol4 la8[sol] |
    mi4 do8[re] |
    mi4 re |
    do2 |
  }

  \repeat volta 2 {
    r4 mi |
    sol4. la8 |
    sol4 mi |
    sol2 |
    r4 la |
    sol8[mi] do8[re] |
    mi4 do |
    re2 |
    r4 sol,8[la] |
    do4 mi |
    re4. mi8 |
    do4 mi |
    sol2~ |
    sol4 la |
    sol8[mi] do[re] |
    mi4 re |
    do2 |


  }

  \bar ".."
}

bassMusic = \relative do {
  \repeat volta 2 {
    r4 do |
    sol4 sol |
    do4. do8 |
    mi4 sol |
    do,2~ |
    do4 do4 |
    do4. sol8 |
    la4 sol |
    sol2 |


  }
  \repeat volta 2 {
    r4 do |
    mi4. re8 |
    sol,4 sol |
    do2 |
    r4 re |
    do4. do8 |
    sol'4 sol |
    sol,2 |
    r4 do4 |
    mi4 do |
    sol4. sol8 |
    sol4 la |
    do2~ |
    do4 do |
    sol4. sol8 |
    do4 si |
    do2 |

  }
}
%%%%%%%%%%%%%%%%

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  The glor -- ious arm -- ies of the sky
  To Thee, al --migh -- ty King!

}

verseOneRepeat = \lyricmode {
  \tiny
  Har -- mon -- ious an -- thems con -- se -- crate,
  And hal -- le -- lu -- jahs sing.
}

verseOneSecondPart = \lyricmode {
  \tiny
  And hal -- le -- lu -- jahs sing.
  And hal -- le -- lu -- jahs sing.
  Har -- mon -- ious an -- thems con -- se -- crate,
  And hal -- le -- lu -- jahs sing.
}

verseTwo = \lyricmode {
  \tiny
  But still their most ex -- alt -- ed flights
  Fall vast -- ly short of Thee:

}

verseTwoRepeat = \lyricmode {
  \tiny
  How dist -- ant then must hu -- man praise
  From Thy per -- fect -- ions be.
}

verseTwoSecondPart = \lyricmode {
  \tiny
  From Thy per -- fect -- ions be.
  From Thy per -- fect -- ions be.
  How dist -- ant then must hu -- man praise
  From Thy per -- fect -- ions be.
}




%%%%%%% LYRICS PLACEMENT %%%%%%%%%
trebleLyrics = <<

  \new Lyrics \lyricsto "treble" {
    \set stanza = "1." \verseOne
    \verseOneSecondPart
  }
  \new Lyrics \lyricsto "treble" {
    \verseOneRepeat
  }


>>



tenorLyrics = <<
  \new Lyrics \lyricsto "tenor" {
    \set stanza = "2." \verseTwo
    \verseTwoSecondPart
  }

  \new Lyrics \lyricsto "tenor" {
    \verseTwoRepeat
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
%\include "shapenote-print-experimental.ily"
%%
\include "shapenote-print-standard.ily"

%%%%%%%%%%%%%%%%


\include "shapenote-midi.ily"
