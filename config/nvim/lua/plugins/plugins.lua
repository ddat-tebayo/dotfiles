return require('packer').startup(function()
	-- Packer manage itself
	use 'wbthomason/packer.nvim'
	-- Colorscheme
	use 'EdenEast/nightfox.nvim'
	-- Dashboard
	use 'goolord/alpha-nvim'
	-- Status bar
	use 'nvim-lualine/lualine.nvim'
end)
