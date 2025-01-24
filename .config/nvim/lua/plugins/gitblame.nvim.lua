return {
	"f-person/git-blame.nvim",

	event = "VeryLazy",
	opts = {
		enabled = true, -- if you want to enable the plugin
		message_template = "  <date> • <author> • <summary> • <<sha>>", -- template for the blame message, check the Message template section for more options
		date_format = "%Y-%m-%d (%a) %H:%M:%S", -- template for the date, check Date format section for more options
		virtual_text_column = nil, -- virtual text start column, check Start virtual text at column section for more options
	},
	config = function()
		local blame = require('gitblame')

		vim.keymap.set('n', '<leader>gbt', blame.toggle, { desc = '[G]it [B]lame [T]oggle' })
		vim.keymap.set('n', '<leader>gbc', blame.copy_sha_to_clipboard, { desc = '[G]it [B]lame [C]opy SHA' })
	end,

}
