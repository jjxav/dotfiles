vim.pack.add({
	'https://github.com/nvim-treesitter/nvim-treesitter',
	'https://github.com/nvim-mini/mini.icons',
	'https://github.com/nvim-lua/plenary.nvim',
}, { load = false })

vim.pack.add({
	'https://github.com/MeanderingProgrammer/render-markdown.nvim',
})

local tree = require 'nvim-treesitter'

tree.setup()
tree.install {
	'angular',
	'bash',
	'c',
	'cpp',
	'go',
	'html',
	'javascript',
	'json',
	'jsx',
	'lua',
	'markdown',
	'php',
	'python',
	'rust',
	'typescript',
}

require('render-markdown').setup({
	-- preset = 'lazy'
	heading = {
		-- position = 'inline',
		width = { 'full', 'full', 'block', 'block', 'block', 'block' },
		border = true,
		border_virtual = true,
		above = ' ',
		below = ' ',
		backgrounds = {},
	},
	indent = {
		enabled = true,
		skip_heading = true,
		icon = ' ',
	},
	code = {
		border = 'thick',
		disable_background = true,
	}
})

vim.api.nvim_create_autocmd('FileType', {
	callback = function(arg)
		local type = arg.match

		local installed = tree.get_installed()
		local treesitter_ready = vim.tbl_contains(installed, type)

		if treesitter_ready and vim.treesitter.start then
			local win_id = vim.api.nvim_get_current_win()

			vim.treesitter.start(arg.buf, type)
			vim.bo[arg.buf].syntax = 'on'
			vim.wo[win_id][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
			vim.wo[win_id][0].foldmethod = 'expr'
		end
	end,
})

