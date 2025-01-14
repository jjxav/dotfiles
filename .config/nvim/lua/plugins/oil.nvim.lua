return {
	'stevearc/oil.nvim',
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	config = function ()
		local builtin = require("oil")
		local set = vim.keymap.set

		builtin.setup({
			view_options = {
				show_hidden = true,
			},
		})

		set('n', '-', ':Oil<CR>', { desc = '[C]urrent [D]ir' })
	end,
}
