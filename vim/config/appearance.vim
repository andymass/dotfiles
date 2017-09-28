" appearance setup is based on terminal capabilities and local preferences
scriptencoding utf-8

let g:appearance = 'basic'

if HasPlugin('vim-airline')

endif

if has('termguicolors') && ($COLORTERM != '')
    " set termguicolors
endif

" set options and variables for appearance
let s:app = {}
function! s:app.basic()

endfunction

function! s:app.hopper1()
    let g:rc_term = 'konsole'

endfunction

function! s:app.banach1()

endfunction

function! SetAppearance(...)


endfunction

function! RefreshAppearance()
endfunction

function! UpdateAppearance(...)

    " pass option to force appearance
    if a:0 > 0
        let g:appearance = a:1
        call RefreshAppearance()
    return

    let l:old_appearance = g:appearance

    if g:within_tmux
        let l:out = systemlist('tmux showenv COLORSCHEME') 
        if v:shell_error == 0
            let l:scheme = split(l:out, '=')[1]
            " XXX lookup to make sure it exists...
            let g:appearance = l:scheme
        end
    end

    if g:appearance != l:oldappearance
        call RefreshAppearance()
    end

endfunction



