local packpath = vim.fn.stdpath("data") .. "/site/"
vim.opt.pp:prepend(packpath)

vim.pack.add({
	-- Lualine
	'https://github.com/nvim-tree/nvim-web-devicons', -- deps for nvim-lualine/lualine.nvim
	'https://github.com/nvim-lualine/lualine.nvim',

	-- Theme
	'https://github.com/rebelot/kanagawa.nvim',
}, { load = false })

require('kanagawa').setup {
	theme = 'dragon',
	background = {
		dark = 'dragon',
	},
}
vim.cmd.colorscheme 'kanagawa'
-- transparent background
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'none' })

require('lualine').setup {}
