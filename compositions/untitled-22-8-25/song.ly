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
% G minor:  \transpose do sib  (then use \minor in global)

%%%%%% QUICK SETTINGS %%%%%%
songKey = sib  % Change this to set key (see examples above)
songTitle = "SONG TITLE"
songMeter = "8,7s"
songComposer = "Ed Johnson-Williams, 22 August 2025"

\paper {
  page-count = #1
  system-count = #2
  system-system-spacing = #'((basic-distance . 0) (padding . 6))
  top-margin = 0.5\in
}

\header {
  title = \markup{ \bold \smaller #songTitle "   " \small{#songMeter }}
  arranger = #songComposer
  meter = "G Minor"  % Update this manually to match songKey
  tagline = ##f
}

global = {
  \key do \major
  %\minor        % Uncomment for minor keys but leave the \major aboe
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

trebleMusic = \relative do' {
  % === A SECTION ===

  % === B SECTION ===
  % Add B section music here
  \bar ".."
}

altoMusic = \relative do' {
  % === A SECTION ===


  % === B SECTION ===
  % Add B section music here
}

tenorMusic = \relative do' {
  % === A SECTION ===
  \bar ";"
  \repeat volta 2 {
    la2 do4 re |
    mi2 re |
    do4 sol la2 |
    si2 do8[si] la4 |
    do si la4.(sol8) |
    la1 |
  }

  r2 sol |
  la4 do8[re] mi2 |
  re mi8[re] mi4 |
  sol2 mi |
  mi4 sol la sol |
  sol2 mi |
  re do4 re |
  mi2 re |
  do4 sol la2 |
  si do4 re |
  mi re do2
  (sol) la |


  % === B SECTION ===
  % Add B section music here
  \bar "|."
}

bassMusic = \relative do {
  % === A SECTION ===
  \bar ";"
  \repeat volta 2 {
    la2 la4 sol |
    la2 sol |
    mi4 re mi2 |
    sol2 do4 la4 |
    la sol mi4.(sol8) |
    la1 |
  }

  r2 sol |
  do4 la la2 |
  si la4 la |
  sol2 la |
  la4 sol mi sol |
  <do sol>2 la |
  sol sol4 sol |
  la2 sol |
  la4 do la2 |
  sol la4 sol |
  mi sol la2
  (<do sol>) la |

  % === B SECTION ===
  % Add B section music here
}

%%%%%%% LYRICS %%%%%%%%%

verseOne = \lyricmode {
  \tiny
  % Verse 1 lyrics
  To God we’ll cry and hell de -- fy,
  Though Sa -- tan roar like thun -- der;

  %repeated text is here

  While mu -- sic sweet makes some re -- treat,
  Our Je -- sus still draws nigh -- er;
  His pre -- cious name lights up the flame
  That sets our souls on fi -- re.

}

verseOneARepeat = \lyricmode {
  \tiny
  % Verse 1 repeat lyrics
  The voice of pra’yr makes sin -- ners stare,
  While fill’d with joy and won -- der.
}

verseTwo = \lyricmode {
  \tiny
  % Verse 2 lyrics

}

% Additional verses if needed
verseThree = \lyricmode {
  \tiny
  % Verse 3 lyrics if needed
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
      % \new Lyrics \lyricsto "alto" { \set stanza = "2." \verseTwo }
    >>

    \new Staff = tenor <<
      \new Voice = "tenor" {
        \global
        \tenorMusic
      }
      \new Lyrics \lyricsto "tenor" { \set stanza = "1." \verseOne }

      % Repeat lyrics (for the repeated A section)
      \new Lyrics \lyricsto "tenor" {
        \set stanza = ""
        \verseOneARepeat
      }



      % Uncomment for verse 3 under tenor:
      \new Lyrics \lyricsto "tenor" {
        \set stanza = "3." \verseThree
      }
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


% While grace divine in others shine,
% With each we are delighted;
% With them we crowd and sing so loud,
% Poor sinners are affrighted.
% The sweetest joys our pow’rs employ,
% To see the cause advancing,
% Though some go off, and boldly scoff,
% And say that we are dancing.
%
% But let them scoff, we still will cry
% To God for their salvation:
% O God of love, send from above,
% And save them from damnation.
% Thy Spirit send their hearts to bend,
% Arrest them by thy thunder!
% Let sweetest songs employ their tongues;
% Fill them with joy and wonder.

