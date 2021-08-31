
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


call plug#end()

let mapleader = " "
nnoremap <leader>pv :Vex<CR>
