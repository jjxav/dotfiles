return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{
			"telescope.multigrep.nvim",
			name = "telescope.multigrep.nvim",
			dev = true,
		},
	},
	config = function()
		local builtin = require 'telescope.builtin'
		local multigrep = require 'telescope.multigrep.builtin'
		local set = require('jjxav.helper').keymap.set

		set('<leader>sh', builtin.help_tags, '[S]earch [H]elp')
		set('<leader>ss', builtin.builtin, '[S]earch [S]elect Telescope')

		set('<leader>D', builtin.diagnostics, '[S]earch [D]iagnostics')

		set('<leader>sk', builtin.keymaps, '[S]earch [K]eymaps')
		set('<leader>sf', builtin.find_files, '[S]earch [F]iles')
		set('<leader>gf', builtin.git_files, 'Search [G]it [F]iles')
		set('<leader>sw', builtin.grep_string, '[S]earch current [W]ord')
		set('<leader>sg', builtin.live_grep, '[S]earch by [G]rep')
		set('<leader>sr', builtin.resume, '[S]earch [R]esume')
		set('<leader>s.', builtin.oldfiles, '[S]earch Recent Files ("." for repeat)')

		set('<leader><leader>', builtin.buffers, '[ ] Find existing buffers')
		set('<leader>/', builtin.current_buffer_fuzzy_find, '[S]earch in file')

		set('<leader>smg', multigrep.live_multigrep, '[S]earch [M]ulti[G]rep')
	end,
}
