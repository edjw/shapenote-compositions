% relies on ../includes
\language "espanol"
\version "2.26.0"
#(set-default-paper-size "a4landscape")

songKey = "f minor" % e.g. "e minor", "f# major", "bb major"
songTitle = "Sharow"
songMeter = "11.10.11.6"
songComposer = "Ed Johnson-Williams, August 2026"
poetName = "John Greenleaf Whittier, 1882"
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

trebleMusic = \relative do' {
  r2 mi |
  la4 la mi re |
  mi2. do8[si] |
  la2 mi' |
  mi4 la2 sol4 |
  mi mi sol sol |
  la sol mi re |
  mi2 mi |
  re4 mi sol la |
  sol mi mi8[re] mi4 |
  re mi2 sol4 |
  sol la la sol |
  mi1 |
}

altoMusic = \relative do' {
  r2 la |
  la4 la la si |
  do2. do8[si] |
  la2 si |
  si4 la2 sol4 |
  sol la si si |
  la la sol sol |
  la2 do |
  si4 sol sol la |
  si do8[si] sol4 sol8[la] |
  sol4 la2 sol4 |
  sol4 la sol8[la] sol4 |
  la1 |

}

tenorMusic = \relative do' {
  r2 do2 |
  mi4 mi do si |
  la2. do8[re] |
  mi2 sol |
  mi4 do2 do8[re] |
  mi4 mi re re | \break
  mi mi sol sol |
  la2 la |   sol4 mi mi8[re] mi4 |
  sol la sol mi |
  sol la2 do,8[re] |
  mi4 mi do si |
  la1 |

}

bassMusic = \relative do {

  r2 la |
  la4 la la sol |
  la2. la8[sol] |
  la2 mi |
  sol4 la2 sol4 |
  mi mi sol sol |
  la la do si |
  la2 la |
  sol4 mi sol la |
  sol mi mi8[re] mi4 |
  sol la2 sol4 |
  mi mi mi sol |
  la1 |

}
%%%%%%%%%%%%%%%%

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  When on my day of life the night is fall -- ing,
  And in the winds from un -- sunned spa -- ces blown
  I hear far voi -- ces out of dark -- ness call -- ing
  My feet to paths un -- known
}

verseTwo = \lyricmode {
  \tiny
  Thou, who hast made my home of life so pleas -- ant,
  Leave not its ten -- ant when its walls de -- cay;
  O Love Di -- vine, O Help -- er ev -- er pres -- ent,
  Be Thou my strength and stay!
}

verseThree = \lyricmode {
  \tiny
  There from the mu -- sic round a -- bout me steal -- ing
  I fain would learn the new and ho -- ly song.
  And find at last, be -- neath Thy trees of heal -- ing,
  The life for which I long.}

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
