
-- TODO: Add more server
local servers = {
	lua_ls = {

	}
}

return {
	{
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		'folke/lazydev.nvim',
		ft = 'lua',
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = 'luvit-meta/library', words = { 'vim%.uv' } },
			},
		},
	},
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			{ 'williamboman/mason.nvim', opts = {} },
			'williamboman/mason-lspconfig.nvim',
			'WhoIsSethDaniel/mason-tool-installer.nvim',

			{ 'j-hui/fidget.nvim', opts = {} },

			'hrsh7th/cmp-nvim-lsp',
		},
		config = function ()
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
				callback = function(event)
				end,
			})

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, { 'stylua' })

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

			require('mason-tool-installer').setup {
				ensure_installed = ensure_installed
			}

			require('mason-lspconfig').setup {
				handlers = {
					function (server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})

						require('lspconfig')[server_name].setup(server)
					end,
				}
			}
		end,
	},

	{
		-- Autocompletion
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		config = function ()
			local cmp = require 'cmp'
			cmp.setup {

			}
		end,
	},
}
