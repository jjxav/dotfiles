return {
	{
		"kdheepak/lazygit.nvim",
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		init = function()
			vim.keymap.set('n', '<leader>gg', 'gg :LazyGit\n')
		end,
	},
}
