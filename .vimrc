
set nocompatible
filetype off

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'davidhalter/jedi-vim'

Plug 'nvie/vim-flake8'
Plug 'vim-airline/vim-airline'


Plug 'hdima/python-syntax'

Plug 'ambv/black'

Plug 'stephpy/vim-yaml'

Plug 'sirver/ultisnips'
Plug 'keelii/vim-snippets'

Plug 'tpope/vim-fugitive'


call plug#end()


"basic configs 
" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

" Security
set modelines=0

" Show line numbers
set number

" Show file stats
set ruler

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Ignore case when searching
set ignorecase

" Encoding
set encoding=utf-8

" Status bar
set laststatus=2

" Rendering
set ttyfast

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬

"custom configs
let mapleader = " "
nnoremap <leader>pv :Vex<CR>

let g:UltiSnipsExpandTrigger="<tab>"
"Use tab to switch the next trigger point, shit + tab on a trigger point
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
"Vertical splitting of the screen when using the UltiSnips Edit command
let g:UltiSnipsEditSplit="vertical"
