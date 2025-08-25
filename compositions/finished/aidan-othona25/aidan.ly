\language "espanol"
%%%%%% Sacred Harp Template 0.4 %%%%%%

% A template for easy engraving of shapenote tunes in the style of the
% 1991 edition of the Sacred Harp.
%
% Leland Paul Kusmer – me@lelandpaul.com – February 2011
% Updated by Barry Parsons - September 2015
%
% For more information, see thypyramids.com/fasola


\version "2.16.00"
#(set-default-paper-size "a4landscape")

% \include "../../../partials/old-style-clef.ly"

\paper {

  page-count = #1 % Limit the page size and system count here.
  system-count = #2
  %ragged-last = ##t
  %ragged-bottom = ##t
  system-system-spacing = #'((basic-distance . 0) (padding . 6))
  top-margin = 0.5\in



}

\header {
  title = \markup{
    \bold \smaller
    "Aidan   "  \small{"11s" }
  }% TITLE.  METER.
  %subtitle = \markup \italic \smaller
  %       "For Beth and Matthew"	% Subtitle, alternative title
  %subsubtitle = \markup \italic \tiny
  %        ""	%	Optional Bible verse
  arranger = \markup %\bold \tiny
  "Ed Johnson-Williams, 25 July 2025." % Composer
  meter = \markup {
    %\bold \tiny
    "C Major."
  } % Key signature.  Poet.
  tagline = ##f
  %\markup \tiny
  %	"" % Copyright info if applicable; leave blank otherwise.
}


global = {
  \key 	do								%KEY NOTE

  %Uncomment the mode, below:
  \major
  \aikenHeads    % Aiken Shapes

  % \sacredHarpHeads
  %\minor \sacredHarpHeadsMinor
  \numericTimeSignature
  \time 4/4				%TIME SIGNATURE as n/n
  \defineBarLine ";" #'("|" ";" " ")
  \defineBarLine ";." #'("|" ";." ";.")
  \defineBarLine ".;" #'("|" ".;" ".;")
  \defineBarLine ".." #'(".." ".." "..")
  \defineBarLine ";.." #'(";.." ";.." ";..")
  \defineBarLine ";.;" #'(";.;" ";.;" ";.;")
  \autoBeamOff
  \override Score.RehearsalMark.self-alignment-X = #LEFT






}

%%%%%%% MUSIC %%%%%%%%%
% Music for the A and B sections; uncomment marked lines if repeating

%%%%%%% The A Section %%%%%%%%

trebleA = \relative do'' {
  % Treble A section

  % \repeat volta 2{	% Uncomment to repeat the A section
  % \bar ";"		% Uncomment if repeating

  % MUSIC GOES HERE
  r2

  mi2 |
  do mi4 mi |
  mi2 do4 la |
  sol2 la4 do |
  mi2

  sol |
  mi do4 mi |
  sol2 sol4 mi |
  do2 do4 la |
  do2.



  %  \break	%	Uncomment for line break after A section
  % }				% Uncomment if repeating

}

altoA = \relative do' {
  % Alto A section

  %  \repeat volta 2{	% Uncomment to repeat the A section
  %\bar ";"		% Uncomment if repeating

  % MUSIC GOES HERE
  r2 mi |
  sol2 sol4 mi |
  do2 mi4 sol |
  do,2 do4 mi |
  sol2

  do, |
  sol' la4 la |
  sol2 mi4 sol |
  sol2 la4 la |
  sol2.


  % }				% Uncomment if repeating

}

tenorA = \relative do'' {
  % Tenor A section

  %  \repeat volta 2{	% Uncomment to repeat the A section
  % \bar ";"		% Uncomment if repeating

  % MUSIC GOES HERE
  r2

  sol2 |
  do do8[ si] la4 |
  do2 do4 re |
  mi2 fa4 do |
  do2

  sol |
  do do8[ si] la4 |
  do2 do4 mi |
  mi2 fa4 fa |
  do2.


  % }				% Uncomment if repeating

}

bassA = \relative do' {
  % Bass A section

  %  \repeat volta 2{	% Uncomment to repeat the A section
  %\bar ";"		% Uncomment if repeating

  % MUSIC GOES HERE
  r2

  do, |
  do do'4 la |
  sol2 do,4 re |
  mi2 fa4 la |
  sol2

  do |
  do,2 do'4 la |
  sol2 sol4 do, |
  do2 fa4 fa |
  do2.

  % 	}				% Uncomment if repeating

}

%%%%%%%% The B Section %%%%%%%%

trebleB = \relative do'' {
  % Treble B section

  % \repeat volta 2 {
  % Uncomment to repeat the B section

  % MUSIC GOES HERE
  do4 |
  do2 mi4 mi |
  do2 do4 mi |
  mi2 do4 mi |
  sol2

  mi4( sol) |
  sol2 mi4 do |
  do2 do4 si |
  do2 si4 si |
  do1 |

  \bar ".."

  % }	% Uncomment if repeating

  %{
   \alternative {
    % Uncomment if repeating
     { \set Timing.measureLength = #(ly:make-moment 3/4) \mark \markup \bold \tiny "1." mi2. \bar ";." }	% Uncomment if repeating
     { \set Timing.measureLength = #(ly:make-moment 6/4) \mark \markup \bold \tiny "2." mi1. \bar ".." }	% Uncomment if repeating
  }				% Uncomment if repeating
  %}

  %  \bar ";.."

}

altoB = \relative do'' {
  % Alto B section
  % \repeat volta 2 {
  % Uncomment to repeat the B section

  % MUSIC GOES HERE
  sol4 |
  mi2 sol4 sol |
  la2 sol4 la |
  sol2 mi4 do |
  do2

  do4( mi) |
  mi2 sol4 la |
  sol2 mi4 sol |
  sol2 sol4 sol |
  sol1 |

  %  }	% Uncomment if repeating
  %{
  \alternative {
    % Uncomment if repeating
   { \set Timing.measureLength = #(ly:make-moment 3/4) sol2. \bar ";." }	% Uncomment if repeating
    { \set Timing.measureLength = #(ly:make-moment 6/4) sol1.  }	% Uncomment if repeating
  }	% Uncomment if repeating
  %}

}



tenorB = \relative do'' {
  % Tenor B section

  % \repeat volta 2{
  % Uncomment to repeat the B section

  % MUSIC GOES HERE
  % \bar ".;"
  mi4 |
  sol2 sol4 mi |
  mi2 do4 la |
  sol2 do4 do8[ re] |
  mi2

  do2 |
  do2 do4 la |
  sol2 do4 re |
  mi2 re4 re |
  do1 |

  % }	% Uncomment if repeating
  % \alternative {
  %   % Uncomment if repeating
  %   { \set Timing.measureLength = #(ly:make-moment 5/4) do2.~ do2 \bar ";." }
  %   { \set Timing.measureLength = #(ly:make-moment 6/4) do1.  }
  % }	% Uncomment if repeating

}




bassB = \relative do' {
  % Bass B section

  % \repeat volta 2 {
  % Uncomment to repeat the B section

  % MUSIC GOES HERE
  do4 |
  sol2 do4 do |
  la2 sol4 la |
  <do do,>2 sol4 mi |
  sol2

  la2 |
  <do do,>2 sol4 mi |
  sol2 do4 sol |
  do,2 sol'4 sol |
  do,1 |


  % }	% Uncomment if repeating

  %{
     \alternative {
    % Uncomment if repeating
     { \set Timing.measureLength = #(ly:make-moment 3/4) la4 do2 \bar ";." }	% Uncomment if repeating
     { \set Timing.measureLength = #(ly:make-moment 6/4) la4 do2~ do2.  }	% Uncomment if repeating
  }	% Uncomment if repeating
  %}

}


%%%%%%% TEXT %%%%%%%%%

% Remember to uncomment \addlyrics, below, for only the text that is being used.

%%%%%%% The A Section %%%%%%%%

trebleTextA = \lyricmode {
  \tiny
  \set stanza = "1." % VERSE NUMBER (optional)
  % Lyrics to appear under treble A section
  I dreamt I was out, to the east cast mine eye,
  The at -- mos -- phere calm and se -- rene was the sky;

}

trebleTextATwo = \lyricmode {
  \tiny
  \set stanza = "2." % VERSE NUMBER (optional)
  % Lyrics to appear under treble A section
  A pil -- lar of cloud in the east did ap -- pear,
  A throne in the midst on which Je -- sus sat fair,
  Who co -- ming a -- long the e -- ther -- ’al bright plain
  And soar -- ing a -- loft till the midst He did gain.
}

altoTextA = \lyricmode {
  \tiny
  \set stanza = "3." % VERSE NUMBER (optional)
  % Lyrics to appear under alto A section

  The next I heard Je -- sus say “Come you up here;”
  Then all the blest nat -- ions a -- rose with -- out fear,
  And quit -- ting the globe with great plea -- sure did sing
  A song that was ne -- ver be -- fore tuned to string.
}

tenorTextA = \lyricmode {
  \tiny
  \set stanza = "4." % VERSE NUMBER (optional)
  % Lyrics to appear under tenor A section


  Then, in the sweet tran -- sport, my feet left the ground
  With -- out a -- ny mo -- tion of bo -- dy or sound;
  My joys were un -- speak -- ab -- ly full of de -- light;
  So loud was the mus -- ic it o’er -- came me quite.
}



bassTextA = \lyricmode {
  \tiny
  \set stanza = "" % VERSE NUMBER (optional)
  % Lyrics to appear under bass A section

}

trebleTextB = \lyricmode {
  \tiny
  % Lyrics to appear under treble B section
  So calm, still and aw -- ful, tre -- men -- dous the sight;
  I thought the last judge -- ment was dawn -- ing to light.

}


altoTextB = \lyricmode {
  \tiny
  % Lyrics to appear under alto B section


}


tenorTextB = \lyricmode {
  \tiny
  % Lyrics to appear under tenor B section



}



bassTextB = \lyricmode {
  \tiny
  % Lyrics to appear under bass B section



}


%%%%%%%%% LAYOUT %%%%%%%%%%%
% The only modification necessary below here: Uncomment text that you'd like to add.

\score {
  \new ChoirStaff <<

    \new Staff = treble <<
      \new Voice = "treble" {
        \global
        % \transpose do fa {	% Uncomment if transposing. x = original key; y = target key
        \trebleA
        \trebleB
        % }	%  Uncomment if transposing
      }
      \new Lyrics  \lyricsto "treble" { \trebleTextA \trebleTextB }
      \new Lyrics  \lyricsto "treble" { \trebleTextATwo }
      %\new Lyrics  \lyricsto "treble" { \repeat unfold 28 { \skip 1 } \trebleTextB }
      %\new Lyrics \lyricsto "treble" { \repeat unfold NN { \skip 1 } \trebleTextBtwo }				% Uncomment to add text
    >>

    \new Staff = alto <<
      \new Voice = "alto" {
        \global
        % \transpose do fa {	% Uncomment if transposing. x = original key; y = target key
        \altoA
        \altoB
        % }
      }
      \new Lyrics  \lyricsto "alto" { \altoTextA }
      %\new Lyrics \lyricsto "alto" { \repeat unfold NN { \skip 1 } \altoTextBtwo }
    >>

    \new Staff = tenor <<
      \new Voice = "tenor" {
        \global
        % \transpose do fa {	% Uncomment if transposing. x = original key; y = target key
        \tenorA
        \tenorB
        % }	% Uncomment if transposing
      }
      \new Lyrics  \lyricsto "tenor" { \tenorTextA \tenorTextB }
      % \new Lyrics  \lyricsto "tenor" { \repeat unfold 28 { \skip 1 } \tenorTextB }
      %\new Lyrics \lyricsto "tenor" { \repeat unfold NN { \skip 1 } \tenorTextBtwo }
    >>

    \new Staff = bass <<
      \clef bass
      \new Voice = "bass" {
        \global
        % \transpose do fa {	% Uncomment if transposing. x = original key; y = target key
        \bassA
        \bassB
        % }	% Uncomment if transposing
      }
      % \new Lyrics  \lyricsto "bass" { \bassTextA }
      % \new Lyrics  \lyricsto "bass" { \repeat unfold 28 { \skip 1 } \bassTextB }
      %\new Lyrics \lyricsto "bass" { \repeat unfold NN { \skip 1 } \bassTextBtwo }
    >>
  >>
  \layout {
    indent = 0\cm

    \context {
      \Score
      \remove "Bar_number_engraver"
      \omit VoltaBracket
      \override RehearsalMark.self-alignment-X = #LEFT
      \override TimeSignature.break-visibility = ##(#f #t #t)
      \override NoteHead.font-size = #1

      startRepeatBarType = #";"	%	Uncomment if repeats start mid-bar
      %	startRepeatBarType = #".;"	%	Uncomment if repeats start on barline
      endRepeatBarType = #";."
      doubleRepeatBarType = ";.;"

    }


  }
  \midi {
    \context {
      \Score
      tempoWholesPerMinute = #(ly:make-moment 96 2) %Sets the metronome speed and value of the beat
    }
  }
}