return {
	'rebelot/kanagawa.nvim',
	opts = {
		theme = 'wave',
		background = {
			dark = "dragon"
		},
	},
	init = function ()
		vim.cmd("colorscheme kanagawa")
	end,
	config = true,

}
