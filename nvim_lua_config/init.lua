-- Install packer if not already installed

require("config.lazy")
require("lazy").setup("plugins")

-- END OF INSTALLs HERE ---------------------

-- LSP config with Pyright
require('lspconfig')['pyright'].setup{
	on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

        -- Enable completion triggered by <c-x><c-o>

        -- Mappings.
        local opts = { noremap=true, silent=true }
        
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', '<leader>d', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', '<leader>rr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

--	settings = { pyright = {
--		typeCheckingMode = "strict"
--		}
--	}
--
end

}
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "python","gleam","elixir", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript" },

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- Null-ls integration
local null_ls = require('null-ls')
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.black.with({
            extra_args = { "--line-length", "120" }, -- Configurable line length
        }),
    },
})

--[[ nvim-cmp setup for autocompletion
local cmp = require'cmp'
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
    })
})
--]]

-- Telescope configuration remains largely unchanged from the Vimscript example
require('telescope').setup{
  defaults = {
    -- Configuration for telescope
    vimgrep_arguments = {
      'rg',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
      '--glob', '!**/.cache/*',
      '--glob', '!**/__pycache__/*',
      '--glob', '!**/*.pyc',
      '--glob', '!.git/*',
    },
  }
}

-- Python-specific folding settings using Tree-sitter
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    -- Use Tree-sitter for folding
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
    -- Don't fold by default when opening a file
    vim.opt_local.foldlevel = 99
    -- Set a reasonable fold level
    vim.opt_local.foldnestmax = 10
    -- Customize fold text (optional)
    vim.opt_local.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
    -- Enable folding
    vim.opt_local.foldenable = true
  end
})

------------ KEYMAPS ---------
-- Optional: Set up key mappings for folding
vim.g.mapleader = " "  -- Setting leader key

-- folding
-- Toggles the fold under the cursor.
vim.api.nvim_set_keymap('n', 'za', 'za', { noremap = true, silent = true })
-- open all folds	
vim.api.nvim_set_keymap('n', 'zR', 'zR', { noremap = true, silent = true })
-- close all folds
vim.api.nvim_set_keymap('n', 'zM', 'zM', { noremap = true, silent = true })

-- Telescope
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files hidden=true<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', {noremap = true})

-- any
vim.keymap.set('n', '<leader>v', '<cmd>CHADopen<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>s', '<cmd>vertical split<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>t', '<cmd>vertical terminal<CR>', {noremap = true, silent = true})

-- snippets
local ls = require("luasnip")
vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = false})
vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})
-- end snippets




				

vim.cmd [[
set background=dark
colorscheme monokai-pro
hi Comment guifg=Yellow
" Set recommended to false
let g:coq_settings = { "keymap.recommended": v:false }

" Keybindings
" 🐓 Coq completion settings
ino <silent><expr> <Esc>   pumvisible() ? "\<C-e><Esc>" : "\<Esc>"
ino <silent><expr> <C-c>   pumvisible() ? "\<C-e><C-c>" : "\<C-c>"
ino <silent><expr> <BS>    pumvisible() ? "\<C-e><BS>"  : "\<BS>"
ino <silent><expr> <CR>    pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"
ino <silent><expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
ino <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<BS>"
]]



