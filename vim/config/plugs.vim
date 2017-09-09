" plugin setup
scriptencoding utf-8

" pathogen; install plugins located in ~/.vim/bundle
execute pathogen#infect()

" other plugins with vim-plug
call plug#begin('~/.vim/plugged')

" tpopisms
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-fugitive'
Plug 'tpope/tpope-vim-abolish'
Plug 'tpope/vim-scriptease'
" Plug 'tpope/vim-sleuth', { 'for' : 'vim' }

" file types
" Plug 'lervag/vimtex'
" Plug 'andymass/vimtex', { 'branch': 'personal' } [*]
Plug 'JuliaLang/julia-vim'
" Plug 'pycckuu/MatlabFilesEdition' 
" Plug 'andymass/vim-matlab' [*]
Plug 'ibabushkin/vim-markdown'
"  XXX consider: Plug 'rhysd/vim-gfm-syntax' (has concealing emoji)
Plug 'elzr/vim-json'
" Plug 'python-mode/python-mode'
Plug 'octol/vim-cpp-enhanced-highlight'
" Plug 'tmux-plugins/vim-tmux'

" ctrlp
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ivalkeen/vim-ctrlp-tjump'
Plug 'DeaR/ctrlp-location-list'
Plug 'christoomey/ctrlp-generic'

" conveniences
Plug 'majutsushi/tagbar'
Plug 'godlygeek/tabular'
Plug 'andymass/quick-scope'   " 'unblevable/quick-scope'
Plug 'skywind3000/asyncrun.vim'
" Plug 'johnsyweb/vim-makeshift'
Plug 'powerman/vim-plugin-viewdoc'
" Plug 'DanThomson/Figlet.vim'
Plug 'fadein/vim-FIGlet'
Plug 'gregsexton/gitv', { 'on' : 'Gitv' }
Plug 'mtth/scratch.vim'
" Plug 'xolox/vim-misc' 
" Plug 'Wraul/vim-easytags', { 'branch': 'fix-universal-detection' }
Plug 'ludovicchabant/vim-gutentags'
" Plug 'wellle/targets.vim'
" Plug 'ciaranm/detectindent'
" Plug 'ciaranm/securemodelines'
Plug 'sk1418/Join'
" Plug 'zef/vim-cycle' 
" Plug 'bootleq/vim-cycle' 
" Plug 'AndrewRadev/switch.vim'
Plug 'chrisbra/NrrwRgn'
" Plug 'tomtom/quickfixsigns_vim'
Plug 'vim-utils/vim-vertical-move'
Plug 'dahu/vim-lotr'

" characters and unicode
Plug 'junegunn/vim-emoji'
Plug 'chrisbra/unicode.vim'
Plug 'joom/latex-unicoder.vim'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-operator-user'

" window management
" Plug 'breuckelen/vim-resize'
Plug 'wesQ3/vim-windowswap'
Plug 'ddrscott/vim-window'
Plug 'Soares/butane.vim'

" terminal/tmux integration
" these plugins allow vim to receive focus events in terminal
" Plug 'wincent/terminus'
" Plug 'amerlyq/vim-focus-autocmd'
" Plug 'sjl/vitality.vim'
" Plug 'tmux-plugins/vim-tmux-focus-events'

" syntax and coding 
Plug 'scrooloose/syntastic'
" Plug 'w0rp/ale'
Plug 'vim-scripts/SyntaxAttr.vim'
Plug 'SirVer/ultisnips'
Plug 'epeli/slimux'
" Plug 'joonty/vdebug'
" Plug 'Valloric/YouCompleteMe' [*]
" Plug 'kergoth/vim-hilinks'

" appearance
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chrisbra/Colorizer'
" Plug 'edkolev/promptline.vim'
" Plug 'severin-lemaignan/vim-minimap'

" colorschemes
Plug 'arcticicestudio/nord-vim'
Plug 'sjl/badwolf'
Plug 'marciomazza/vim-brogrammer-theme'
Plug 'notpratheek/vim-luna'
Plug 'joshdick/onedark.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'w0ng/vim-hybrid'
Plug 'kabbamine/yowish.vim'
Plug 'mhartington/oceanic-next'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'KeitaNakamura/neodark.vim'
Plug 'lu-ren/SerialExperimentsLain'
Plug 'cocopon/iceberg.vim'
Plug 'raphamorim/lucario'
Plug 'roosta/vim-srcery'
Plug 'bluz71/vim-moonfly-colors'
Plug 'morhetz/gruvbox'
Plug 'abra/vim-obsidian'
Plug 'whatyouhide/vim-gotham'
Plug 'danilo-augusto/vim-afterglow'
Plug 'dracula/vim', { 'as': 'dracula-vim' }
Plug 'jsit/vim-tomorrow-theme'   " forked chriskempson/vim-tomorrow-theme
Plug 'jsit/disco.vim'
" Plug 'chriskempson/base16-vim' [*]
" Plug 'xolox/vim-misc' | Plug 'xolox/vim-colorscheme-switcher'
Plug 'jnurmine/Zenburn'

" experiment
" Plug 'ryanoasis/vim-devicons'

" [*] plugin is handled manually

call SiteSetupPlugs()

call plug#end()

" plug#end() runs:
"  - filetype plugin indent on
"  - syntax enable

function! HasPlugin(plug)
    return !empty(filter(split(&rtp,','), 'v:val =~? ''\<'.a:plug.'\>'''))
endfunction

" matchit standard vim macro
runtime macros/matchit.vim

