return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		branch = 'main',
		build = ":TSUpdate",
		config = function()
			require 'nvim-treesitter'.setup()

			vim.api.nvim_create_autocmd('FileType', {
				callback = function()
					local parser = vim.treesitter.get_parser(nil, nil, {
						error = false,
					})

					if parser and vim.treesitter.start then
						vim.treesitter.start()
					end
				end
			})
		end
		-- opts = {
		-- 	ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "html", "angular", "php" },
		-- 	auto_install = true,
		-- 	highlight = {
		-- 		enable = true,
		-- 	},
		-- 	indent = {
		-- 		enable = true,
		-- 	}
		-- },
	},
	{
		'nvim-treesitter/nvim-treesitter-context',
		opts = {
			enable = true
		}
	}
}
