\language "espanol"
\version "2.24.0"
#(set-default-paper-size "a4landscape")
\include "articulate.ly"


%%%%%% Sacred Harp Simplified Template v1.0 %%%%%%
% Ed Johnson-Williams - Fast typesetting from paper
%
% HOW TO USE THIS TEMPLATE:
% 1. Change songKey (line 39) to set the key - examples provided
% 2. Update song info (lines 40-42): title, meter, composer
% 3. Update meter = "G Major" (line 54) to show the key name
% 4. Enter music in the four voice sections (always in C major)
% 5. Add lyrics to verseOne and verseTwo sections

%
% QUICK TIPS:
% - Always write music as if in C major (do, re, mi, fa, sol, la, si)
% - The transpose happens automatically based on songKey
% - All parts sing same lyrics - placement under treble/tenor for good spacing
% - For minor keys: set songKey AND uncomment \minor in global
%
% KEY TRANSPOSITION EXAMPLES (change in ONE place only):
% C major:  \transpose do do    (no change - default)
% G major:  \transpose do sol
% F major:  \transpose do fa
% D major:  \transpose do re
% Bb major: \transpose do sib
% Eb major: \transpose do mib
% A major:  \transpose do la
%
% MINOR KEYS:
% A minor:  \transpose do la   (then use \minor in global)
% E minor:  \transpose do mi   (then use \minor in global)
% D minor:  \transpose do re   (then use \minor in global)
% C minor:  \transpose do do   (then use \minor in global)
% G minor:  \transpose do sol  (then use \minor in global)

%%%%%% QUICK SETTINGS %%%%%%
songKey = sol  % Change this to set key (see examples above)
songTitle = "Bolderwood"
songMeter = "CM"
songComposer = "Ed Johnson-Williams, 10 August 2025"

\paper {
  page-count = #1
  system-count = #1
  system-system-spacing = #'((basic-distance . 0) (padding . 6))
  top-margin = 0.5\in

}

\header {
  title = \markup{ \bold \smaller #songTitle "   " \small{#songMeter }}
  arranger = #songComposer
  meter = "G Major"  % Update this manually to match songKey
  tagline = ##f
}

global = {
  \key do \major
  % \minor        % Uncomment for minor keys but leave the \major aboe
  \aikenHeads     % or \sacredHarpHeads for 4-shape
  \numericTimeSignature
  \time 6/4       % Change as needed
  \defineBarLine ";" #'("|" ";" " ")
  \defineBarLine ";." #'("|" ";." ";.")
  \defineBarLine ".;" #'("|" ".;" ".;")
  \defineBarLine ".." #'(".." ".." "..")
  \defineBarLine ";.." #'(";.." ";.." ";..")
  \defineBarLine ";.;" #'(";.;" ";.;" ";.;")
  \autoBeamOff
}

%%%%%%% MUSIC %%%%%%%%%
% Write all music in C major (do, re, mi, fa, sol, la, si)
% The songKey transpose will handle the actual key
%
% HELPFUL PATTERNS:
% Repeats:     \repeat volta 2 { music }
% Mid-bar:     \bar ";"
% Line break:  \break (after A section)
% Slurs:       do8[re8] or do4(re4)
% Ties:        do4~ do4

trebleMusic = \relative do' {
  % === A SECTION ===

  r1 r4 mi4 |

  sol2 mi4 do2 sol'4 |
  sol2 sol4 mi2\fermata do4 |
  re2 do4 sol'2 mi4 | \break
  re2. r2 do4|
  mi2 sol4 do2 si4 |
  do2 la4 sol2\fermata sol4  | \bar ".|:"

  \repeat volta 2 {
    do,4(re) mi sol2 mi4 |
  }
  \alternative {
    { sol2.(mi2)\fermata sol4 | }
    { mi1. | }
  }




  % === B SECTION ===
  % Add B section music here
  \bar ".."
}

altoMusic = \relative do' {
  % === A SECTION ===

  r1 r4 sol4 |

  do2 do4 sol2 sol4 |
  sol2 do4 do2\fermata do4 |
  si2 la4 sol2 do4 |
  si2. r2 do4 |
  do2 do4 sol2 sol4 |
  do2 la4 sol2\fermata do4 | \bar ".|:"

  \repeat volta 2 {
    do4(si) do do2 do4 |
  }
  \alternative {
    { sol2.(do2)\fermata sol4 | }
    { sol1. | }
  }



  % === B SECTION ===
  % Add B section music here
}

tenorMusic = \relative do' {
  % === A SECTION ===
  r1 r4 sol4 |
  do2 la4 sol2 do4 |
  mi2 sol4 do,2\fermata la4 |
  sol2 do4 mi2 sol4 |
  sol2. r2 sol4 |
  la2 sol4 mi2 sol4 |
  sol2 mi4 re2\fermata mi4 | \bar ".|:"

  \repeat volta 2 {
    mi4(re) do sol2 la4 |
  }
  \alternative {
    { do2.(mi2)\fermata mi4 | }
    { do1. | }
  }

  % === B SECTION ===
  % Add B section music here
  \bar "|."
}

bassMusic = \relative do {
  % === A SECTION ===
  r1 r4 do4 |
  sol2 la4 do2 mi4|
  do2 sol4 sol2\fermata la4 |
  sol2 la4 do2 do4 |
  sol2. r2 sol4 |
  la2 do4 do2 sol4 |
  do2 la4 sol2\fermata do,4 | \bar ".|:"

  \repeat volta 2 {
    sol'2 sol4 do2 do4 |
  }
  \alternative {
    { do2.(sol2)\fermata do,4 | }
    { <do do'>1. | }
  }




  % === B SECTION ===
  % Add B section music here
}

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  % Verse 1 lyrics
  Now shall my in -- ward joys a -- rise,
  And burst in -- to a song;
  Al -- migh -- ty love in -- spires my heart,
  And plea -- sure tunes my tongue.
  And
  tongue.

}

verseTwo = \lyricmode {
  \tiny
  % Verse 2 lyrics
  God, on His thir -- sty Zi -- on’s hill,
  Some mer -- cy drops has thrown;
  And so -- lemn oaths have bound His love
  To show’r sal -- va -- tion down.
  To
  down.


}

% Additional verses if needed
verseThree = \lyricmode {
  \tiny
  % Verse 3 lyrics if needed
  Why do we then in -- dulge our fears,
  Sus -- pic -- ions and com -- plaints?
  Is He a God, and shall His grace
  Grow wea -- ry of His saints?
  Grow
  saints?
}

verseFour = \lyricmode {
  \tiny
  % Verse 4 lyrics if needed
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
      % \new Lyrics \lyricsto "treble" { \set stanza = "3." \verseThree }
    >>

    \new Staff = alto <<
      \new Voice = "alto" {
        \global
        \altoMusic
      }
      % Uncomment for verse 2 under alto (common pattern):
      \new Lyrics \lyricsto "alto" { \set stanza = "2." \verseTwo }
    >>

    \new Staff = tenor <<
      \new Voice = "tenor" {
        \global
        \tenorMusic
      }
      %\new Lyrics \lyricsto "tenor" { \set stanza = "2." \verseTwo }
      % Uncomment for verse 3 under tenor:
      \new Lyrics \lyricsto "tenor" { \set stanza = "3." \verseThree }
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
      \override NoteHead.font-size = #1
      startRepeatBarType = #";"
      endRepeatBarType = #";."
      doubleRepeatBarType = ";.;"
    }
  }
}

% Score for MIDI (reuses musicContent with octave doubling)
\score {
  \articulate \unfoldRepeats {
    \transpose do \songKey {
      <<
        \musicContent
        % Octave doubling for richer MIDI sound
        \new Staff { \global \transpose do do, { \trebleMusic } }
        \new Staff { \global \transpose do do, { \tenorMusic } }
      >>
    }
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


