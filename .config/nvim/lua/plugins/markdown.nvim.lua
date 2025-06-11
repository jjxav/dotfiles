return {
	'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    opts = {
		-- preset = 'lazy'
		heading = {
			-- position = 'inline',
			width = { 'full', 'full', 'block', 'block', 'block', 'block' },
			border = true,
			border_virtual = true,
		},
		indent = {
			enabled = true,
			skip_heading = true,
			icon = ' ',
		},
		code = {
			border = 'thick',
		}
	},

}
