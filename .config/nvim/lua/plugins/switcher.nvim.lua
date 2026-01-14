return {
	'switcher.nvim',
	name = 'switcher.nvim',
	dev = true,
	config = function()
		local set = require('jjxav.helper').keymap.set
		local switcher = require('jjxav.switcher').setup {
			cpp = {
				'cpp',
				'h',
				'hpp',
			},
		}

		set('<A-o>', function() switcher.switch() end, 'Switch file extention', { 'n' }
	)
	-- vim.keymap.set('n', '<A-o>', '<cmd>JSwitch<cr>')
end,
}
