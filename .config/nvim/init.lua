vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local helper_path = vim.fs.normalize '~/plugins.nvim/helper.nvim'
local switcher_path = vim.fs.normalize '~/plugins.nvim/switcher.nvim'
vim.opt.rtp:prepend(helper_path)
vim.opt.rtp:prepend(switcher_path)

local packpath = vim.fn.stdpath("data") .. "/site/"
vim.opt.pp:prepend(packpath)

vim.pack.add({

	-- RON file
	'https://github.com/ron-rs/ron.vim',

	-- EWWW config file
	'https://github.com/elkowar/yuck.vim',

	-- EditoConfig tabstop & tabwidth & endofline, etc
	'https://github.com/tpope/vim-sleuth',
})

vim.cmd.packadd("nvim.undotree")

