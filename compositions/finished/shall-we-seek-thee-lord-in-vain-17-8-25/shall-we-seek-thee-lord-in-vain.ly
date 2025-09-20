\language "espanol"
\version "2.24.0"
#(set-default-paper-size "a4landscape")

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
songTitle = "Shall We Seek Thee Lord in Vain"
songMeter = "7s"
songComposer = "Ed Johnson-Williams, August & September 2025"

\paper {
  page-count = #1
  system-count = #1
  system-system-spacing = #'((basic-distance . 0) (padding . 6))
  top-margin = 0.5\in
}

\header {
  title = \markup{ \bold \smaller #songTitle "   " \small{#songMeter }}
  arranger = #songComposer
  meter = "G Major, William Hammond"  % Update this manually to match songKey
  tagline = ##f
}

global = {
  \key do \major
  % \minor        % Uncomment for minor keys but leave the \major aboe
  \aikenHeads     % or \sacredHarpHeads for 4-shape
  \numericTimeSignature
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
% Write all music in C major (do, re, mi, fa, sol, la, si)
% The songKey transpose will handle the actual key
%
% HELPFUL PATTERNS:
% Repeats:     \repeat volta 2 { music }
% Mid-bar:     \bar ";"
% Line break:  \break (after A section)
% Slurs:       do8[re8] or do4(re4)
% Ties:        do4~ do4

trebleMusic = \relative do'' {
  % === A SECTION ===
  sol2. mi4 |
  sol2 do, |
  re2 mi2 |
  sol2. mi4 |
  do2 mi4 do |
  mi2 mi |
  re1 |
  do4 re4 mi2 |
  mi2 mi4 sol8([la]) |
  sol1 |
  do4 la sol2 |
  la2 sol4 sol4 |
  sol1|


  % === B SECTION ===
  % Add B section music here
  \bar ".."
}

altoMusic = \relative do' {
  % === A SECTION ===
  do2. do4 |
  re2 mi |
  re2 do4 (mi4) |
  do2. do4 |
  do2 la4 sol |
  do2 do |
  sol1 |
  do4 sol la2 |
  do2 mi4 re8[do] |
  sol1 |
  sol4 la do2 |
  do2 re4 re |
  do1

  % === B SECTION ===
  % Add B section music here
}

tenorMusic = \relative do' {
  % === A SECTION ===

  do2. mi4 |
  sol2 mi2 |
  sol2 sol4 (mi)
  do2. do4 |
  mi2 mi4 sol4 |
  sol2 la2 |
  sol1 |
  sol4 sol la2
  do2 sol8([la]) sol8([fa])
  mi1 |
  mi4 fa mi4(re) |
  do2 re4 re |
  do1

  % === B SECTION ===
  % Add B section music here
  \bar "|."
}

bassMusic = \relative do {
  % === A SECTION ===
  do2. do4 |
  sol2 do |
  sol2 sol4(do) |
  do2. la4 |
  la2 la4 do |
  do2 la |
  sol1 |
  sol4 sol la2 |
  do do8([la]) sol([la]) |
  do1 |
  do4 re do2 |
  la2 sol4 sol |
  do1

  % === B SECTION ===
  % Add B section music here
}

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  % Verse 1 lyrics
  Lord, we come be -- fore Thee now;
  At Thy feet we hum -- bly bow;
  O do not our suit dis -- dain!
  Shall we seek Thee, Lord, in vain?

}

verseTwo = \lyricmode {
  \tiny
  Com -- fort those who weep and mourn;
  Let the time of joy re -- turn;
  Those who are cast down lift up,
  Strong in faith, in love, and hope.

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
      %\new Lyrics \lyricsto "alto" { \set stanza = "1." \verseOne }
    >>

    \new Staff = tenor <<
      \new Voice = "tenor" {
        \global
        \tenorMusic
      }
      \new Lyrics \lyricsto "tenor" { \set stanza = "2." \verseTwo }

      % Uncomment for verse 3 under tenor:
      % \new Lyrics \lyricsto "tenor" { \set stanza = "3." \verseThree }
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
  \unfoldRepeats
  \transpose do \songKey {
    <<
      \musicContent
      % Octave doubling for richer MIDI sound
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

