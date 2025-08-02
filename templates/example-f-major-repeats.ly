\language "espanol"
\version "2.24.0"
#(set-default-paper-size "a4landscape")

%%%%%% Example: F Major with Repeats %%%%%%
% Shows how to use the simplified template

%%%%%% QUICK SETTINGS %%%%%%
songKey = fa     % F major
songTitle = "EXAMPLE SONG"
songMeter = "8s.7s."
songComposer = "Traditional, arr. Ed Johnson-Williams 2025"

\paper {
  page-count = #1
  system-count = #2
  system-system-spacing = #'((basic-distance . 0) (padding . 6))
  top-margin = 0.5\in
}

\header {
  title = \markup{ \bold \smaller #songTitle "   " \small{#songMeter }}
  arranger = #songComposer
  meter = "F Major"  % Matches songKey = fa
  tagline = ##f
}

global = {
  \key do \major  % ALWAYS do major
  \aikenHeads
  \numericTimeSignature
  \time 4/4       % Common time
  \defineBarLine ";" #'("|" ";" " ")
  \defineBarLine ";." #'("|" ";." ";.")
  \defineBarLine ".;" #'("|" ".;" ".;")
  \defineBarLine ".." #'(".." ".." "..")
  \autoBeamOff
}

%%%%%%% MUSIC WITH REPEATS %%%%%%%%%
trebleMusic = \relative do'' {
  % === A SECTION (with repeat) ===
  \repeat volta 2 {
    \bar ";"  % Mid-bar repeat sign
    do4 do sol sol |
    la la sol2 |
    fa4 fa mi mi |
    re re do2 |
  }
  \break  % Line break after A section
  
  % === B SECTION ===
  sol4 sol fa fa |
  mi' mi re2 |
  sol4 sol fa fa |
  mi mi re2 |
  do1 |
  \bar ".."
}

altoMusic = \relative do' {
  % === A SECTION (with repeat) ===
  \repeat volta 2 {
    mi4 mi mi mi |
    fa fa mi2 |
    re4 re do do |
    si si do2 |
  }
  
  % === B SECTION ===
  mi4 mi re re |
  do do si2 |
  mi4 mi re re |
  do do si2 |
  do1 |
}

tenorMusic = \relative do' {
  % === A SECTION (with repeat) ===
  \repeat volta 2 {
    sol4 sol do do |
    do do do2 |
    la4 la sol sol |
    sol sol mi'2 |
  }
  
  % === B SECTION ===
  do4 do la la |
  sol sol sol2 |
  do4 do la la |
  sol sol sol2 |
  mi'1 |
}

bassMusic = \relative do {
  % === A SECTION (with repeat) ===
  \repeat volta 2 {
    do4 do do do |
    fa fa do2 |
    re4 re mi mi |
    sol sol do,2 |
  }
  
  % === B SECTION ===
  do4 do re re |
  mi mi sol2 |
  do,4 do re re |
  mi mi sol2 |
  do,1 |
}

%%%%%%% LYRICS %%%%%%%%%
verseOne = \lyricmode {
  \tiny
  Twin -- kle twin -- kle lit -- tle star,
  How I won -- der what you are.
  Up a -- bove the world so high,
  Like a dia -- mond in the sky.
}

verseTwo = \lyricmode {
  \tiny
  When the bla -- zing sun is gone,
  When he no -- thing shines up -- on,
  Then you show your lit -- tle light,
  Twin -- kle twin -- kle all the night.
}

%%%%%%% SCORE %%%%%%%%%
musicContent = {
  \new ChoirStaff <<
    \new Staff = treble <<
      \new Voice = "treble" {
        \global
        \trebleMusic
      }
      \new Lyrics \lyricsto "treble" { \set stanza = "1." \verseOne }
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
      \new Lyrics \lyricsto "tenor" { \set stanza = "2." \verseTwo }
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
  \transpose do \songKey {
    \musicContent
  }
  
  \layout {
    indent = 0\cm
    \context {
      \Score
      \remove "Bar_number_engraver"
      \omit VoltaBracket
      \override TimeSignature.break-visibility = ##(#f #t #t)
      \override NoteHead.font-size = #1
      startRepeatBarType = #";"
      endRepeatBarType = #";."
    }
  }
}

% Score for MIDI
\score {
  \transpose do \songKey {
    <<
      \musicContent
      \new Staff { \global \transpose do do, { \trebleMusic } }
      \new Staff { \global \transpose do do, { \tenorMusic } }
    >>
  }
  
  \midi {
    \context {
      \Score
      tempoWholesPerMinute = #(ly:make-moment 100 4)
    }
  }
}