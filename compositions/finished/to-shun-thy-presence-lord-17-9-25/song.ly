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
% C major:  \transpose do do
% G major:  \transpose do sol
% F major:  \transpose do fa
% D major:  \transpose do re
% A major:  \transpose do la
% E major:  \transpose do mi
% Bb major: \transpose do sib
% Eb major: \transpose do mib
% Ab major: \transpose do lab
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
songKey = la  % Change this to set key (see examples above)
songTitle = "To Shun Thy Presence, Lord"
songMeter = "CM"
songComposer = "Ed Johnson-Williams, 16 September 2025"

\paper {
  page-count = #1
  system-count = #2
  system-system-spacing = #'((basic-distance . 0) (padding . 6))
  top-margin = 0.5\in
}

\header {
  title = \markup{ \bold \smaller #songTitle "   " \small{#songMeter }}
  arranger = #songComposer
  meter = "F# Minor"  % Update this manually to match songKey
  tagline = ##f
}

global = {
  \key do \major
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
  r2 mi2 |
  mi4 mi mi la |
  sol mi sol mi8([re]) |
  mi4 mi do8([si]) do8([re]) |
  mi2. \bar ".|:"

  \repeat volta 2 {
    r4
    r1 |
    r2. la8([sol]) |
    la4 (sol mi) mi |
    la mi mi re |
    do sol' la2
    ~la2. mi8([sol]) |
  }
  \alternative {
    {
      % First ending
      la4. sol8 mi4 re |
      mi2.
    }
    {
      % Second ending
      la4. sol8 mi4 mi |
      mi1
      \bar ".."
    }
  }
}


altoMusic = \relative do' {
  r2 do2 |
  do4 do la do |
  do la sol la8([si]) |
  do4 la sol do8([si]) |
  la2. \bar ".|:"

  \repeat volta 2 {
    mi'8([re])
    do4 la do mi8([re]) |

    mi2 do |
    do4 (re do) mi |

    do do do re |

    mi re do2
    (mi2.) do8([re]) |
  }
  \alternative {
    {
      % First ending
      do4. re8 mi4 sol, |
      la2.
    }
    {
      % Second ending
      do4. re8 mi4 mi |
      la,1
      \bar ".."
    }
  }
}

tenorMusic = \relative do' {

  r2 mi2 |
  do4 la la do  |
  mi mi re mi8([sol]) |
  la4 la8([sol]) mi8([re]) do8([si]) |
  la2. \bar ".|:"

  \repeat volta 2 {
    r4
    r1 |

    r1 |
    r2.  la4 |
    do4 mi la4 sol |
    la sol mi2
    ~mi2.  mi8([re]) |
  }
  \alternative {
    {
      % First ending
      mi4. re8 do4 si |
      la2.
    }
    {
      % Second ending
      mi'4. re8 do4 la |
      la1
      \bar ".."
    }
  }
}

bassMusic = \relative do {
  r2 la2 |
  la4 la do la |
  do la sol la8([sol]) |
  la4 do sol la8([sol]) |
  la2. \bar ".|:"

  \repeat volta 2 {
    r4
    r2. la8([sol])|

    la4 do la la |
    mi sol la la |
    la do la sol |
    la sol la2
    ~la2. la8([sol])
  }
  \alternative {
    {
      % First ending
      la4. sol8 mi4 sol |
      la2.
    }
    {
      % Second ending
      la4. sol8 mi4 la |
      la1
      \bar ".."
    }
  }
}

%%%%%%% LYRICS %%%%%%%%%

trebleInitial = \lyricmode {
  \tiny
  In all my vast con -- cerns with Thee,
  In vain my soul would try
}

trebleRepeat = \lyricmode {
  \tiny
  To shun __  % The repeat section: To-shun(melisma)-To
}

trebleContinuation = \lyricmode {
  \tiny
  To shun Thy pres -- ence, Lord, or flee
  The

}

trebleEnd = \lyricmode {
  no -- tice of Thine eye.
}


altoInitial = \lyricmode {
  \tiny
  % In all my vast con -- cerns with Thee,
  % In vain my soul would try
  _ _ _ _ _ _ _ _
  _ _ _ _ _ _
}

altoRepeat = \lyricmode {
  \tiny
  To shun Thy pres -- ence, Lord, or flee
  _ _ _ _ _ _ _ _ _
  
}

altoContinuation = \lyricmode {
  \tiny
  % shun Thy pres -- ence, Lord, or flee
  % The
  _ _ _ _ _ _ _ _

}

altoEnd = \lyricmode {
  % no -- tice of Thine eye.
  _ _ _ _ _
}


tenorInitial = \lyricmode {
  \tiny
  In all my vast con -- cerns with Thee,
  In vain my soul would try
}

tenorRepeat = \lyricmode {
  \tiny
  % To shun Thy pres -- ence, Lord, or flee To  % The repeat section: To-shun(melisma)-To
}

tenorContinuation = \lyricmode {
  \tiny
  To shun Thy pres -- ence, Lord, or flee
  The

}

tenorEnd = \lyricmode {
  \tiny
  no -- tice of Thine eye.
  
}


bassInitial = \lyricmode {
  \tiny
  % In all my vast con -- cerns with Thee,
  % In vain my soul would try
  _ _ _ _ _ _ _ _
  _ _ _ _ _ _
}

bassRepeat = \lyricmode {
  \tiny
  To shun Thy pres -- ence, Lord, or flee
}

bassContinuation = \lyricmode {
  \tiny
  % To shun Thy pres -- ence, Lord, or flee
  % The
  _ _ _ _ _ _ _ _ _

}

bassEnd= \lyricmode {
  % no -- tice of Thine eye.
  _ _ _ _ _
}





trebleInitialTwo = \lyricmode {
  \tiny
  % Should I sup -- press my vi -- tal breath
  % To scape the wrath di -- vine,
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
}

trebleRepeatTwo = \lyricmode {
  \tiny
  Thy voice _ _
}

trebleContinuationTwo = \lyricmode {
  \tiny

  %voice would break the bars of death,
  %And
  _ _ _ _ _ _ _ _
}

trebleEndTwo = \lyricmode {
  % make the grave re -- sign.
  _ _ _ _ _
  
}


altoInitialTwo = \lyricmode {
  \tiny
  In all my vast con -- cerns with Thee,
  In vain my soul would try
}

altoRepeatTwo = \lyricmode {
  \tiny
  Thy voice would break the bars of death,  % The repeat section: To-shun(melisma)-To
}

altoContinuationTwo = \lyricmode {
  \tiny
  Thy voice would break the bars of death,
  And

}

altoEndTwo = \lyricmode {
  make the grave re -- sign.
}


tenorInitialTwo = \lyricmode {
  \tiny
   Should I sup -- press my vi -- tal breath
   To scape the wrath di -- vine,
}

tenorRepeatTwo = \lyricmode {
  \tiny
  Thy voice would break the bars of death, Thy
}

tenorContinuationTwo = \lyricmode {
  \tiny
  Thy voice would break the bars of death,
  And

}

tenorEndTwo = \lyricmode {
  make the grave re -- sign.
}



bassInitialTwo = \lyricmode {
  \tiny
  Should I sup -- press my vi -- tal breath
  To scape the wrath di -- vine,
}

bassRepeatTwo = \lyricmode {
  \tiny
  Thy voice would break the bars of death,__
  
}

bassContinuationTwo = \lyricmode {
  \tiny
   Thy voice would break the bars of death,
   And
  

}

bassEndTwo = \lyricmode {
  make the grave re -- sign.
  
}

% verseTwo = \lyricmode {
% \tiny
% My thoughts lie o -- pen to the Lord
% Be -- fore they're formed with -- in;
% And ere my lips pro -- nounce the word,
% He knows the sense I mean.

% }

% Additional verses if needed
% verseThree = \lyricmode {
%  \tiny
%  O won -- drous know -- ledge, deep and high,
%  Where can a crea -- ture hide?
%  With -- in Thy circ -- ling arms I lie,
%  En -- closed on every side.
% }

% verseFour = \lyricmode {
%  \tiny
% So let Thy grace sur -- round me still,
% And like a bul -- wark prove
% To guard my soul from eve -- ry ill,
%  Se -- cured by Sov -- ereign love.
% }

% probably this one if add another verse


%%%%%%% SCORE %%%%%%%%%
% Main music content (defined once, used for both print and MIDI)
musicContent = {
  \new ChoirStaff <<
    \new Staff = treble <<
      \new Voice = "treble" {
        \global
        \trebleMusic
      }
      \new Lyrics \lyricsto "treble" {
        \set stanza = "1."
        \trebleInitial      % Initial section
        \set stanza = "1."
        \trebleRepeat       % First time through repeat
         \set stanza = "1."
        \trebleContinuation % After repeat ends
        \trebleEnd
        \trebleEnd
      }

      \new Lyrics \lyricsto "treble" {
        
        \trebleInitialTwo      % Initial section
        \set stanza = "2."
        \trebleRepeatTwo       % First time through repeat
        \trebleContinuationTwo % After repeat ends
        \trebleEndTwo
        \trebleEndTwo
      }

    >>

    \new Staff = alto <<
      \new Voice = "alto" {
        \global
        \altoMusic
      }
      \new Lyrics \lyricsto "alto" {


       % \set stanza = "1."
        \altoInitial      % Initial section
        \set stanza = "1."
        \altoRepeat       % First time through repeat
        \altoContinuation % After repeat ends
        \altoEnd
        \altoEnd
      }

      \new Lyrics \lyricsto "alto" {

        \set stanza = "2."
        \altoInitialTwo      % Initial section
        \set stanza = "2."
        \altoRepeatTwo       % First time through repeat
        \set stanza = "2."
        \altoContinuationTwo % After repeat ends
        \altoEndTwo
        \altoEndTwo
      }
    >>

    \new Staff = tenor <<
      \new Voice = "tenor" {
        \global
        \tenorMusic
      }
      \new Lyrics \lyricsto "tenor" {


        \set stanza = "1."
         \tenorInitial      % Initial section
        \tenorRepeat       % First time through repeat
        \set stanza = "1."
        \tenorContinuation % After repeat ends
        \tenorEnd
       \tenorEnd
      }

      \new Lyrics \lyricsto "tenor" {


       % \set stanza = "2."
      %  \tenorInitialTwo      % Initial section
      %  \tenorContinuationTwo % After repeat ends
      %  \tenorEndTwo
       % \tenorEndTwo
      }
    >>

    \new Staff = bass <<
      \clef bass
      \new Voice = "bass" {
        \global
        \bassMusic
      }

      \new Lyrics \lyricsto "bass" {


        % \set stanza = "1."
        \bassInitial      % Initial section
        \set stanza = "1."
        \bassRepeat       % First time through repeat
        \bassContinuation % After repeat ends
        \bassEnd
        \bassEnd
      }

      \new Lyrics \lyricsto "bass" {


        \set stanza = "2."
        \bassInitialTwo      % Initial section
        \set stanza = "2."
        \bassRepeatTwo       % First time through repeat
        \set stanza = "2."
        \bassContinuationTwo % After repeat ends
        \bassEndTwo
        \bassEndTwo
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

