" amsmath.vim
"   Author: Charles E. Campbell
"   Date:   Oct 12, 2017
"   Version: 1b	ASTRO-ONLY
" ---------------------------------------------------------------------
let b:loaded_amsmath = "v1b"
let s:keepcpo        = &cpo
set cpo&vim

" ---------------------------------------------------------------------
"  AMS-Math Package Support: {{{1
call TexNewMathZone("Z","align",1)
call TexNewMathZone("Y","alignat",1)
call TexNewMathZone("X","equation",1)
call TexNewMathZone("W","flalign",1)
call TexNewMathZone("V","gather",1)
call TexNewMathZone("U","multline",1)
call TexNewMathZone("T","xalignat",1)
call TexNewMathZone("S","xxalignat",0)

syn match texBadMath		"\\end\s*{\s*\(align\|alignat\|equation\|flalign\|gather\|multline\|xalignat\|xxalignat\)\*\=\s*}"

" Amsmath [lr][vV]ert  (Holger Mitschke)
let s:texMathDelimList=[
     \ ['\\lvert'     , '|'] ,
     \ ['\\rvert'     , '|'] ,
     \ ['\\lVert'     , '‖'] ,
     \ ['\\rVert'     , '‖'] ,
     \ ]
for texmath in s:texMathDelimList
    execute "syntax match texMathDelim '\\\\[bB]igg\\=[lr]\\=".texmath[0]."' contained conceal cchar=".texmath[1]
endfor

" ---------------------------------------------------------------------
"  Restore: {{{1
let &cpo= s:keepcpo
unlet s:keepcpo
" vim: ts=4 fdm=marker

