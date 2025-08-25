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
songTitle = "Consensus"
songMeter = "8,7"
songComposer = "Ed Johnson-Williams, 12 August 2025"

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
  \time 4/4       % Change as needed
  \defineBarLine ";" #'("|" ";" " ")        % Start repeat barline - use: \bar ";"
  \defineBarLine ";." #'("|" ";." ";.")     % End repeat barline - use: \bar ";."
  \defineBarLine ".;" #'("|" ".;" ".;")     % Double bar into start repeat - use: \bar ".;"
  \defineBarLine ".." #'(".." ".." "..")    % Double barline for section endings - use: \bar ".."
  \defineBarLine ";.." #'(";.." ";.." ";..") % End repeat into double bar - use: \bar ";.."
  \defineBarLine ";.;" #'(";.;" ";.;" ";.;") % Back-to-back repeats - use: \bar ";.;"
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
%%%%%%% MUSIC %%%%%%%%%

trebleMusic = \relative do' {
    % === A SECTION ===
  \bar ";"
  \repeat volta 2 {
    r2 sol'4 sol |
    mi2 do2 |
    mi4 sol mi2 |  
    sol2 sol4 sol |
    do2. sol4 |
    do4 sol sol2
  }
  \mark \markup { \tiny \italic "Fine." }
  \bar ";."
    \break 

 
  % === B SECTION ===
  r2 sol4 mi |
  do2 sol' |
  do4 sol do,2 |
  mi2 do4 mi |
  sol2 do |
  do4 sol sol2
  \mark \markup { \italic \tiny "D.C." }
  \bar ".."
}

altoMusic = \relative do' {
  % === A SECTION ===
  \bar ";"
  \repeat volta 2 {
    r2 mi4 do |
    sol2 do2 |
    do4 mi do2 |  
    sol2 do4 mi |
    mi2. mi4 |
    mi4 do mi2
  }
  \mark \markup { \tiny \italic "Fine." }
  \bar ";."
    \break  
  % === B SECTION ===
  r2 do4 do |
  sol2 do |
  mi4 do do2 |
  mi do4 do |
  sol2 sol |
  do4 do mi2
  \mark \markup { \italic \tiny "D.C." }
  \bar ".."
}

tenorMusic = \relative do' {
  % === A SECTION ===
  \bar ";"
  \repeat volta 2 {
    r2 do4 do |
    mi2 sol2 |
    do4 do sol2  |
    mi2 do4 do |
    sol2. do4 |
    mi4 do do2
  }
  \mark \markup { \tiny \italic "Fine." }
  \bar ";."
      \break  

  % === B SECTION ===
  r2 mi4 sol |
  sol2 do, |
  mi4 sol mi2 |
  sol sol4 sol |
  do2 sol |
  do,4 do sol2
  \mark \markup { \italic \tiny "D.C." }
  \bar ".."
}

bassMusic = \relative do {
    % === A SECTION ===
  \bar ";"
  \repeat volta 2 {
    r2 do4 sol |
    do,2 sol'2 |
    do4 do sol2  
    do2 do4 sol |
    do,2. mi4 |
    sol4 sol do,2
  }
  \mark \markup { \tiny \italic "Fine." }
  \bar ";."
      \break  

  % === B SECTION ===
  r2 do'4 sol |
  do2 mi |
  do4 sol sol2 |
  do sol4 mi |
  do2 do |
  sol'4 sol <do do,>2
  \mark \markup { \italic \tiny "D.C." }
  \bar ".."
}


%%%%%%% LYRICS %%%%%%%%%
% A section - first verse
verseOneA = \lyricmode {
  \tiny
  Come, thou fount of ev -- 'ry bless -- ing,
  Tune my heart to sing Thy grace;
}

% A section - second verse (for repeat)
verseOneARepeat = \lyricmode {
  \tiny
  Streams of mer -- cy, nev -- er ceas -- ing,
  Call for songs of loud -- est praise.
}

% B section lyrics
verseOneB = \lyricmode {
  \tiny
  Sing me some me -- lo -- dious son -- net,
  Sung by flam -- ing tongues a -- bove;
}

% A section for D.C.
verseOneADC = \lyricmode {
  \tiny
  Praise the mount, I'm fixed up on it,
  Mount of Thy re -- deem -- ing love.
}

%%%%%%% SCORE %%%%%%%%%
musicContent = {
  \new ChoirStaff <<
    \new Staff = treble <<
      \new Voice = "treble" {
        \global
        \trebleMusic
      }
      % First verse - combines A (1st time) and B section
      \new Lyrics \lyricsto "treble" { 
        \set stanza = "1."
        \verseOneA 
        \verseOneB 
      }
      % Second verse - A section repeat text
      \new Lyrics \lyricsto "treble" { 
        \verseOneARepeat
      }
      % D.C. verse
      \new Lyrics \lyricsto "treble" { 
        \set stanza = "D.C."
        \verseOneADC
      }
    >>

    \new Staff = alto <<
      \new Voice = "alto" {
        \global
        \altoMusic
      }
    >>

    \new Staff = tenor <<
      \new Voice = "tenor" {
        \global
        \tenorMusic
      }
    >>

    \new Staff = bass <<
      \clef bass
      \new Voice = "bass" {
        \global
        \bassMusic
      }
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

