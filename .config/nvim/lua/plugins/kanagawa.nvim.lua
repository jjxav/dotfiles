return {
	'https://github.com/rebelot/kanagawa.nvim',
	opts = {
		theme = 'dragon',
		background = {
			dark = "dragon"
		},
	},
	enabled = false,
	init = function()
		vim.cmd("colorscheme kanagawa")
	end,
	config = true,

}
