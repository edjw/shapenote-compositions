\language "espanol"
%%%%%% Sacred Harp Template 0.4 %%%%%%

% A template for easy engraving of shapenote tunes in the style of the
% 1991 edition of the Sacred Harp.
%
% Leland Paul Kusmer – me@lelandpaul.com – February 2011
% Updated by Barry Parsons - September 2015
%
% For more information, see thypyramids.com/fasola


\version "2.24.0"
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
    "Bevois   "  \small{"8,7" }
  }% TITLE.  METER.
  %subtitle = \markup \italic \smaller
  %       "For Beth and Matthew"	% Subtitle, alternative title
  %subsubtitle = \markup \italic \tiny
  %        ""	%	Optional Bible verse
  arranger = \markup %\bold \tiny
  "Ed Johnson-Williams, 29 July 2025." % Composer
  meter = \markup {
    %\bold \tiny
    "A Major."
  } % Key signature.  Poet.
  tagline = ##f
  %\markup \tiny
  %	"" % Copyright info if applicable; leave blank otherwise.
}


global = {
  \key 	la								%KEY NOTE

  %Uncomment the mode, below:
  \major
  \aikenHeads    % Aiken Shapes

  % \sacredHarpHeads
  %\minor \sacredHarpHeadsMinor
  \numericTimeSignature
  \time 3/4				%TIME SIGNATURE as n/n
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

trebleA = \relative do' {
  % Treble A section

  % \repeat volta 2{	% Uncomment to repeat the A section
  % \bar ";"		% Uncomment if repeating

  % MUSIC GOES HERE
  mi2 mi4 |
  sol2 do,4 |
  sol'2 la4 |
  la2 la4 |
  sol2 mi4 |
  do2 do4 |
  mi2 do4 |
  sol'2. |
  do,2 sol'4 |
  sol2 do4 |
  do2 sol8[mi8]|
  mi2 do4 |
  sol'2 mi4 |
  sol2 do4 |
  sol2 mi4 |
  sol2.

  %  \break	%	Uncomment for line break after A section
  % }				% Uncomment if repeating

}

altoA = \relative do' {
  % Alto A section

  %  \repeat volta 2{	% Uncomment to repeat the A section
  %\bar ";"		% Uncomment if repeating

  % MUSIC GOES HERE
  sol2 la4 |
  do2 do4 |
  mi2 do4 |
  la2 do4 |
  do2 la4 |
  do2 mi4 |
  do2 do4 |
  si2. |
  do2  si4|
  do2  do4|
  mi do do |
  sol2 sol4 |
  sol2 la4|
  si2 do4 |
  re2 do4 |
  do2.




  % }				% Uncomment if repeating

}

tenorA = \relative do'' {
  % Tenor A section

  %  \repeat volta 2{	% Uncomment to repeat the A section
  % \bar ";"		% Uncomment if repeating

  % MUSIC GOES HERE


  sol,2 la4 |
  do2 mi4 |
  sol2 mi8[do8] |
  la2 do4 |
  sol2 do4|
  do2 la4 |
  do2 la'4 |
  sol2.|
  la2 sol4|


  sol4 (mi) do |
  sol (la) do |
  mi2 sol4 |
  do,2 la4 |
  sol2 do8[mi8] |
  sol2 do,4 |
  do2.\bar "|."


  % }				% Uncomment if repeating

}

bassA = \relative do {
  % Bass A section

  %  \repeat volta 2{	% Uncomment to repeat the A section
  %\bar ";"		% Uncomment if repeating

  % MUSIC GOES HERE

  do2 la4 |
  sol2 do,4 |
  do'2 la4 |
  do2 la4 |
  sol2 la4 |
  sol2 la4 |
  do2 do4 |
  sol2. |
  la2 sol4 |
  do,2 sol'4 |
  do2 do4 |
  do2 do4 |
  sol2 la4 |
  sol2 do,4 |
  sol'2 la4 |
  do,2.


  % 	}				% Uncomment if repeating

}

%%%%%%%% The B Section %%%%%%%%

trebleB = \relative do'' {
  % Treble B section

  % \repeat volta 2 {
  % Uncomment to repeat the B section

  % MUSIC GOES HERE


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
  May the grace of Christ our Sav -- ior,
  And the Fa -- ther’s bound -- less love,
  With the Ho -- ly Spi -- rit’s fa -- vor,
  Rest up -- on us from a -- bove.


}

trebleTextATwo = \lyricmode {
  \tiny
 % \set stanza = "2." % VERSE NUMBER (optional)
  % Lyrics to appear under treble A section

}

altoTextA = \lyricmode {
  \tiny
  \set stanza = "3." % VERSE NUMBER (optional)
  % Lyrics to appear under alto A section


}

tenorTextA = \lyricmode {
\tiny
  
    \set stanza = "2." % VERSE NUMBER (optional)

Thus may we a -- bide in un -- ion
With each o -- ther and the Lord;
And po -- ssess, in sweet co -- mmu -- nion,
Joys which earth can -- not af -- ford.
}




bassTextA = \lyricmode {
  \tiny
  \set stanza = "" % VERSE NUMBER (optional)
  % Lyrics to appear under bass A section

}

trebleTextB = \lyricmode {
  \tiny
  % Lyrics to appear under treble B section


}


altoTextB = \lyricmode {
  \tiny
  % Lyrics to appear under alto B section


}


tenorTextB = \lyricmode {
  \tiny


}



bassTextB = \lyricmode {
  \tiny
  % Lyrics to appear under bass B section



}

%%%%%%%%% LAYOUT %%%%%%%%%%%
% Score for printing (no octave doubling)
\score {
  \new ChoirStaff <<
    \new Staff = treble <<
      \new Voice = "treble" {
        \global
        \transpose do la {
          \trebleA
          \trebleB
        }
      }
      \new Lyrics \lyricsto "treble" { \trebleTextA \trebleTextB }
      \new Lyrics \lyricsto "treble" { \trebleTextATwo }
    >>

    \new Staff = alto <<
      \new Voice = "alto" {
        \global
        \transpose do la {
          \altoA
          \altoB
        }
      }
      \new Lyrics \lyricsto "alto" { \altoTextA }
    >>

    \new Staff = tenor <<
      \new Voice = "tenor" {
        \global
        \transpose do la {
          \tenorA
          \tenorB
        }
      }
      \new Lyrics \lyricsto "tenor" { \tenorTextA \tenorTextB }
    >>

    \new Staff = bass <<
      \clef bass
      \new Voice = "bass" {
        \global
        \transpose do la {
          \bassA
          \bassB
        }
      }
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
      startRepeatBarType = #";"
      endRepeatBarType = #";."
      doubleRepeatBarType = ";.;"
    }
  }
}

% Score for MIDI (with octave doubling)
\score {
  \new ChoirStaff <<
    \new Staff = treble {
      \global
      \transpose do la {
        \trebleA
        \trebleB
      }
    }

    \new Staff = alto {
      \global
      \transpose do la {
        \altoA
        \altoB
      }
    }

    \new Staff = tenor {
      \global
      \transpose do la {
        \tenorA
        \tenorB
      }
    }

    \new Staff = bass {
      \clef bass
      \global
      \transpose do la {
        \bassA
        \bassB
      }
    }

    \new Staff = trebleOctaveDown {
      \global
      \transpose do la {
        \transpose do do, { \trebleA \trebleB }
      }
    }

    \new Staff = tenorOctaveDown {
      \global
      \transpose do la {
        \transpose do do, { \tenorA \tenorB }
      }
    }
  >>
  
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