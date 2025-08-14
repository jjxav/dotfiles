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
		local set = require('jjxav.helper').keymap.set

		set('<leader>gbt', blame.toggle, '[G]it [B]lame [T]oggle')
		set('<leader>gbc', blame.copy_sha_to_clipboard, '[G]it [B]lame [C]opy SHA')
	end,

}
