% Parts are optional. A voice appears only when its *Music variable is
% defined in the song file; no separate showX flag is needed.
#(module-define! (current-module) 'hasTreble (defined? 'trebleMusic))
#(module-define! (current-module) 'hasAlto (defined? 'altoMusic))
#(module-define! (current-module) 'hasTenor (defined? 'tenorMusic))
#(module-define! (current-module) 'hasBass (defined? 'bassMusic))

% Empty defaults so the #{ ... #} staves below resolve even when a part
% is omitted (its *Music variable is never defined in the song file).
#(if (not (defined? 'trebleMusic))
     (module-define! (current-module) 'trebleMusic #{ #}))
#(if (not (defined? 'altoMusic))
     (module-define! (current-module) 'altoMusic #{ #}))
#(if (not (defined? 'tenorMusic))
     (module-define! (current-module) 'tenorMusic #{ #}))
#(if (not (defined? 'bassMusic))
     (module-define! (current-module) 'bassMusic #{ #}))

#(if (not (defined? 'trebleLyrics))
     (module-define! (current-module) 'trebleLyrics #{ #}))
#(if (not (defined? 'altoLyrics))
     (module-define! (current-module) 'altoLyrics #{ #}))
#(if (not (defined? 'tenorLyrics))
     (module-define! (current-module) 'tenorLyrics #{ #}))
#(if (not (defined? 'bassLyrics))
     (module-define! (current-module) 'bassLyrics #{ #}))

trebleStaff =
#(if hasTreble
     #{
       \new Staff = treble <<
         \new Voice = "treble" {
           \global
           \trebleMusic
         }
         \trebleLyrics
       >>
     #}
     #{ #})

altoStaff =
#(if hasAlto
     #{
       \new Staff = alto <<
         \new Voice = "alto" {
           \global
           \altoMusic
         }
         \altoLyrics
       >>
     #}
     #{ #})

tenorStaff =
#(if hasTenor
     #{
       \new Staff = tenor <<
         \new Voice = "tenor" {
           \global
           \tenorMusic
         }
         \tenorLyrics
       >>
     #}
     #{ #})

bassStaff =
#(if hasBass
     #{
       \new Staff = bass <<
         \clef bass
         \new Voice = "bass" {
           \global
           \bassMusic
         }
         \bassLyrics
       >>
     #}
     #{ #})

staffMusic = <<
  \trebleStaff
  \altoStaff
  \tenorStaff
  \bassStaff
>>
