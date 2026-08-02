% relies on ../includes
\language "espanol"
\version "2.26.0"
#(set-default-paper-size "a4landscape")

songKey = "F major" % e.g. "e minor", "f# major", "bb major"
songTitle = "Tatooine"
songMeter = "CM"
songComposer = "Chris Noren, July 2026"
poetName = "Elizabeth Singer Rowe, 1739"
songFooter = ""
timeSignature = 4/4
noteHeadStyle = "seven" % "seven", "four", or "normal (not supported)"
pickupDuration = "0" % "0" = none, "2" = half, "2." = dotted half, "4" = quarter, "4." = dotted quarter, "8" = eighth, "8." = dotted eighth
midiTempo = 100

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
  sol2 mi4. sol8 |
  do,2. sol'4 |
  sol2 la4(si) |
  do2. do4 |
  sol2 sol4(mi) |
  la2 do4(la) |
  sol1 |

  \repeat volta 2 {
    sol2 sol4. mi8 |
    fa2. sol4 |
    do4(sol) mi(la) |
    sol2. r4 |
    r1 |
    r1 |
    r2. sol4 |
    do si la sol |
    sol2. sol4 |
    fa(sol) la(si) |
    do2 si4(la) |
    sol1 |
  }
}

altoMusic = \relative do'' {
  sol2 mi4. sol8 |
  do,2. do4 |
  mi2 re |
  do2. mi4 |
  do2 do4(sol) |
  la2. do4 |
  do1 |
  \repeat volta 2 {
    mi2 mi4. re8 |
    do2. si4 |
    do2 mi4(do) |
    si2. r4 |
    r1 |
    r2. fa'4 |
    mi re do re |
    mi2. do4 |
    mi fa sol mi |
    do re mi re |
    do2 si |
    do1 |
  }

}

tenorMusic = \relative do'' {
  sol2 mi4. sol8 |
  do,2. do4 |
  si2 la |
  sol2. do4 |
  mi2 do4(mi) |
  fa2 sol4(mi) |
  do1 |

  \repeat volta 2 {
    do2 mi4. do8 |
    fa2. re4 |
    sol4(mi do) mi |
    re2. r4 |
    r2. do4 |
    fa sol la fa |
    sol2. sol4 |
    sol la si sol |
    do2. sol4 |
    do4(la) sol(fa) |
    mi2 re |
    do1 |
  }
  \bar ".."
}

bassMusic = \relative do' {
  sol2 mi4. sol8 |
  do,2. do4 |
  sol2 la |
  do2. do4 |
  do(si) la(sol) |
  fa2. sol4 |
  do1 |

  \repeat volta 2 {

    do2 sol4. sol8 |
    la2. si4 |
    do2 do4(la) |
    sol2. sol4 |
    do re mi do |
    fa2. fa4 |
    do re mi do |
    sol2. sol4 |
    do re mi do |
    fa mi re do |
    sol'2 sol, |
    do1 |
  }



}
%%%%%%%%%%%%%%%%

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  The glor -- ious arm -- ies of the sky
  To Thee, al -- migh -- ty King!
  Har -- mon -- ious an -- thems con -- se -- crate,
  And hal -- le -- lu -- jahs sing.
  And hal -- le -- lu -- jahs sing.
}

verseTwo = \lyricmode {
  \tiny
  But still their most ex -- alt -- ed flights
  Fall vast -- ly short of Thee:
  How dist -- ant then must hu -- man praise
}

verseTwoTrebleEnding = \lyricmode {
  \tiny
  _ _ _ _ _ _ _ _
  _ _ _ _ _ _
  _ _ _ _ _ _ _ _
  And hal -- le -- lu -- jahs sing.
  And hal -- le -- lu -- jahs sing.
}

verseOneTenorEnding = \lyricmode {
  \tiny
  _ _ _ _ _ _ _ _
  _ _ _ _ _ _
  _ _ _ _ _ _ _ _
  And hal -- le -- lu -- jahs sing.
  And hal -- le -- lu -- jahs sing.
  And hal -- le -- lu -- jahs sing.
}

verseTwoTenorEnding = \lyricmode {
  \tiny
  _ _ _ _ _ _ _ _
  _ _ _ _ _ _
  _ _ _ _ _ _ _ _
  From Thy per -- fect -- ions be.
  From Thy per -- fect -- ions be.
  From Thy per -- fect -- ions be.
}



verseOneAltoEntry = \lyricmode {
  \tiny
  _ _ _ _ _ _ _ _
  _ _ _ _ _ _
  _ _ _ _ _ _ _ _
  And hal -- le -- lu -- jahs sing.

  And hal -- le -- lu -- jahs sing.
  And hal -- le -- lu -- jahs sing.
}

verseTwoAltoEntry = \lyricmode {
  \tiny
  _ _ _ _ _ _ _ _
  _ _ _ _ _ _
  _ _ _ _ _ _ _ _
  From Thy per -- fect -- ions be.
  From Thy per -- fect -- ions be.
  From Thy per -- fect -- ions be.


}




verseOneBassEntry = \lyricmode {
  \tiny
  _ _ _ _ _ _ _ _
  _ _ _ _ _ _
  _ _ _ _ _ _ _ _
  And hal -- le -- lu -- jahs sing.
  And hal -- le -- lu -- jahs sing.
  And hal -- le -- lu -- jahs sing.
  And hal -- le -- lu -- jahs sing.
}

verseTwoBassEntry = \lyricmode {
  \tiny
  _ _ _ _ _ _ _ _
  _ _ _ _ _ _
  _ _ _ _ _ _ _ _
  From Thy per -- fect -- ions be.
  From Thy per -- fect -- ions be.
  From Thy per -- fect -- ions be.
  From Thy per -- fect -- ions be.
}





%%%%%%% LYRICS PLACEMENT %%%%%%%%%
trebleLyrics = <<
  \new Lyrics \lyricsto "treble" { \set stanza = "1." \verseOne }

  \new Lyrics \lyricsto "treble" {
    \verseTwoTrebleEnding
  }
>>

altoLyrics = <<
  \new Lyrics \lyricsto "alto" { \verseOneAltoEntry }
  \new Lyrics \lyricsto "alto" { \verseTwoAltoEntry }

>>

tenorLyrics = <<
  \new Lyrics \lyricsto "tenor" { \set stanza = "2." \verseTwo }

  \new Lyrics \lyricsto "tenor" {
    \verseOneTenorEnding
  }
  \new Lyrics \lyricsto "tenor" {
    \verseTwoTenorEnding
  }
>>

bassLyrics = <<
  \new Lyrics \lyricsto "bass" {  \verseOneBassEntry }
  \new Lyrics \lyricsto "bass" {  \verseTwoBassEntry }

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
