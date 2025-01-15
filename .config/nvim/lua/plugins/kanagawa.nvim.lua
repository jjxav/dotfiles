return {
	'rebelot/kanagawa.nvim',
	opts = {
		theme = 'wave',
		background = {
			dark = "wave"
		},
	},
	init = function()
		vim.cmd("colorscheme kanagawa")
	end,
	config = true,

}
