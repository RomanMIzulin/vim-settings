
return {

  -- Telescope for fuzzy finding
   {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  },
  -- get link to code at gitlab or github
'ruanyl/vim-gh-line',

'github/copilot.vim',

  --monokai theme
  'loctvl842/monokai-pro.nvim',
  {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
},

  -- CHADtree
   {'ms-jpq/chadtree', branch= 'chad', build= 'python3 -m chadtree deps'},
  -- Treesitter for enhanced syntax highlighting
   {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  },

  -- LSP support
   'neovim/nvim-lspconfig',

  -- Pyright for Python LSP
   'https://github.com/neovim/nvim-lspconfig',

  -- Null-ls for integrating tools like black
   'jose-elias-alvarez/null-ls.nvim',

  -- LuaSnip for snippets
   {
    'L3MON4D3/LuaSnip',
    	version = "v2.3", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	build = "make install_jsregexp",
    requires = {'saadparwaiz1/cmp_luasnip'},
    dependencies = { "rafamadriz/friendly-snippets" }
 },

  -- nvim-cmp for autocompletion
 --  'hrsh7th/nvim-cmp',
 --  'hrsh7th/cmp-nvim-lsp',
 --  'hrsh7th/cmp-buffer',
 --  'hrsh7th/cmp-path',

  -- Set up themes
   'navarasu/onedark.nvim',
   'morhetz/gruvbox',
   { "rafamadriz/friendly-snippets" },
{
  "neovim/nvim-lspconfig", -- REQUIRED: for native Neovim LSP integration
  lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup
  dependencies = {
    -- main one
    { "ms-jpq/coq_nvim", branch = "coq" },

    -- 9000+ Snippets
    { "ms-jpq/coq.artifacts", branch = "artifacts" },

    -- lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
    -- Need to **configure separately**
{ 'ms-jpq/coq.thirdparty', branch = "3p" }
    -- - shell repl
    -- - nvim lua api
    -- - scientific calculator
    -- - comment banner
    -- - etc
  },
  init = function()
    vim.g.coq_settings = {
        auto_start = true, -- if you want to start COQ at startup
        -- Your COQ settings here
    }
  end,
  config = function()
    -- Your LSP settings here
  end,
}
}
