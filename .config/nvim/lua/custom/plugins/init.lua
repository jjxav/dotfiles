--
-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {

	{
		'echasnovski/mini.base16'
	},

	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-tree.lua",
		},
		config = function()
			require("lsp-file-operations").setup()
		end,
	},

	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup {
				actions = {
					open_file = {
						quit_on_open = true,
					}
				},
				on_attach = function(bufnr)
					local api = require "nvim-tree.api"
					local tree = require "nvim-tree"

					local function opts(desc)
						return { desc = desc }
					end

					api.config.mappings.default_on_attach(bufnr)


					vim.keymap.set('n', '<leader>ff', api.tree.open, opts('Focus file tree'))
					vim.keymap.set('n', '<leader>fq', api.tree.close, opts('Close file tree'))
					vim.keymap.set('n', '<leader>fc', api.fs.create, opts('Create file'))
					vim.keymap.set('n', '<leader>fd', api.fs.remove, opts('Delete file'))

					-- api.actions.open_file.quit_on_open = true
				end
			}
		end,
	},

	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},

	require("custom.plugins.harpoonConfig"),
	require("custom.plugins.lazygit")
}
