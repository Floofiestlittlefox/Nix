local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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
require("lazy").setup({
	'nvim-lualine/lualine.nvim',  
	'nvim-telescope/telescope.nvim', tag = '0.1.6', 
	'nvim-lua/plenary.nvim',
	'nvim-tree/nvim-web-devicons',
	'nvim-treesitter/nvim-treesitter',
	'nvim-telescope/telescope-bibtex.nvim',
	'SirVer/ultisnips',
	'lervag/vimtex',
	'nvim-lualine/lualine.nvim',
	'NeogitOrg/neogit',config = true,
	"sindrets/diffview.nvim",
	"Zane-/cder.nvim",
	"kaarmu/typst.vim",
	"williamboman/mason-lspconfig.nvim",
	"williamboman/mason.nvim",
	"neovim/nvim-lspconfig",
})
require("neogit").setup {}
