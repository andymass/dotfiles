scriptencoding utf-8

let g:appearance = 'banach1'
if $COLORSCHEME != ''
    let g:appearance = $COLORSCHEME
endif

function! SiteSetupAppearance()
    " set termguicolors

endfunction

function! SiteSetupPlugs()
    Plug 'andymass/vimtex'
    Plug 'andymass/vim-matlab'
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
    Plug 'chriskempson/base16-vim'
endfunction

" settings overrides
function! SiteSetupPost()

endfunction

" called on VimEnter or when sourcing vimrc
" allows autocommands (use noautocmd to prevent)
function! SiteEnter()

    " set the color scheme
    if !get(g:, 'rc_no_colors', 0) && !exists('g:colors_name')
        let g:base16colorspace=256
        Colors base16-eighties

        if !has("gui_running")
            hi Normal ctermbg=none
        end
    endif

endfunction

