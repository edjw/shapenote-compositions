% relies on ../includes
\language "espanol"
\version "2.26.0"
#(set-default-paper-size "a4landscape")

% Major: C: do  D: re  E: mi  F: fa  G: sol  A:  la  Bb: sib  Eb: mib
% Minor: A: do  B: re  C#:mi  D: fa  E: sol  F#: la  G: sib   C: mib

songKey = sol
songMode = "major" % "major" or "minor"
songTitle = "Abide With Me"
songMeter = "10s"
songComposer = "William Henry Monk"
poetName = "Henry Francis Lyte"
songFooter = ""
timeSignature = 4/4
noteHeadStyle = "seven" % "seven", "four", or "normal (not supported)"
midiTempo = 110

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
  sol2 sol4 fa |
  mi2 do |
  do4 sol' sol sol |
  sol1 |
  sol2 fa4 mi |
  fa2 mi |
  la4 sol sol do, |
  re1 |
  mi4(fa) sol fa |
  mi2 do'4(si) |
  la4 la la sol |
  fa1 |
  sol2 sol4 sol |
  sol fa mi la |
  sol2. fa4 |
  mi1 |

}

altoMusic = \relative do' {
  do2 si4 si |
  do2 do |
  do4 si do re |
  do1 |
  do2 do4 do |
  do2 do |
  do4 re do do |
  si1 |
  do2 si4 si |
  do2 do |
  do4 do dos dos |
  re1 |
  si2 do4 si |
  do si do re |
  do2 si |
  do1 |

}

tenorMusic = \relative do' {
  mi2 mi4 re |
  do2 sol' |
  la4 sol sol fa |
  mi1 |
  mi2 fa4 sol |
  la2 sol |
  fa4 re mi fas |
  sol1 |
  mi2 mi4 re |
  do2 sol' |
  sol4 fa fa mi |
  re1 |
  re2 mi4 fa |
  mi4 re do fa |
  mi2 re |
  do1
  \bar ".."
}

bassMusic = \relative do {
  do2 sol4 sol |
  la2 mi |
  fa4 sol la si |
  do1 |
  do4(si) la sol |
  fa2 do' |
  re4 si do la |
  sol1 |
  do2 sol4 sol |
  la2 mi |
  fa4. sol8 la4 la |
  re1 |
  fa2 mi4 re |
  do sol la fa |
  sol2 sol |
  do1 |
}
%%%%%%%%%%%%%%%%

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  A -- bide with me; Fast falls the e -- ven -- tide,
  The dark -- ness deep -- ens; Lord, with me a -- bide!
  When o -- ther help -- ers fail, and com -- forts flee,
  Help of the help -- less, oh, a -- bide with me.
}

verseTwo = \lyricmode {
  \tiny
  Swift to its close ebbs out life’s lit -- tle day;
  Earth’s joys grow dim, its glo -- ries pass a -- way;
  Change and de -- cay in all a -- round I see;
  O Thou who chan -- gest not, a -- bide with me.
}

verseThree = \lyricmode {
  \tiny
  Thou on my head in ear -- ly youth didst smile,
  And though re -- bel -- lious and per -- verse mean -- while,
  Thou hast not left me, oft as I left Thee.
  On to the close, O Lord, a -- bide with me.
}

verseFour = \lyricmode {
  \tiny
  I fear no foe, with Thee at hand to bless;
  Ills have no weight, and tears no bit -- ter -- ness.
  Where is death’s sting? Where, grave, thy vic -- to -- ry?
  I tri -- umph still, if Thou a -- bide with me.
}

%%%%%%% LYRICS PLACEMENT %%%%%%%%%
trebleLyrics = <<
  % \new Lyrics \lyricsto "treble" { \set stanza = "1." \verseOne }
>>

altoLyrics = <<
  % \new Lyrics \lyricsto "alto" { \set stanza = "2." \verseTwo }
>>

tenorLyrics = <<
  \new Lyrics \lyricsto "tenor" {
    \set stanza = "1." \verseOne
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
%\include "shapenote-print-experimental.ily"
%%
\include "shapenote-print-standard.ily"

%%%%%%%%%%%%%%%%


\include "shapenote-midi.ily"
