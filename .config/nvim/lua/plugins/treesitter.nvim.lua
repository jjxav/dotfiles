return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = 'nvim-treesitter.configs',
		opts = {
			ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "html", "angular", "php" },
			auto_install = true,
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			}
		},
	},
	{
		'nvim-treesitter/nvim-treesitter-context',
		opts = {
			enable = true
		}
	}
}
