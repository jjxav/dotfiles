return {
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		enabled = true,
		branch = 'main',
		build = ':TSUpdate',
		config = function()
			require('nvim-treesitter').setup()

			require('nvim-treesitter').install {
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

			local tree = require 'nvim-treesitter'

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
		end,
	},
	{
		'nvim-treesitter/nvim-treesitter-context',
		opts = {
			enable = true,
		},
	},
}
