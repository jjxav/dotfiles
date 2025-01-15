return {
	'rebelot/kanagawa.nvim',
	opts = {
		theme = 'dragon',
		background = {
			dark = "dragon"
		},
	},
	init = function()
		vim.cmd("colorscheme kanagawa")
	end,
	config = true,

}
