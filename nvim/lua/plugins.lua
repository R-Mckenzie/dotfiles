local fn = vim.fn

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

  -- Sidepanel
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    tag = 'nightly'
  }

  -- Colorschemes
  use 'morhetz/gruvbox'
	use 'navarasu/onedark.nvim'
  use 'tomasiser/vim-code-dark'


  -- LSP and Autocompletion
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'williamboman/nvim-lsp-installer'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-buffer'
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/cmp-vsnip"
  use "hrsh7th/vim-vsnip"
	use 'onsails/lspkind-nvim'
	use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use "windwp/nvim-ts-autotag"

	use 'preservim/tagbar'
	use 'junegunn/goyo.vim'
	use 'tpope/vim-surround'
	use 'tpope/vim-fugitive'
	use 'airblade/vim-gitgutter'
	use 'nvim-lua/plenary.nvim'
  use 'vimwiki/vimwiki'

  use {
    'prettier/vim-prettier',
    run = 'yarn install',
    ft = {'javascript', 'typescript', 'css', 'less', 'scss', 'graphql', 'typescriptreact', 'html'}
  }
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
	use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/plenary.nvim'}}}
end)
