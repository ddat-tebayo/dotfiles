return require('packer').startup(function()
	-- Packer manage itself
	use 'wbthomason/packer.nvim'
	-- Colorscheme
	use 'folke/tokyonight.nvim'
	-- Icons
	use 'nvim-tree/nvim-web-devicons'
	-- Dashboard
	use 'goolord/alpha-nvim'
	-- Status bar
	use 'nvim-lualine/lualine.nvim'
	-- Tab bar
	use 'akinsho/bufferline.nvim'
	-- Discord Rich Presence
	use 'andweeb/presence.nvim'
end)
