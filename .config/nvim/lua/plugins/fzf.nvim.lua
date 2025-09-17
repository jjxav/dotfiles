return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local set = require('jjxav.helper').keymap.set;
		local builtin = require('fzf-lua')

		set('<leader>sh', builtin.help_tags, '[S]earch [H]elp')
		set('<leader>ss', builtin.builtin, '[S]earch [S]elect Telescope')

		set('<leader>sk', builtin.keymaps, '[S]earch [K]eymaps')
		set('<leader>sf', builtin.files, '[S]earch [F]iles')
		set('<leader>gf', builtin.git_files, 'Search [G]it [F]iles')
		set('<leader>sw', builtin.grep_cword, '[S]earch current [W]ord', { 'n', 'v' })
		set('<leader>sg', builtin.live_grep, '[S]earch by [G]rep')
		set('<leader>sr', builtin.resume, '[S]earch [R]esume')
		set('<leader>s.', builtin.oldfiles, '[S]earch Recent Files ("." for repeat)')

		set('<leader>gc', builtin.git_commits, '[S]earch [G]it [C]ommit')
		set('<leader>gh', builtin.git_bcommits, '[S]earch [G]it Commit for Buffer')

		set('<leader><leader>', builtin.buffers, '[ ] Find existing buffers')
		set('<leader>/', builtin.blines, '[S]earch in file')
	end,
}
