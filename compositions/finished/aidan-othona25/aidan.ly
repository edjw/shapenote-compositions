\language "espanol"
\version "2.24.0"
#(set-default-paper-size "a4landscape")

%%%%%% Shapenote Template %%%%%%
%
% HOW TO USE THIS TEMPLATE:
% 1. Change songKey to set the key - examples provided
% 2. Update song info: title, meter, composer
% 3. Update meter = "G Major" to show the key name
% 4. Enter music in the four voice sections
% 5. Add lyrics to verseOne and verseTwo sections

%
% KEY TRANSPOSITION EXAMPLES (change in ONE place only):
% C major:  \transpose do do
% G major:  \transpose do sol
% F major:  \transpose do fa
% D major:  \transpose do re
% A major:  \transpose do la
% E major:  \transpose do mi
% Bb major: \transpose do sib
% Eb major: \transpose do mib
%
% MINOR KEYS:
% A minor:  \transpose do do
% E minor:  \transpose do sol
% B minor:  \transpose do re
% F# minor: \transpose do la
% D minor:  \transpose do fa
% G minor:  \transpose do sib
% C minor:  \transpose do mib

%%%%%% QUICK SETTINGS %%%%%%
songKey = sib
songTitle = "Aidan"
songMeter = "11s"
keySignature = \markup { "B" \flat " Major" }
songComposer = "Ed Johnson-Williams, July & September 2025"
poet = "Isaac Watts"

\paper {
  page-count = #1
  system-count = #2
  system-system-spacing = #'((basic-distance . 0) (padding . 6))
  markup-system-spacing = #'((basic-distance . 12) (padding . 4))
  top-margin = 1.25\cm
  bottom-margin = 1.25\cm
}

\header {
  title = \markup{ \bold \smaller #songTitle "   " \small{#songMeter }}
  composer = #songComposer
  tagline = ##f % removes the Lilypond tagline from bottom
  poet = \markup{ \concat { #keySignature ", " #poet } }
}

global = {
  \key do \major % Don't change this
  \aikenHeads     % or \sacredHarpHeads for 4-shape
  \numericTimeSignature
  \partial 2
  \time 4/4       % Change as needed
  \defineBarLine ";" #'("|" ";" " ")        % Start repeat barline
  \defineBarLine ";." #'("|" ";." ";.")     % End repeat barline
  \defineBarLine ".;" #'("|" ".;" ".;")     % Double bar into start repeat
  \defineBarLine ".." #'(".." ".." "..")    % Double barline for section endings
  \defineBarLine ";.." #'(";.." ";.." ";..") % End repeat into double bar
  \defineBarLine ";.;" #'(";.;" ";.;" ";.;") % Back-to-back repeats
  \autoBeamOff
}

%%%%%%% MUSIC %%%%%%%%%
% Write all music with the do, re, mi, fa, sol, la, si
%
% HELPFUL PATTERNS:
% Repeats:         \repeat volta 2 { music }
% Mid-bar:         \bar ";"
% Line break:      \break (after A section)
% Beams:           do8[ re8] (eighth notes and shorter only)
% Slurs:           do8( re8 mi8)
% Combined:        do8([ re8]) (slur and beam together)
% Ties:            do4~ do4
% Dotted notes:    do4. re8
% Octaves:         do'4 (higher) or do,4 (lower)
% Fermatas:        do4\fermata
% Grace notes:     \grace { do8 } re4
% Chords:          <do mi sol>4
% Accidentals:     dis4 or reb4
% Text markings:   do4^\markup { "Fine" }
% Triplets:        \tuplet 3/2 { do8 re8 mi8 }

trebleMusic = \relative do' {



  mi2 |
  do do4 do |
  re2 mi4 re |
  do2 la4 do |
  mi2 mi |
  do do4 do |
  re2 mi4 mi |
  do2 do4 la | \break
  do2.  do4 |
  do2 mi4 sol |
  la2 sol4 mi |
  sol2 sol4 sol |
  sol2 mi2 |
  sol2 mi4 mi |
  re2 do4 re |
  mi2 re4 mi  |
  sol1 |

  \bar ".."

}

altoMusic = \relative do {
  mi2 |
  sol2 sol4 mi |
  sol2 sol4 sol |
  sol2 la4 la |
  sol2 mi |
  sol sol4 mi |
  sol2 sol4 la |
  sol2 la4 la |
  sol2.   sol4 |
  mi2 mi4 sol |
  la2 sol4 la |
  sol2 mi4 sol |
  mi2 mi |
  sol2 sol4 la |
  sol2 mi4 sol |
  sol2 sol4 sol |
  mi1 |
}

tenorMusic = \relative do' {


  sol2 |
  do do4 la |
  sol2 do4 re |
  mi2 fa4 do |
  do2

  sol |
  do do4 la4 |
  sol2 do4 mi |
  mi2 fa4 fa |
  do2.   mi4 |
  sol2 sol4 mi |
  mi2 do4 la |
  sol2 do4 do8[ re] |
  mi2

  do2 |
  do2 do4 la |
  sol2 do4 re |
  mi2 re4 mi |
  do1 |
  \bar ".."
}

bassMusic = \relative do {


  do2 |
  do do4 la |
  sol2 sol4 sol |
  sol2 fa4 la |
  sol2

  do |
  do2 do4 la |
  sol2 sol4 la |
  sol2 fa4 fa |
  do'2. do4 |
  sol2 do4 do |
  la2 sol4 la |
  do2 sol4 sol |
  sol2 do |
  do2 do4 do |
  sol2 do4 sol |
  do2 sol4 do |
  do1 |

}

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  I dreamt I was out, to the east cast mine eye,
  The at -- mos -- phere calm and se -- rene was the sky;
  So calm, still and aw -- ful, tre -- men -- dous the sight;
  I thought the last judge -- ment was dawn -- ing to light.

}

verseTwo = \lyricmode {
  \tiny
  A pil -- lar of cloud in the east did ap -- pear,
  A throne in the midst on which Je -- sus sat fair,
  Who co -- ming a -- long the e -- ther -- ’al bright plain
  And soar -- ing a -- loft till the midst He did gain.

}

% Additional verses if needed
verseThree = \lyricmode {
  \tiny
  The next I heard Je -- sus say “Come you up here;”
  Then all the blest nat -- ions a -- rose with -- out fear,
  And quit -- ting the globe with great plea -- sure did sing
  A song that was ne -- ver be -- fore tuned to string.
}

verseFour = \lyricmode {
  \tiny
  Then, in the sweet tran -- sport, my feet left the ground
  With -- out a -- ny mo -- tion of bo -- dy or sound;
  My joys were un -- speak -- ab -- ly full of de -- light;
  So loud was the mus -- ic it o’er -- came me quite.
}

%%%%%%% SCORE %%%%%%%%%
% Main music content (defined once, used for both print and MIDI)
musicContent = {
  \new ChoirStaff <<
    \new Staff = treble <<
      \new Voice = "treble" {
        \global
        \trebleMusic
      }
      \new Lyrics \lyricsto "treble" { \set stanza = "1." \verseOne }
      % Uncomment for additional verses under treble:
      \new Lyrics \lyricsto "treble" { \set stanza = "2." \verseTwo }
    >>

    \new Staff = alto <<
      \new Voice = "alto" {
        \global
        \altoMusic
      }
      % Uncomment for verse 2 under alto:
      \new Lyrics \lyricsto "alto" { \set stanza = "3." \verseThree }
    >>

    \new Staff = tenor <<
      \new Voice = "tenor" {
        \global
        \tenorMusic
      }
      %\new Lyrics \lyricsto "tenor" { \set stanza = "2." \verseTwo }
      % Uncomment for verse 3 under tenor:
      \new Lyrics \lyricsto "tenor" { \set stanza = "4." \verseFour }
    >>

    \new Staff = bass <<
      \clef bass
      \new Voice = "bass" {
        \global
        \bassMusic
      }
      % Uncomment for lyrics under bass (less common):
      % \new Lyrics \lyricsto "bass" { \set stanza = "4." \verseFour }
    >>
  >>
}

% Score for printing
\score {
  % SINGLE TRANSPOSE for all voices - change songKey at top
  \transpose do \songKey {
    \musicContent
  }

  \layout {
    indent = 0\cm
    \context {
      \Score
      \remove "Bar_number_engraver"
      \override TimeSignature.break-visibility = ##(#f #t #t)
      \override NoteHead.font-size = #2
      startRepeatBarType = #";"
      endRepeatBarType = #";."
      doubleRepeatBarType = ";.;"
    }
  }
}

% Score for MIDI (reuses musicContent with octave doubling)
\score {
  \unfoldRepeats
  \transpose do \songKey {
    <<
      \musicContent
      % Octave doubling
      \new Staff { \global \transpose do do, { \trebleMusic } }
      \new Staff { \global \transpose do do, { \tenorMusic } }
    >>
  }

  \midi {
    \context {
      \Score
      tempoWholesPerMinute = #(ly:make-moment 100 4)
    }

    \context {
      \Staff
      midiInstrument = #"acoustic grand"
    }
  }
}

