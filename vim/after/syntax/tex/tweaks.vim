
syn region texComment start="\\begin{comment}" end="\\end{comment}"

hi link texMathSymbol Structure
hi link texMathDelim title

hi texGreek gui=bold cterm=bold ctermfg=170 guifg=#c792ea
au ColorScheme * hi texGreek gui=bold cterm=bold ctermfg=170 guifg=#c792ea

syn match texMathOper '\\frac' contained 

syn match texMathOper '\\\a\+\s*\[]' contained containedin=MathZoneW
syn match texMathOper '\\\a\+\s*\[\\[bB]igg\=]' contained containedin=MathZoneW

