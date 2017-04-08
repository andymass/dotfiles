" ────────────────────────────────────────────────────────────────────────────
"       ___              __     _                _
"      /   |  ____  ____/ /_  _( )_____   _   __(_)___ ___  __________
"     / /| | / __ \/ __  / / / /// ___/  | | / / / __ `__ \/ ___/ ___/
"    / ___ |/ / / / /_/ / /_/ / (__  )   | |/ / / / / / / / /  / /__
"   /_/  |_/_/ /_/\__,_/\__, / /____/    |___/_/_/ /_/ /_/_/   \___/
"                      /____/
" ────────────────────────────────────────────────────────────────────────────

" basic options
set ts=4
set sw=4
set textwidth=78
set wm=2
set cc=+1
set expandtab
set bs=indent
set ffs=unix,dos

set noswapfile
set virtualedit=block

set nu
set hlsearch
set spell
set spellsuggest=best,5
set thesaurus=~/scripts/mthesaur.txt

set formatoptions+=jl

" changes the behavior of <cr> in two ways:
"   - <cr> now accepts an autocomplete
"   - <cr> starts a new undo sequence
"   xxx conflicts with ycm
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" set fillchars=vert:║,fold:-
set fillchars=vert:\|,fold:\
set listchars=trail:·

set laststatus=2
set scrolloff=2
set showbreak=\ →\ 
set wildmenu
set suffixes+=.pdf,.synctex

set splitbelow
set splitright
set switchbuf=useopen,split
set previewheight=18

set nomodeline
set modelines=0
set infercase

set nosol

if $SSH_CLIENT != ''
    set clipboard=exclude:.*
endif

autocmd FileType qf setl wrap

"
set path+=~/mlpackages
" TODO: matlab don't spell comments?

" use ag for grepping
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor\ --smart-case\ --column\ --follow\ -C0
    set grepformat=%f:%l:%c:%m
    command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
endif

nnoremap <leader>G :execute "Ag " . expand("<cword>") <cr>
nnoremap <leader>g :Ag 

" pathogen; install plugins located in ~/.vim/bundle
execute pathogen#infect()
filetype plugin indent on
syn on

" matchit standard vim macro
runtime macros/matchit.vim

" colorscheme setup
set background=dark
if !$NO_COLORSCRIPT && &term !~ 'putty'
"   setting shell path is not necessary
"    let g:base16_shell_path='~/scripts/base16-shell/'
    let base16colorspace=256
endif
colorscheme base16-eighties

" jump to the last position in file when reopening
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif
endif

" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" vim
if !has("gui_running")
    hi Normal ctermbg=none
end
set shortmess+=I

" autocmd FileType tex :iabbr <buffer> ... \dots

let g:UltiSnipsExpandTrigger='<c-y>'
let g:UltiSnipsJumpForwardTrigger='<c-t>'
let g:UltiSnipsJumpBackwardTrigger='<c-d>'
" let g:UltiSnipsListSnippets

" let g:vimtex_imaps_snippet_engine = 'ultisnips'
    " \ 'leader' : 0, 
  
" call vimtex#imaps#add_map({
"     \ 'lhs' : 'test',
"     \ 'rhs' : '\tested',
"     \ 'wrapper' : 'vimtex#imaps#wrap_trivial'
" \})
"

" control space
" let g:vimtex_imaps_leader = "<c-@>

let g:vimtex_imaps_leader = '`'

" call vimtex#imaps#add_map({
"     \ 'lhs' : '{',
"     \ 'rhs' : '{}',
"     \ 'wrapper' : 'vimtex#imaps#wrap_trivial'
" \})

" function! vimtex#imaps#wrap_math(lhs, rhs) " {{{1
"       return s:is_math() ? a:rhs : a:lhs
"   endfunction

command! ReloadVimrc :source $MYVIMRC 

"" %! TeX program=XeLaTeX
" function! DetectTexProgram()

"   let l:pat = '^\c\s*%\s*!\?\s*tex\s\+\(TS-\)\?program\s*=\s*\zs.*\ze\s*$'
"   let l:engine_list = {
"       \ 'pdflatex'         : '',
"       \ 'lualatex'         : '-lualatex',
"       \ 'xelatex'          : '-xelatex',
"       \ 'context (luatex)' : '-pdflatex=context',
"       \ 'context (pdftex)' : '-pdflatex=''texexec --xtx''',
"       \ 'context (xetex)'  : '-pdflatex=texexec',
"       \  }

"       " \ 'pdftex'           : 'pdftex',
"       " \ 'luatex'           : 'luatex',
"       " \ 'xetex'            : 'xetex',

"   for l:line in getline(1, 5)
"     let l:engine = matchstr(l:line, l:pat)
"     if len(l:engine) > 0
"       if has_key(l:engine_list, tolower(l:engine)) > 0
"         let l:opt = ' '.l:engine_list[tolower(l:engine)].' '
"         let g:vimtex_latexmk_options .= l:opt
"       else
"         echoerr 'Unknown engine '.l:engine
"       endif
"     endif
"   endfor

" endfunction

" autocmd FileType tex call DetectTexProgram()


if has("autocmd") && exists("+omnifunc")
    autocmd Filetype *
        \   if &omnifunc == "" |
        \       setlocal omnifunc=syntaxcomplete#Complete |
        \   endif
endif


" ────────────────────────────────────────────────────────────────────────────
"              __            _                      __  _                     
"       ____  / /_  ______ _(_)___     ____  ____  / /_(_)___  ____  _____    
"      / __ \/ / / / / __ `/ / __ \   / __ \/ __ \/ __/ / __ \/ __ \/ ___/    
"     / /_/ / / /_/ / /_/ / / / / /  / /_/ / /_/ / /_/ / /_/ / / / (__  )     
"    / .___/_/\__,_/\__, /_/_/ /_/   \____/ .___/\__/_/\____/_/ /_/____/      
"   /_/            /____/                /_/                                  
" ────────────────────────────────────────────────────────────────────────────

" airline
let g:airline_mode_map = {
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'REPLACE',
      \ 'v'  : 'V',
      \ 'V'  : 'V-LINE',
      \ 'c'  : 'CMD',
      \ '' : 'V-BLOCK',
      \ }

let g:airline_left_sep = '⮀'
let g:airline_right_sep = '⮂'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_alt_sep = '⮃'
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = ''
let g:airline_symbols.linenr = '⭡'
let g:airline_symbols.paste = 'p'
let g:airline_symbols.whitespace = 'w'

let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#bufferline#enabled = 0
let g:airline#extensions#syntastic#enabled = 1

function! _ShortenDir()
    return substitute(fnamemodify(getcwd(),':~:.'),'\~/Dropbox','DB','')
endfunction

let g:airline_section_b = "%<%{_ShortenDir()}/"
let g:airline_section_x = '%{airline#extensions#tagbar#currenttag()}' 
let g:airline_section_y = '%{airline#parts#filetype()}'
let g:airline_section_z = '%p%% %#__accent_bold#%l%#__restore__#:%2c'
let g:airline_section_error = ''  " temporary, to hide red arrow
" let g:airline_section_warning = ''
" let g:airline_section_gutter = ''

let g:airline#extensions#default#section_truncate_width = {
  \ 'b': 79, 'x': 60, 'y': 60, 'z': 45 }

" there is a base16_eighties theme but it maps normal mode to green
" see https://github.com/vim-airline/vim-airline/issues/1067
let g:airline_theme = 'base16'

" viewdoc
" XXX
let g:viewdoc_open = 'topleft new'
let g:ViewDoc_tex = 'ViewDoc_help_custom' 
" let g:viewdoc_only = 1

" default to ViewDocHelp!
let g:no_viewdoc_abbrev = 1
cnoreabbrev <expr> h      getcmdtype()==':' && getcmdline()=='h'     ? 'ViewDocHelp!' : 'h'
cnoreabbrev <expr> help   getcmdtype()==':' && getcmdline()=='help'  ? 'ViewDocHelp!' : 'help'

" quickscope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" latex / latex-suite (vimlatex)
autocmd FileType tex setlocal iskeyword+=:
autocmd FileType tex setlocal iskeyword-=\

let g:Tex_Leader2='<C-\>'

let g:tex_flavor='latex'
let g:Tex_AutoFolding=0
let g:Tex_ShowErrorContext=0
let g:tex_comment_nospell=1
let g:Imap_FreezeImap=1
let g:Tex_EnvironmentMaps=0
let g:Tex_EnvironmentMenus=0

let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='pdf'
" let g:Tex_ViewRule_pdf='zathura -x "gvim+%{line} %{input}"'
" TODO: right now we save this only for tex files
function! SynctexInverseSearch(line, file)
    echo a:file
    " let bufnr = bufnr('^'.a:file.'$')
    " exe bufwinnr.'winc w'
endfunction
autocmd FileType tex let $VIM_SERVERNAME=v:servername

let g:Tex_ViewRuleComplete_pdf='zathura -x '
    \ . '"vim --servername {v:servername} --remote +\%{line} \%{input}" '
    \ . '$*.pdf 2>/dev/null &'
let g:Tex_ViewRule_pdf='synctex_wrapper'

let g:Tex_CompileRule_pdf='pdflatex -synctex=-1 -interaction=nonstopmode -file-line-error-style $* -max-print-line=255 -shell-escape'
function! SetXeTex()
    let g:Tex_CompileRule_pdf='xelatex -interaction=nonstopmode -file-line-error-style $* -max-print-line=255'
endfunction

function! CompileXeTex()
    let oldCompileRule=g:Tex_CompileRule_pdf
    let g:Tex_CompileRule_pdf='xelatex -interaction=nonstopmode -file-line-error-style $* -max-print-line=255'
    call Tex_RunLaTeX()
    let g:Tex_CompileRule_pdf=oldCompileRule
endfunction

autocmd BufNewFile,BufRead *.tex 
    \ if getline(1) =~? 'xetex\|xelatex' | call SetXeTex() | endif

function! OpenLog()
	let mainfname = Tex_GetMainFileName()
	let mfnlog = fnamemodify(mainfname, ":t:r").'.log'
    execute 'split '.mfnlog
endfunction

autocmd FileType qf setl wrap

" vimtex
let g:vimtex_compiler_latexmk = {'continuous': 0}
" , 'callback': 0}
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_open_on_warning = 0

" let g:vimtex_latexmk_continuous = 0
" let g:vimtex_latexmk_background = 1
" let g:vimtex_quickfix_ignore_all_warnings = 0
" let g:vimtex_latexmk_build_dir='build'
" function! SetBuildDir()
 "    let g:vimtex_latexmk_build_dir='build'
" endfunction
" augroup vimtex_config
 "    au!
 "    au User VimtexEventInitPost call SetBuildDir()
" augroup END

" zotero + betterbibtex
nnoremap <silent> <leader>c :r!cite<cr>

" vimtex + surround
augroup latexSurround
   autocmd!
   autocmd FileType tex call s:latexSurround()
augroup END

function! s:latexSurround()
   let b:surround_{char2nr("e")}
     \ = "\\begin{\1environment: \1}\n\t\r\n\\end{\1\1}"
   let b:surround_{char2nr("c")} = "\\\1command: \1{\r}"
endfunction

" vimtex + ycm
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = [
    \ 're!\\[A-Za-z]*cite[A-Za-z]*(\[[^]]*\]){0,2}{[^}]*',
    \ 're!\\[A-Za-z]*ref({[^}]*|range{([^,{}]*(}{)?))',
    \ 're!\\hyperref\[[^]]*',
    \ 're!\\includegraphics\*?(\[[^]]*\]){0,2}{[^}]*',
    \ 're!\\(include(only)?|input){[^}]*',
    \ 're!\\\a*(gls|Gls|GLS)(pl)?\a*(\s*\[[^]]*\]){0,2}\s*\{[^}]*',
    \ 're!\\includepdf(\s*\[[^]]*\])?\s*\{[^}]*',
    \ 're!\\includestandalone(\s*\[[^]]*\])?\s*\{[^}]*',
    \ ]

" CtrlP
let g:ctrlp_extensions = [ 'tag', 'quickfix' ]
    " 'tag', 'buffertag', 'quickfix', 'dir', 'rtscript',
    " \ 'undo', 'line', 'changes', 'mixed', 'bookmarkdir']

let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ --ignore $HOME/.cache
      \ -g ""'

let g:ctrlp_clear_cache_on_exit = 1

" markdown (@gabrielelana, @ibabushkin)
let g:markdown_enable_mappings = 0

" Figlet
let g:figletFontDir='~/scripts/figlet-fonts'
let g:figletFont='standard'

" tagbar
" let g:tagbar_type_help = {
"     \ 'ctagstype' : 'help',
"     \ 'kinds'     : [
"         \ 's:sections',
"         \ 'g:graphics:0:0',
"         \ 'l:labels',
"         \ 'r:refs:1:0',
"         \ 'p:pagerefs:1:0'
"     \ ],
"     \ 'sort'    : 0
"     \ 'deffile' : expand('<sfile>:p:h:h') . '/ctags/latex.cnf'
" \ }

" http://stackoverflow.com/questions/26145505/using-vims-tagbar-plugin-for-latex-files
" \ 'deffile' : expand('<sfile>:p:h:h') . '/ctags/latex.cnf'

" recent ctags development versions support latex under tex
" TODO: why are subsections not working?
" let g:tagbar_type_tex = {
"     \ 'ctagstype' : 'tex',
"     \ 'kinds'     : [
"         \ 's:sections',
"         \ 'u:subsections',
"         \ 'g:graphics:0:0',
"         \ 'l:labels',
"         \ 'r:refs:1:0',
"         \ 'p:pagerefs:1:0'
"     \ ],
"     \ 'sort'    : 0
" \ }

" Syntastic

" let g:syntastic_enable_perl_checker = 1
" function! EnablePerlCheck()
" endfunction
" autocmd FileType perl noremap <buffer> <Leader>s :<C-U>call EnablePerlCheck()<CR> 

" chktex is a bit too noisy
let g:syntastic_tex_checkers = ['lacheck']  " , 'chktex']

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_mode_map = {
    \ "mode" : "passive",
    \ "passive_filetypes" : [ "matlab" ] }

" latex to unicode provided by the julia plugin 
" let g:latex_to_unicode_file_types = ".*"  
" = ["tex"]
let g:latex_to_unicode_auto = 1
let g:latex_to_unicode_eager = 1

" tpope's commentary 
let g:commentary_map_backslash = 0

" makeshift
" consider writing my own, makeshift uses set makeprg not :compiler
" let g:makeshift_systems = {
"     \   'latexmkrc': 'latexmk',
"     \}

" ────────────────────────────────────────────────────────────────────────────
"                      __                                                   
"     _______  _______/ /_____  ____ ___     ____ ___  ____ _____  _____    
"    / ___/ / / / ___/ __/ __ \/ __ `__ \   / __ `__ \/ __ `/ __ \/ ___/    
"   / /__/ /_/ (__  ) /_/ /_/ / / / / / /  / / / / / / /_/ / /_/ (__  )     
"   \___/\__,_/____/\__/\____/_/ /_/ /_/  /_/ /_/ /_/\__,_/ .___/____/      
"                                                        /_/                
" ────────────────────────────────────────────────────────────────────────────

nnoremap <silent> <Leader>_  :AirlineToggle<CR>
nnoremap <silent> <Leader>/  :<C-U>nohls<CR>

" latex stuff
nnoremap <silent> <leader>lx :<C-U>call SetXeTex()<CR>
nnoremap <silent> <leader>lz :<C-U>call CompileXeTex()<CR>
" noremap <silent> <leader>le :<C-U>call OpenLog()<CR>

" latex to unicode via the julia plugin
nnoremap <expr> <leader>u LaTeXtoUnicode#Toggle()

" default update and compile button (using vim-dispatch)
nnoremap <silent> <leader><leader>  :<C-U>up<CR>:Make!<CR>
nnoremap <silent> <F5>              <leader><leader>

" if current file is executable and has a hashbang, run it
function! SetShebangRun()
    if executable(expand('%:p')) && getline(1) =~# '^#!'
        noremap <silent> <buffer> <leader>\  :<C-U>up<CR>:execute "!" . expand("%:p:S")<CR>
        noremap <silent> <buffer> <F5>       :<C-U>up<CR>:execute "!" . expand("%:p:S")<CR>
    endif
endfunction
autocmd FileType sh     :call SetShebangRun()
autocmd FileType python :call SetShebangRun()
autocmd FileType perl   :call SetShebangRun()

" TODO: use makeprg for these?
" xxx
" autocmd FileType tex noremap <silent> <leader>\  :<C-U>up<CR>:silent call Tex_RunLaTeX()<CR>
" autocmd FileType tex noremap <silent> <F5>       :<C-U>up<CR>:silent call Tex_RunLaTeX()<CR>

augroup filetype_tex
    autocmd!
    autocmd FileType tex nnoremap <silent> <buffer> <leader><bslash>
        \ :<C-U>up<CR>:silent call vimtex#compiler#compile()<CR>
        \:redraw!<CR>
        \:call vimtex#qf#open(1)<CR>
    autocmd FileType tex nnoremap <silent> <buffer> <F5>    <leader><bslash>
augroup END

" xxx would have to add this compiler back in since removed in vimtex
" autocmd FileType tex compiler latexmk | setl makeprg=latexmk

" shortcuts to evaluate vimscript
autocmd FileType vim nnoremap <silent> <buffer> <leader>\ :up<CR>:source %<CR>:echo 'Sourced '.expand('%')<CR>
autocmd FileType vim nnoremap <silent> <buffer> <F5>      :up<CR>:source %<CR>:echo 'Sourced '.expand('%')<CR>

autocmd FileType vim vnoremap <silent> <buffer> <leader>\ :<C-U>@*<CR>:echo (1+line("'>")-line("'<")).' lines sourced'<CR>
autocmd FileType vim vnoremap <silent> <buffer> <F5>      :<C-U>@*<CR>:echo (1+line("'>")-line("'<")).' lines sourced'<CR>

" change to file's directory, locally or globally
nnoremap <silent> <leader>.  :<C-U>lcd %:p:h<CR>:pwd<CR>
nnoremap <silent> g.         :<C-U>cd %:p:h<CR>:pwd<CR>

" tagbar show and hide
nnoremap <silent> <leader>T  :<C-U>TagbarToggle<CR>

let g:ctrlp_map = ''
let g:ctrlp_cmd = 'CtrlPMRUFiles'
let g:ctrlp_prompt_mappings = {
    \ 'PrtClearCache()':      ['<c-g>'],
    \ 'ToggleByFname()':      ['<c-d>'],
    \ 'PrtExit()':            ['<esc>', '<c-c>'],
    \ }

" figlet
nnoremap <silent> <leader>xf :set operatorfunc=FigOper<cr>g@
vnoremap <silent> <leader>xf :Figlet<cr>

" show syntax under cursor
nnoremap <leader>xS :echo "hi<" 
    \ . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
    \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
    \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

nnoremap <leader>xs :call SyntaxAttr()<cr>

function! PickerMode(fname)
  set cursorline
  let b:picker_fname = fnamemodify(a:fname, ':p')
  nmap <buffer> <cr> :call writefile([getline(".")], b:picker_fname)<cr>:qa!<cr>
endfunction
" command! -nargs=1 PickerMode :call PickerMode(<q-args>)

function! FigPickerMode()
    let figfontwinnr = bufwinnr('__Figpicker__')
    if figfontwinnr != -1
        execute figfontwinnr . 'wincmd w'
        execute ':/' . g:figletFont
        return
    end
    execute 'silent keepalt vertical 20 new __Figpicker__'
    let g:figletPickerWindow = winnr()
    setl nonu cursorline nospell 
    setl noreadonly
    setl buftype=nofile bufhidden=hide noswapfile nobuflisted 
    setl nolist nowrap winfixwidth textwidth=0 
    execute ':.!figlist -d ' . g:figletFontDir . '| tail -n +3'
    :g/in this direc/d
    silent execute ':/' . g:figletFont
    try
        " nnoremap <buffer> <CR> ^y$:let g:figletFont='<c-r>"'<cr><c-w>pu.<c-w>p
        nnoremap <buffer> <CR> ^y$:let g:figletFont='<c-r>"'<cr><c-w>p
    endtry
    setl nomodifiable nomodified
endfunction
command! -nargs=0 Pick :call FigPickerMode()<cr>
nnoremap <silent> <leader>xF :call FigPickerMode()<cr>

" sling to tmux
let g:slimux_tmux_path = '/usr/bin/tmux'
function! SlingOper(type)
    if !exists("b:code_packet")
        let b:code_packet = { "target_pane": "", "type": "code" }
    endif
    let rv = getreg('"')
    let rt = getregtype('"')
    sil exe "'[,']yank"
    call SlimuxSendCode(@")
    call setreg('"',rv, rt)
endfunction
nnoremap <silent> <leader>]   :set opfunc=SlingOper<cr>g@

nnoremap <silent> <leader>]]  :silent SlimuxREPLSendLine<cr>
vnoremap <silent> <leader>]   :SlimuxREPLSendSelection<cr>
autocmd FileType matlab nnoremap <silent> 
    \ <leader>\ :<c-u>w<cr>:execute ":SlimuxShellRun " . expand('%:r')<cr>

" yanks to tmux.  can we make this more vimmy?
nnoremap <silent> <leader>y  :.w !tmux loadb -<CR>
vnoremap <silent> <leader>y  :w<home>silent <end> !tmux loadb -<CR>

function! SyntaxToggle()
    execute 'SyntasticToggleMode'
    if g:syntastic_mode_map['mode'] ==? 'active'
        execute 'SyntasticCheck'
    endif
endfunction
nnoremap <silent> <leader>s  :<C-U>SyntasticCheck<CR>
nnoremap <silent> <leader>S  :<C-U>call SyntaxToggle()<CR>

" set pastetoggle=
" set pastetoggle=<leader>`

inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

let g:vdebug_keymap = {
    \    "run" : "<F13>", 
    \    "run_to_cursor" : "<Leader>R",
    \    "step_over" : "<F2>",
    \    "step_into" : "<F3>",
    \    "step_out" : "<F4>",
    \    "close" : "<Leader>c",
    \    "detach" : "<F7>",
    \    "set_breakpoint" : "<F10>",
    \    "get_context" : "<Leader>w",
    \    "eval_under_cursor" : "<Leader>v",
    \    "eval_visual" : "<Leader>e",
    \}

nnoremap <Leader>x :<C-U>VdebugEval 

function! GetBufferList()
    redir =>buflist
    silent! ls!
    redir END
    return buflist
endfunction

function! ToggleList(bufname, pfx)
    let buflist = GetBufferList()
    for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
        if bufwinnr(bufnum) != -1
            exec(a:pfx.'close')
            return
        endif
    endfor
    if a:pfx == 'l' && len(getloclist(0)) == 0
        echohl ErrorMsg
        echo "Location List is Empty."
        return
    endif
    let winnr = winnr()
    exec(a:pfx.'open 8')
    if winnr() != winnr
        " wincmd p
    endif
endfunction

nmap <silent> <leader>W :<C-U>call ToggleList("Location List", 'l')<CR>
nmap <silent> <leader>Q :<C-U>call ToggleList("Quickfix List", 'c')<CR>

nmap <silent> <leader>w :<C-U>CtrlPLocList<CR>
nmap <silent> <leader>q :<C-U>CtrlPQuickfix<CR>

nmap <silent> <leader>t :<C-U>CtrlPTag<CR>

" xxx these are the same..
nmap <silent> <leader>6 :<C-U>CtrlPBuffer<CR>
nmap <silent> <leader>p :<C-U>CtrlPBuffer<CR>

nmap <silent> <leader>o :<C-U>CtrlP<CR>
nmap <silent> <leader>[ :<C-U>CtrlPMRUFiles<CR>

" open in preview window
function! PreviewFile(action, line)
    if a:action =~ '^e$'  
        let filename = fnameescape(fnamemodify(a:line, ':p'))
        call ctrlp#exit()
        exec 'pedit' . filename
        wincmd P 
    else
        " Use CtrlP's default file opening function
        call call('ctrlp#acceptfile', [a:action, a:line])
    endif
endfunction

    " exec 'pedit ' . a:file
    " if a:action =~ '^[tx]$' && fnamemodify(a:line, ':e') =~? '^html\?$'

    "   " Get the filename
    "   let filename = fnameescape(fnamemodify(a:line, ':p'))

    "   " Close CtrlP
    "   call ctrlp#exit()

    "   " Open the file
    "   silent! execute '!xdg-open' filename

    " elseif a:action == 'x' && fnamemodify(a:line, ':e') !~? '^html\?$'

    "   " Not a HTML file, simulate pressing <c-o> again and wait for new input
    "   call feedkeys("\<c-o>")

    " else

    "   " Use CtrlP's default file opening function
    "   call call('ctrlp#acceptfile', [a:action, a:line])

    " endif

" open to file under cursor with CtrlP
function! CtrlPCursorFile()
    let fname = expand("<cfile>")
    if empty(fname)
        echohl ErrorMsg
        echo "No file name under cursor"
        return
    endif

    let l:olddefault = 0
    if exists("g:ctrlp_default_input")
        let l:olddefault = g:ctrlp_default_input 
    endif
    let g:ctrlp_default_input = fname

    let l:oldopenfunc = {}
    if exists("g:ctrlp_open_func")
        let l:oldopenfunc = g:ctrlp_open_func
    endif
    let g:ctrlp_open_func = { 'files' : 'PreviewFile' }

    " maybe use mixed mode instead: 0 -> ctrlp#mixed#id()?
    call ctrlp#init(0, { 'mode': 'r' })

    let g:ctrlp_default_input = l:olddefault
    let g:ctrlp_open_func = l:oldopenfunc
endfunction
nmap <silent> <leader>f :<C-U>call CtrlPCursorFile()<CR>

" open preview window of file under cursor (doesn't always work)
" nmap <silent> <leader>o :<C-U>exec 'pedit ' . expand('<cfile>') <CR><C-W>P
" was <tab> but this conflictrs


autocmd FileType matlab setlocal commentstring=%\ %s

"" autocmd FileType matlab nnoremap <buffer> <leader>\ :make<CR><CR>
"" autocmd FileType matlab set makeprg=mluxrun\ %:r

" autocmd FileType matlab nnoremap <buffer> K :Mhelp <C-R>=expand('<cword>')<CR><CR>

" increment/decrement
nnoremap <leader>- <c-x>
vnoremap <leader>- <c-x>
vnoremap <leader>g- g<c-x>
nnoremap <leader>= <c-a>
vnoremap <leader>= <c-a>
vnoremap <leader>g= g<c-a>

nnoremap <c-a> <nop>
nnoremap <c-x> <nop>

" remove trailing whitespace
command! -range=% Strip <line1>,<line2>s/\s\+$//e

" from http://vim.wikia.com/wiki/List_loaded_scripts
function! s:Scratch (command, ...)
   redir => lines
   let saveMore = &more
   set nomore
   execute a:command
   redir END
   let &more = saveMore
   call feedkeys("\<cr>")
   new | setlocal buftype=nofile bufhidden=hide noswapfile
   put=lines
   if a:0 > 0
      execute 'vglobal/'.a:1.'/delete'
   endif
   if a:command == 'scriptnames'
      %substitute#^[[:space:]]*[[:digit:]]\+:[[:space:]]*##e
   endif
   silent %substitute/\%^\_s*\n\|\_s*\%$
   let height = line('$') + 3
   execute 'normal! z'.height."\<cr>"
   0
endfunction
 
command! -nargs=? Scriptnames call <sid>Scratch('scriptnames', <f-args>)
command! -nargs=+ Scratch call <sid>Scratch(<f-args>)
