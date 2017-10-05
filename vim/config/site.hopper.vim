scriptencoding utf-8

let g:appearance = 'hopper1'
if $COLORSCHEME != ''
    let g:appearance = $COLORSCHEME
endif

function! SiteSetupAppearance()
    set termguicolors
endfunction

function! SiteSetupPlugs()
    " Plug 'scrooloose/syntastic''
endfunction

" settings overrides
function! SiteSetupPost()
    set textwidth=74

endfunction

" called on VimEnter or when sourcing vimrc
" allows autocommands (use noautocmd to prevent)
function! SiteEnter()

    " set the color scheme
    if !get(g:, 'rc_no_colors', 0) && !exists('g:colors_name')
        Colors palenight
    endif

endfunction




" function! Wipe_hi_links()
"     call Nuke_hi_links(Get_hi_links({}))
" endfunction

" function! GNuke_hi_links()
"     call Nuke_hi_links(s:init_hi_links)
" endfunction
" function! GMake_hi_links()
"     call Make_hi_links(s:init_hi_links)
" endfunction

    " let l:prev = get(g:, 'colors_name', '')
    " if get(g:, 'loaded_colorscheme_switcher', 0)
    "     call xolox#colorscheme_switcher#switch_to(l:scheme)
    " else
    "     exe 'colorscheme ' . l:scheme
    " endif

    " restore state
    " let l:after_hi_links = Get_hi_links()
    " call Nuke_hi_links(l:after_hi_links)
    " call Make_hi_links(s:before_hi_links)


" cnoreabbrev <expr> colo getcmdtype()==':'
"         \ && getcmdline()=='colo' ? 'Color' : 'colo'
" cnoreabbrev <expr> color getcmdtype()==':'
"         \ && getcmdline()=='color' ? 'Color' : 'color'
" cnoreabbrev <expr> colors getcmdtype()==':'
"         \ && getcmdline()=='colors' ? 'Color' : 'colors'
" cnoreabbrev <expr> colorscheme getcmdtype()==':'
"         \ && getcmdline()=='colorscheme' ? 'Color' : 'colorscheme'


    " set background=dark

    " colorscheme nord
    " set t_8f=\[[38;2;%lu;%lu;%lum
    " set t_8b=\[[48;2;%lu;%lu;%lum


    " call s:ColorsSwitch('palenight')
    " call s:ColorsSwitch('dracula')

    " colorscheme OceanicNext
    " colorscheme base16-eighties
    " colorscheme onedark
    " colorscheme hybrid
    " colorscheme afterglow
"    Color dracula


" function! Store_hi_links()
"     let s:before_hi_links = Get_hi_links()
" endfunction

" function! Restore_hi_links()
"     " call Nuke_hi_links(g:after)
"     " call Make_hi_links(g:before)
"     let l:after_hi_links = Get_hi_links()
"     let g:hi2 = l:after_hi_links
"     call Nuke_hi_links(l:after_hi_links)
"     call Make_hi_links(s:before_hi_links)
" endfunction

" function s:restore_hi_links(before, after)
"     " fix links in after but not in before
"     for l:k in keys(l:after)
"     endfor
"     " let l:after_minus_before = {}
" endfunction

