return {
	'stevearc/oil.nvim',
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	config = function()
		local builtin = require("oil")
		local set = vim.keymap.set

		builtin.setup({
			view_options = {
				show_hidden = true,
				is_always_hidden = function(name, bufnr)
					return name == '..' or name == '.git'
				end,
			},
			constrain_cursor = "name",
			watch_for_changes = true,
		})

		set('n', '-', ':Oil<CR>', { desc = '[C]urrent [D]ir' })
	end,
}
