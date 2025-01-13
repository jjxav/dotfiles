return {
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			{ 'williamboman/mason.nvim', opts = {} },
			'williamboman/mason-lspconfig.nvim',
			'WhoIsSethDaniel/mason-tool-installer.nvim',

			{ 'j-hui/fidget.nvim', opts = {} },

			-- 'hrsh7th/cmp-nvim-lsp',
		},
		config = function ()
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('jjxav-lsp-attach', { clear = true }),
				callback = function(event)
				end,
			})

			local servers = {
				lua_ls = {
				}
			}
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, { 'stylua' })

			require('mason-tool-installer').setup {
				ensure_installed = ensure_installed
			}

			require('mason-lspconfig').setup {
				handlers = {
					function (server_name)
						local server = servers[server_name] or {}
						require('lspconfig')[server_name].setup(server)
					end,
				}
			}
		end,

	},
}
