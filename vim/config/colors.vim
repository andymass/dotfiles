scriptencoding utf-8

if exists('s:did_colors')
    finish
endif
let s:did_colors = 1

let s:prev_colors_name = ''
let s:did_capture_defaults = 0
let s:init_hi_links = {}

" sets color scheme options
let s:color_opts = {}
function! s:color_opts.OceanicNext()
    let g:oceanic_next_terminal_bold = 1
    let g:oceanic_next_terminal_italic = 1
endfunction
function! s:color_opts.palenight() dict
    let g:palenight_terminal_italics = 1
endfunction

function! s:Get_hi_links(prior)
    redir => l:listing
    try
        silent highlight
    finally
        redir END
    endtry

    let l:hi_links = {}
    for l:line in split(l:listing, "\n")
        let l:tok = split(line)
        " an explicit link
        if len(l:tok) == 5 && l:tok[1] == 'xxx'
                \ && l:tok[2] == 'links' && l:tok[3] == 'to'
            let l:fromgroup = l:tok[0]
            let l:togroup = l:tok[4]
            let l:hi_links[l:fromgroup] = l:togroup
        endif
        " a highlighting group, we need to remember prior links
        if len(l:tok) >= 3 && l:tok[1] == 'xxx' && l:tok[2] != 'cleared'
            let l:fromgroup = l:tok[0]
            if has_key(a:prior, l:fromgroup)
                let l:hi_links[l:fromgroup] = a:prior[l:fromgroup]
            endif
        endif
    endfor
    return l:hi_links
endfunction

function! s:Nuke_hi_links(after)
    for l:link in keys(a:after)
        exe 'hi! link' l:link 'NONE'
    endfor
endfunction

function! s:Make_hi_links(before)
    for l:link in keys(a:before)
        exe 'hi! link' l:link a:before[l:link]
    endfor
endfunction

function! ColorsEnter()

    " redraw!

    " assume this is a known-good state
    if !s:did_capture_defaults
        let s:init_hi_links = s:Get_hi_links({})
        let s:did_capture_defaults = 1
    endif
endfunction

" simple wrapper around :colo[rscheme] which tries to normalize 
" highlighting to allow switching between many color schemes
" also supports s:ColorsSwitch('-') to switch to prior scheme
function! s:ColorsSwitch(...)

    " with no arguments, print colors name 
    if a:0 == 0
        if exists('g:colors_name')
            echo g:colors_name
        else
            echo 'default'
        endif
        return
    endif

    " providing - switches to last colors
    let l:print_name = 0
    let l:scheme = a:1
    if l:scheme == '-'
        if s:prev_colors_name is ''
            echohl ErrorMsg
            echo 'No previous color scheme'
            echohl None 
            return
        endif
        let l:scheme = s:prev_colors_name
        let l:print_name = 1
    endif

    " check that it exists
    let l:idx = index(s:GetColorschemeList(0), l:scheme)
    if l:idx < 0
        echohl ErrorMsg
        echo "Cannot find color scheme '".l:scheme."'"
        echohl None 
        return
    endif

    " set the color scheme options
    if has_key(s:color_opts, l:scheme)
        call s:color_opts[l:scheme]()
    endif

    " get rid of hi links created by previous color scheme
    if exists('s:after_hi_links')
        call s:Nuke_hi_links(s:after_hi_links)
    endif

    " bring us back to before the last color scheme
    call s:Make_hi_links(s:init_hi_links)
    if exists('s:before_hi_links')
        call s:Make_hi_links(s:before_hi_links)
        let s:before_hi_links = s:Get_hi_links(s:before_hi_links)
    else
        let s:before_hi_links = s:Get_hi_links({})
    endif

    let l:prev = get(g:, 'colors_name', 'default')

    try
        " warning: this triggers the ColorScheme autocommand
        execute 'colorscheme' fnameescape(l:scheme)

        if g:colors_name != l:scheme
            echohl WarningMsg
            echo 'g:colors_name (' . g:colors_name
                \ . ') does not match scheme name (' . l:scheme . ')'
            echohl None 
        endif
    catch /.*/
        " try to recover links..
        if exists('s:after_hi_links')
            call s:Make_hi_links(s:after_hi_links)
        endif
        return
    endtry

    let s:after_hi_links = s:Get_hi_links({})

    if g:colors_name != l:prev
        let s:prev_colors_name = l:prev
    endif

    if l:print_name
        redraw!
        echo g:colors_name
    endif

endfunction

command! -nargs=? -complete=color Colors call s:ColorsSwitch(<f-args>)

function! s:cmdalias(from, to)
    for l:to in a:to
        execute "cnoreabbrev <expr> " . l:to
            \ . " getcmdtype()==':' && getcmdline()=='". l:to . "'"
            \ . " ? '" . a:from . "' : '". l:to . "'"
    endfor
endfunction
call s:cmdalias('Colors', ['colo', 'color', 'colors', 'colorscheme'])

function! s:ColorFix()

    " color scheme specific fixes
    let g:airline_theme = 'dark'

    " xxx the airline theme messes up a lot 
    " for some reason..

    if g:colors_name == 'nord'
        hi StatusLineNC guibg=#000000
        hi MatchParen cterm=italic ctermfg=15 ctermbg=0 
            \ gui=italic guifg=#B48EAD guibg=#2E3440
        hi Folded ctermfg=13
        " let g:airline_theme = 'nord'
    endif

    if g:colors_name == 'palenight'
        hi MatchParen cterm=italic gui=italic
        hi FoldColumn ctermfg=238 guifg=#4B5263
        hi Spellbad guifg=NONE
        let g:palenight_terminal_italics = 1
        let g:airline_theme = 'onedark'
    endif

    " fix the bold inconsistency between gui/cterm
    " assumes the terminal supports bold properly
    if &termguicolors
        for l:group in [ 'Comment', 'Special',
                \ 'Identifier', 'Statement', 'Type',
                \ 'NonText', 'MoreMsg', 'CursorLineNr',
                \ 'Question', 'Title', 'DiffDelete' ]
            if synIDattr(synIDtrans(hlID(l:group)), 'bold', 'gui')
                exe 'hi '.l:group.' cterm=bold'
            endif
        endfor
    endif

endfunction

augroup color_fix
    autocmd!
    autocmd ColorScheme * call s:ColorFix()
augroup END

function! s:GetColorschemeList(exclude_builtins)
    let l:exclude_list = []

    let l:schemes = split(globpath(&runtimepath, 'colors/*.vim'), '\n')
    call map(l:schemes, 'fnamemodify(v:val, ":t:r")')

    if a:exclude_builtins
        let l:builtins = split(globpath($VIMRUNTIME, 'colors/*.vim'), '\n') 
        call map(l:builtins, 'fnamemodify(v:val, ":t:r")')
        call filter(l:schemes, 'index(l:builtins, v:val) == -1')
    endif

    call filter(l:schemes, 'index(l:exclude_list, v:val) == -1')
    return sort(l:schemes)
endfunction

function! s:Random(limit)
    let l:components = split(reltimestr(reltime()), '\.')
    let l:microseconds = l:components[-1] + 0
    return microseconds % a:limit
endfunction

function! s:GetFilteredColorschemeList(exclude_builtins)
    let l:bad_pattern = '-light$'
    let l:list = s:GetColorschemeList(a:exclude_builtins)
    call filter(l:list, 'v:val !~ "'.l:bad_pattern.'"')
    return l:list
endfunction

function! s:GetRandomColorScheme(exclude_builtins)
    let l:list = s:GetFilteredColorschemeList(a:exclude_builtins)
    return l:list[s:Random(len(l:list))]
endfunction

function! s:DoRandomColorScheme(exclude_builtins)
    let l:cs = s:GetRandomColorScheme(a:exclude_builtins)
    execute 'Colors' l:cs
    redraw! | echo l:cs
endfunction

function! s:mod(i, n)
    return ((a:i % a:n) + a:n) % a:n
endfunction

function! s:DoNextColors(exclude_builtins, direction)
    let l:list = s:GetFilteredColorschemeList(a:exclude_builtins)
    let l:idx = index(l:list, get(g:, 'colors_name', 'default'))
    let l:idx = s:mod(l:idx + a:direction, len(l:list))
    let l:cs = l:list[l:idx]
    execute 'Colors' l:cs
    redraw! | echo l:cs '('.(l:idx+1).'/'.len(l:list).')'
endfunction

command! -bang RandomColors call s:DoRandomColorScheme(<bang>1)
command! -bang -count=1 NextColors call s:DoNextColors(<bang>1, <count>)
command! -bang -count=1 PrevColors call s:DoNextColors(<bang>1, -<count>)

nnoremap <silent> =r :<c-u>call <sid>DoRandomColorScheme(1)<cr>
nnoremap <silent> ]r :<c-u>call <sid>DoNextColors(1, v:count1)<cr>
nnoremap <silent> [r :<c-u>call <sid>DoNextColors(1, -v:count1)<cr>

