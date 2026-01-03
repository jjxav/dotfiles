return {
	{
		'neovim/nvim-lspconfig',
		enabled = true,
		dependencies = {
			{ 'mason-org/mason.nvim', opts = {} },
			'mason-org/mason-lspconfig.nvim',
			{ 'WhoIsSethDaniel/mason-tool-installer.nvim', opts = {} },
			{ 'j-hui/fidget.nvim', opts = {} },
			{ 'hrsh7th/cmp-nvim-lsp', opts = {} },
			'fzf-lua'
		},
		config = function()
			vim.keymap.del('n', 'grn')
			vim.keymap.del({ 'n', 'v' }, 'gra')
			vim.keymap.del('n', 'grr')
			vim.keymap.del('n', 'gri')
			vim.keymap.del('n', 'grt')

			local builtin = require('fzf-lua')
			local servers = require('lsp/init')

			local register = function(client, bufnr)
				local set = function(keys, func, desc, mode)
					local _set = require('jjxav.helper').keymap.set
					_set(keys, func, 'LSP: ' .. desc, mode, { buffer = bufnr })
				end

				if not client then
					return
				end

				if client:supports_method(vim.lsp.protocol.Methods.textDocument_formatting, bufnr) then
					vim.api.nvim_buf_create_user_command(
						bufnr,
						'Format',
						function() vim.lsp.buf.format({ buffer = bufnr }) end,
						{}
					)
					set('<leader>ff', vim.lsp.buf.format, '[F]ile [F]ormat')
				end

				if client:supports_method(vim.lsp.protocol.Methods.textDocument_rangeFormatting, bufnr) then
					set('<leader>ff', vim.lsp.buf.format, '[F]ile Range [F]ormat', 'v')
				end

				if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, bufnr) then
					local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

					vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
						buffer = bufnr,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
						buffer = bufnr,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd('LspDetach', {
						group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
						end,
					})
				end

				if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, bufnr) then
					set(
						'<leader>th',
						function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr })
						end,
						'[T]oggle Inlay [H]ints'
					)
				end

				if client:supports_method(vim.lsp.protocol.Methods.textDocument_foldingRange, bufnr) then
					-- vim.o.foldmethod = 'expr'
					-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"
				else
					-- vim.o.foldmethod = 'manual'
				end

				if client:supports_method(vim.lsp.protocol.Methods.textDocument_rename, bufnr) then
					set('<leader>cr', vim.lsp.buf.rename, '[C]ursor [R]ename')
				end

				if client:supports_method(vim.lsp.protocol.Methods.textDocument_codeAction, bufnr) then
					set('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
				end

				if client:supports_method(vim.lsp.protocol.Methods.workspace_symbol, bufnr) then
					set('<leader>ws', builtin.lsp_workspace_symbols, '[W]orkspace [S]ymbols')
				end

				if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentSymbol, bufnr) then
					set('<leader>sd', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
				end

				if client:supports_method(vim.lsp.protocol.Methods.textDocument_definition, bufnr) then
					set('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
				end

				if client:supports_method(vim.lsp.protocol.Methods.textDocument_typeDefinition, bufnr) then
					set('<leader>D', builtin.lsp_definitions, 'Type [D]efinition')
				end

				if client:supports_method(vim.lsp.protocol.Methods.textDocument_declaration, bufnr) then
					set('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
				end

				if client:supports_method(vim.lsp.protocol.Methods.textDocument_implementation, bufnr) then
					set('gI', builtin.lsp_implementations, '[G]oto [I]mplementation')
				end

				if client:supports_method(vim.lsp.protocol.Methods.textDocument_references, bufnr) then
					set('gr', builtin.lsp_references, '[G]oto [R]eferences')
				end

				if client:supports_method(vim.lsp.protocol.Methods.textDocument_diagnostic, bufnr) then
					set('<leader>D', builtin.diagnostics_document, '[S]earch [D]iagnostics')
				end

				if client:supports_method(vim.lsp.protocol.Methods.textDocument_switch, bufnr) then
					set('K', function()
						vim.lsp.buf.hover({
							close_events = { 'CursorMoved', 'CursorMovedI', 'InsertCharPre', 'BufHidden' }
						})
					end, '[S]earch [D]iagnostics')
				end

				if client:supports_method("textDocument_switchSourceHeader", bufnr) then
					-- set('<A-o>', "<cmd>LspClangdSwitchSourceHeader<cr>", '[S]earch [D]iagnostics')
				end

				-- maybe textDocument_inlayHint, textDocument_signatureHelp
			end


			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
				nested = true,
				callback = function(event)
					-- local lsp_builtin = vim.lsp.buf

					-- Mapping to remove to be mapped else where
					--[[
					- "grn" is mapped in Normal mode to |vim.lsp.buf.rename()|
					- "gra" is mapped in Normal and Visual mode to |vim.lsp.buf.code_action()|
					- "grr" is mapped in Normal mode to |vim.lsp.buf.references()|
					- "gri" is mapped in Normal mode to |vim.lsp.buf.implementation()|
					- "grt" is mapped in Normal mode to |vim.lsp.buf.type_definition()|
					- "gO" is mapped in Normal mode to |vim.lsp.buf.document_symbol()|
					- CTRL-S is mapped in Insert mode to |vim.lsp.buf.signature_help()|
					]]

					local client = vim.lsp.get_client_by_id(event.data.client_id)

					if client then
						register(client, event.buf)
					end
				end,
			})

			vim.api.nvim_create_autocmd('LspNotify', {
				callback = function()
				end,
			})

			-- Add a handler for when a LSP add capability after attaching
			vim.lsp.handlers['client/registerCapability'] = (function(overridden)
				return function(err, res, ctx)
					local result = overridden(err, res, ctx)
					local handler_client = vim.lsp.get_client_by_id(ctx.client_id)
					if not handler_client then
						return
					end
					for bufnr, _ in pairs(handler_client.attached_buffers) do
						register(handler_client, bufnr)
					end
					return result
				end
			end)(vim.lsp.handlers['client/registerCapability'])

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, { 'stylua' })

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

			require('mason-tool-installer').setup {
				ensure_installed = ensure_installed
			}
			--
			-- require('mason-lspconfig').setup {
			--
			-- }

			for server_name, _ in pairs(servers) do
				local server = servers[server_name] or {}
				server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})

				vim.lsp.config(server_name, server)
				vim.lsp.enable(server_name)
			end

			require('mason-lspconfig').setup {}
		end,
	},

	-- Autocompletion
	{
		'saghen/blink.cmp',
		dependencies = {
			{
				'hrsh7th/nvim-cmp',
				enabled = true,
				event = 'InsertEnter',
				config = function()
					local cmp = require 'cmp'
					cmp.setup {}
				end,
			},

		},

		-- use a release tag to download pre-built binaries
		version = '*',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { preset = 'default' },
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = 'mono'
			},
			sources = {
				default = { 'lsp', 'path', 'buffer' }, -- 'snippets', 
			},
		},
		opts_extend = { "sources.default" }
	},
}
