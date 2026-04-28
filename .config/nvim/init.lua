vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({

	change_detection = {
		notify = false,
	},

	spec = {
		{ import = "plugins" }
	},

	dev = {
		path = '~/plugins.nvim',
		fallback = false,
	},

})

local packpath = vim.fn.stdpath("data") .. "/site/"
vim.opt.pp:prepend(packpath)
vim.pack.add({

	-- Lualine
	'https://github.com/nvim-tree/nvim-web-devicons', -- deps for nvim-lualine/lualine.nvim
	'https://github.com/nvim-lualine/lualine.nvim',

	-- RON file
	'https://github.com/ron-rs/ron.vim',

	-- EWWW config file
	'https://github.com/elkowar/yuck.vim',

	-- EditoConfig tabstop & tabwidth & endofline, etc
	'https://github.com/tpope/vim-sleuth',

	'https://github.com/rebelot/kanagawa.nvim',
})


require('kanagawa').setup({
	theme = 'dragon',
	background = {
		dark = "dragon"
	},
})
vim.cmd.colorscheme("kanagawa")
-- transparent background
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'none' })
require('lualine').setup({})


vim.cmd("packadd! nvim.undotree")
