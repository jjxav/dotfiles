return {
	{
		'numToStr/Comment.nvim',
		opts = {
			-- add any options here
		}
	},
	{
		'folke/todo-comments.nvim',
		event = 'VimEnter',
		dependencies = { 'nvim-lua/plenary.nvim' },
		opts = { signs = false }
	},
}

