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
% KEY TRANSPOSITION EXAMPLES (change on line 43):
% C major:  \transpose do do    (no change - default)
% G major:  \transpose do sol
% F major:  \transpose do fa
% D major:  \transpose do re
% Bb major: \transpose do sib
% Eb major: \transpose do mib
% A major:  \transpose do la
%
% MINOR KEYS (relative minor approach):
% F# minor: songKey = la    (writes in C major, transposes to A major)
% C# minor: songKey = mi    (writes in C major, transposes to E major)
% G# minor: songKey = si    (writes in C major, transposes to B major)
% D# minor: songKey = fis   (writes in C major, transposes to F# major)
% A minor:  songKey = do    (writes in C major, stays in C major)
% E minor:  songKey = sol   (writes in C major, transposes to G major)
% B minor:  songKey = re    (writes in C major, transposes to D major)
% G minor:  songKey = sib   (writes in C major, transposes to Bb major)
% D minor:  songKey = fa    (writes in C major, transposes to F major)

%%%%%% QUICK SETTINGS %%%%%%
songKey = sib % Change this to set key (see examples above)
songTitle = "Meet Again"
songMeter = "CM"
songComposer = "Ed Johnson-Williams, August & September 2025"

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
  \key do \major  % Don't remove the `\major` here – even for minor tunes
  %\minor        % Uncomment here for minor keys
  \aikenHeads     % or \sacredHarpHeads for 4-shape
  \numericTimeSignature
  \time 4/4       % Change as needed
  \defineBarLine ";" #'("" ";" " ")
  \defineBarLine ";." #'("" ";." ";.")
  \defineBarLine ".;" #'("" ".;" ".;")
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

  r2
  \repeat volta 2 {

    mi2^\markup { \tiny \musicglyph "scripts.segno" }
    mi4 sol la sol
    la mi la la
    sol4. sol8 mi4 re

  }

  \alternative {
    \volta 1 { mi2  }
    \volta 2,3 {  mi1^\markup { \tiny "Fine" }  }
  }

  r2 mi
  re4. mi8 sol4 mi
  sol4 sol mi4 la
  mi sol la sol la2^\markup { \tiny "D.S. al Fine" }


}

altoMusic = \relative do' {

  r2 \repeat volta 2 {

    la2^\markup { \tiny \musicglyph "scripts.segno" }
    la4 sol mi mi
    la la la la4
    sol4. sol8 la4 sol
  }

  \alternative {
    \volta 1 { mi2  }
    \volta 2,3 {  mi1^\markup { \tiny "Fine" }  }
  }


  r2 la
  sol4. la8 sol4 mi
  sol4 sol la la
  la sol mi re
  mi2^\markup { \tiny "D.S. al Fine" }
}

tenorMusic = \relative do' {

  r2 \repeat volta 2 {
    mi^\markup { \tiny \musicglyph "scripts.segno" }
    mi4mi8([do]) la4 do
    mi la mi4 mi
    re4. do8 la4 sol4
  }

  \alternative {
    \volta 1 { la2  }
    \volta 2,3 {  la1^\markup { \tiny "Fine" } }
  }

  r2 la
  sol4. la8 do4 mi
  mi sol8([mi8]) la4
  mi4
  la4 sol mi4 re mi2^\markup { \tiny "D.S. al Fine" }



  \bar "."
}

bassMusic = \relative do {

  r2 \repeat volta 2 {
    la2^\markup { \tiny \musicglyph "scripts.segno" }
    la4 do la sol
    do la la do
    sol4. sol8 la4 sol
  }

  \alternative {
    \volta 1 { la2  }
    \volta 2,3 {  la1^\markup { \tiny "Fine" } }
  }

  r2 la
  sol4. la8 sol4 la
  do do la4
  la4
  la do la sol la2^\markup { \tiny "D.S. al Fine" }


}

%%%%%%% LYRICS %%%%%%%%%

verseOneTop = \lyricmode {
  \tiny
  Our cheer -- ful voi -- ces let us raise
  And sing a part -- ing song;

  _

  For I must go and leave you all;
  It fills my heart with pain;

}

verseOneAA = \lyricmode {
  \tiny

  Al -- though I’m with you now, my friends,
  I can’t be with you ___ long.

}

verseOneB = \lyricmode {
  \tiny


}

verseOneAC = \lyricmode {
  \tiny
  Al -- though we part, per -- haps in tears,
  I hope we’ll meet a -- _ gain.
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
      \new Lyrics \lyricsto "treble" { \set stanza = "1." \verseOneTop }
      \new Lyrics \lyricsto "treble" {  \verseOneAA }
      \new Lyrics \lyricsto "treble" {  \verseOneB }
      \new Lyrics \lyricsto "treble" { \set stanza = "DS."   \verseOneAC }

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
      \new Lyrics \lyricsto "tenor" { \set stanza = "1." \verseOneTop }
      \new Lyrics \lyricsto "tenor" {  \verseOneAA }
      \new Lyrics \lyricsto "tenor" {  \verseOneB }
      \new Lyrics \lyricsto "tenor" { \set stanza = "DS."   \verseOneAC }
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
  \transpose do \songKey {
    <<
      \musicContent
      % Octave doubling for richer MIDI sound
      \new Staff {
        \set Staff.instrumentName = "Treble Low"

        \global \transpose do do, { \trebleMusic }
      }
      \new Staff {
        \set Staff.instrumentName = "Tenor Low"
        \global \transpose do do, { \tenorMusic }
      }
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

