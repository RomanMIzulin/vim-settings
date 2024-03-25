call plug#begin()
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'nvie/vim-flake8'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'tpope/vim-fugitive'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'vim-airline/vim-airline'
Plug 'mhinz/vim-startify'
Plug 'wbthomason/packer.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'aserowy/tmux.nvim'
Plug 'tveskag/nvim-blame-line'
Plug 'ruanyl/vim-gh-line'

"fast search
Plug 'justinmk/vim-sneak'


Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'navarasu/onedark.nvim'

" Inside the Vim-Plug block on your .vimrc
Plug 'ekalinin/Dockerfile.vim'

" DEBUGGER
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-dap-python'

" colorscheme theme
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'morhetz/gruvbox'

call plug#end()

let g:black_linelength = 120
let g:black_target_version = "py310"
let g:neomake_python_enabled_makers = ['pylint']
let g:pymode_options_max_line_length = 120
let mapleader=" "
set mouse=a
nnoremap <SPACE> <Nop>
nnoremap <leader>ff :Telescope find_files hidden=true<CR>
nnoremap <leader>fg :Telescope live_grep<CR>
nnoremap <leader>jd :YcmCompleter GoTo<CR>
nnoremap <leader>s :vsp<CR>
nnoremap <leader>v :CHADopen<CR>
nnoremap <leader>d <Plug>(coc-definition)
nnoremap <leader>D <Plug>(coc-type-definition)
nnoremap <leader>rn <Plug>(coc-rename)
nnoremap <leader>rr <Plug>(coc-references)
nnoremap <leader>bl :ToggleBlameLine<CR>
set guifont=FiraCode\ NF:h12
set splitbelow
set splitright

set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=3

set shortmess+=c
			
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300


if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
"inoremap <silent><expr> <CR> coc#pum#visible() ? coc#_select_confirm()
"				\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

autocmd CursorHold * silent call CocActionAsync('highlight')

augroup fmt
  autocmd!
  autocmd BufWritePre *.py execute ':Black'
augroup END


set completeopt=menu,menuone,noselect

function! CheckBackSpace() abort
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Insert <tab> when previous text is space, refresh completion if not.
inoremap <silent><expr> <TAB>
\ coc#pum#visible() ? coc#pum#next(1):
\ CheckBackSpace() ? "\<Tab>" :
\ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

"colorscheme onedark
set background=light
colorscheme gruvbox

map f <Plug>Sneak_s
map F <Plug>Sneak_S 
noremap <F6> :Black<CR>

let g:neovide_transparency = 0.98
let g:neovide_scale_factor = 0.85
setlocal foldmethod=indent
set foldlevel=99

set scrolloff=10
lua << EOF
require('dap-python').setup('~/findocs_back/.virtualenvs/debugpy/bin/python')
require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
      --'--no-ignore-vcs' -- wtf is this
      '--glob', '!**/.cache/*',  -- Ignore .cache directory
      '--glob', '!**/__pycache__/*',  -- Ignore .cache directory
      '--glob', '!**/*.pyc',  -- Ignore .pyc files
    },
}
  }
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
EOF


