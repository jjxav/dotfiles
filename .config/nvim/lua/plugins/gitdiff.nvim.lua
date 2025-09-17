return {
	'sindrets/diffview.nvim',
	disabled = true,
	config = function()
		local diffview = require('diffview')
		local set = require('jjxav.helper').keymap.set

		set('<leader>gdo', diffview.open, '[G]it [D]iff [O]pen')
		set('<leader>gdc', diffview.close, '[G]it [D]iff [C]lose')
	end,
}
