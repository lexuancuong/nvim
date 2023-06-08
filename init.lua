-- Load Lazy as a plugins manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, 'lazy')
if not status_ok then
  return
end

lazy.setup({
  spec = {
    { 'folke/tokyonight.nvim' },

    { 'lewis6991/impatient.nvim' },

    { 'kyazdani42/nvim-web-devicons' },

    { 'nvim-lualine/lualine.nvim' },

    -- Show function and method under the current cursor
    {'SmiteshP/nvim-navic'},

    {
      'akinsho/bufferline.nvim',
      dependencies = { 'kyazdani42/nvim-web-devicons' },
    },

    {
      'lukas-reineke/indent-blankline.nvim',
    },

    {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
    },

    {
      'lewis6991/gitsigns.nvim',
      lazy = true,
      dependencies = {
        'nvim-lua/plenary.nvim',
        'kyazdani42/nvim-web-devicons',
      },
      config = function()
        require('gitsigns').setup{}
      end
    },

    { 'williamboman/nvim-lsp-installer' },

    { 'neovim/nvim-lspconfig' },

    { 'ray-x/lsp_signature.nvim' },

    { 'jose-elias-alvarez/null-ls.nvim' },

    { 'andymass/vim-matchup' },

    { 'rafamadriz/friendly-snippets' },

    -- Coplilot stuff
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      config = function()
        require('copilot').setup({
          suggestion = { enabled = false },
          panel = { enabled = false },
          filetypes = {
            python = true,
            ["."] = false,
          },
        })
      end,
    },
    {
      "zbirenbaum/copilot-cmp",
      dependencies = {'zbirenbaum/copilot.lua'},
      config = function ()
        require("copilot_cmp").setup()
      end
    },
    {
      'hrsh7th/nvim-cmp',
      -- load cmp on InsertEnter
      event = 'InsertEnter',
      -- these dependencies will only be loaded when cmp loads
      -- dependencies are always lazy-loaded unless specified otherwise
      dependencies = {
        'L3MON4D3/LuaSnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'saadparwaiz1/cmp_luasnip',
        'zbirenbaum/copilot-cmp',
        'zbirenbaum/copilot.lua',
      },
    },

    {
      'iamcco/markdown-preview.nvim',
      run = function() vim.fn["mkdp#util#install"]() end,
    },

    { 'goolord/alpha-nvim' },

    { 'numToStr/Comment.nvim' },

    {
      'kyazdani42/nvim-tree.lua',
      dependencies = { 'kyazdani42/nvim-web-devicons' },
    },

    { 'nvim-telescope/telescope.nvim' },

    {
      'phaazon/hop.nvim',
       config = function()
         require("hop").setup({keys = 'etovxqpdygfblzhckisuran'})
       end,
    },

    {
      'windwp/nvim-autopairs',
      event = 'InsertEnter',
      config = function()
        require('nvim-autopairs').setup{
         fast_wrap = {},
         disable_filetype = { "TelescopePrompt", "vim" },
        }
      end
    },

    {
      'windwp/nvim-spectre',
      lazy = true,
      dependencies = {
        'nvim-lua/plenary.nvim',
        'kyazdani42/nvim-web-devicons',
      },
    },

    {
      'ruifm/gitlinker.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim',
      },
    },

    -- {"ellisonleao/glow.nvim", config = true, cmd = "Glow"},
    {
      'kdheepak/lazygit.nvim'
    },
    {
      'alexghergh/nvim-tmux-navigation',
      config = function()
        require('nvim-tmux-navigation').setup{}
      end
    }
  },
})
for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath('config')..'/lua/core', [[v:val =~ '\.lua$']])) do
  require('core.'..file:gsub('%.lua$', ''))
end

for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath('config')..'/lua/plugins', [[v:val =~ '\.lua$']])) do
  require('plugins.'..file:gsub('%.lua$', ''))
end
