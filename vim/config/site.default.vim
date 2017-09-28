scriptencoding utf-8

let g:appearance = 'basic'
if $COLORSCHEME != ''
    let g:appearance = $COLORSCHEME
endif

function! SiteSetupAppearance()
endfunction

function! SiteSetupPlugs()
    Plug 'andymass/vimtex'
    Plug 'andymass/vim-matlab'
    Plug 'chriskempson/base16-vim'
endfunction

" settings overrides
function! SiteSetupPost()

endfunction

" called on VimEnter or when sourcing vimrc
" allows autocommands (use noautocmd to prevent)
function! SiteEnter()

endfunction

