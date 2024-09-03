-- Install packer if not already installed

require("config.lazy")
require("lazy").setup("plugins")

-- END OF INSTALLs HERE ---------------------

-- LSP config with Pyright
require('lspconfig')['pyright'].setup{}

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

------------ KEYMAPS ---------
vim.g.mapleader = " "  -- Setting leader key
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files hidden=true<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', {noremap = true})

vim.keymap.set('n', '<leader>v', '<cmd>CHADopen<CR>', {noremap = true, silent = true})

-- snippets
local ls = require("luasnip")
vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})
-- end snippets

-- Theme settings
vim.cmd [[
set background=dark
colorscheme gruvbox
]]



