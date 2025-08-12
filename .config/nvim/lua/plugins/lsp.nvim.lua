local servers = {
	clangd = {},
	pyright = {},
	html = { filetypes = { 'html', 'twig', 'hbs' } },
	angularls = { filetypes = { 'angular' } },
	intelephense = {
		stubs = {
			"amqp", "apache", "apcu", "bcmath", "blackfire", "bz2", "calendar", "cassandra",
			"com_dotnet", "Core", "couchbase", "crypto", "ctype", "cubrid", "curl", "date",
			"dba", "decimal", "dom", "ds", "enchant", "Ev", "event", "exif", "fann", "FFI",
			"ffmpeg", "fileinfo", "filter", "fpm", "ftp", "gd", "gearman", "geoip", "geos",
			"gettext", "gmagick", "gmp", "gnupg", "grpc", "hash", "http", "ibm_db2", "iconv",
			"igbinary", "imagick", "imap", "inotify", "interbase", "intl", "json", "judy",
			"ldap", "leveldb", "libevent", "libsodium", "libxml", "lua", "lzf", "mailparse",
			"mapscript", "mbstring", "mcrypt", "memcache", "memcached", "meminfo", "meta",
			"ming", "mongo", "mongodb", "mosquitto-php", "mqseries", "msgpack", "mssql", "mysql",
			"mysql_xdevapi", "mysqli", "ncurses", "newrelic", "oauth", "oci8", "odbc", "openssl",
			"parallel", "Parle", "pcntl", "pcov", "pcre", "pdflib", "PDO", "pdo_ibm", "pdo_mysql",
			"pdo_pgsql", "pdo_sqlite", "pgsql", "Phar", "phpdbg", "posix", "pspell", "pthreads",
			"radius", "rar", "rdkafka", "readline", "recode", "redis", "Reflection", "regex",
			"rpminfo", "rrd", "SaxonC", "session", "shmop", "SimpleXML", "snmp", "soap",
			"sockets", "sodium", "solr", "SPL", "SplType", "SQLite", "sqlite3", "sqlsrv",
			"ssh2", "standard", "stats", "stomp", "suhosin", "superglobals", "svn", "sybase",
			"sync", "sysvmsg", "sysvsem", "sysvshm", "tidy", "tokenizer", "uopz", "uv", "v8js",
			"wddx", "win32service", "winbinder", "wincache", "wordpress", "xcache", "xdebug",
			"xhprof", "xml", "xmlreader", "xmlrpc", "xmlwriter", "xsl", "xxtea", "yaf", "yaml",
			"yar", "zend", "Zend OPcache", "ZendCache", "ZendDebugger", "ZendUtils", "zip",
			"zlib", "zmq", "zookeeper"
		},
		environment = { phpVersion = '8.4.0' }
	},
	rust_analyzer = {},

	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			diagnostics = { disable = { 'missing-fields' } },
		},
	},
}

return {
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			{ 'williamboman/mason.nvim', opts = {} },
			'williamboman/mason-lspconfig.nvim',
			'WhoIsSethDaniel/mason-tool-installer.nvim',

			{ 'j-hui/fidget.nvim',       opts = {} },

			'hrsh7th/cmp-nvim-lsp',

			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
			"jay-babu/mason-nvim-dap.nvim",

		},
		config = function()
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
				nested = true,
				callback = function(event)
					local builtin = require('telescope.builtin')

					local set = function(keys, func, desc, mode)
						mode = mode or 'n'
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
					end

					local register = function(client, bufnr)
						if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_formatting, bufnr) then
							vim.api.nvim_buf_create_user_command(
								bufnr,
								'Format',
								function() vim.lsp.buf.format({ buffer = bufnr }) end,
								{}
							)
							set('<leader>ff', vim.lsp.buf.format, '[F]ile [F]ormat')
						end

						if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_rangeFormatting, bufnr) then
							set('<leader>ff', vim.lsp.buf.format, '[F]ile Range [F]ormat', 'v')
						end

						if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, bufnr) then
							local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

							vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
								buffer = event.buf,
								group = highlight_augroup,
								callback = vim.lsp.buf.document_highlight,
							})
							vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
								buffer = event.buf,
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

						if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, bufnr) then
							set(
								'<leader>th',
								function()
									vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
								end,
								'[T]oggle Inlay [H]ints'
							)
						end
					end

					set('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
					set('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
					set('gr', builtin.lsp_references, '[G]oto [R]eferences')
					set('gI', builtin.lsp_implementations, '[G]oto [I]mplementation')
					set('<leader>D', builtin.lsp_type_definitions, 'Type [D]efinition')
					set('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
					set('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
					set('<leader>cr', vim.lsp.buf.rename, '[C]ursor [R]ename')
					set('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

					local client = vim.lsp.get_client_by_id(event.data.client_id)

					if client then
						register(client, event.buf)
					end

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
				end,
			})

			-- vim.api.nvim_create_autocmd('LspNotify', {
			-- 	callback = function(args)
			-- 		print(vim.inspect(args))
			-- 	end
			-- })

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, { 'stylua' })

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

			require('mason-tool-installer').setup {
				ensure_installed = ensure_installed
			}

			---@diagnostic disable-next-line: missing-fields
			require('mason-lspconfig').setup {
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})

						if server == {} then
							return
						end

						require('lspconfig')[server_name].setup(server)
					end,
				}
			}
		end,
	},

	-- Autocompletion
	{
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		config = function()
			local cmp = require 'cmp'
			cmp.setup {}
		end,
	},
	{
		'saghen/blink.cmp',

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
				default = { 'lsp', 'path', 'snippets', 'buffer' },
			},
		},
		opts_extend = { "sources.default" }
	},

	-- DAP
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"mfussenegger/nvim-dap",
			"williamboman/mason.nvim",
		},
		config = function()
			local dap = require('dap')

			require("mason-nvim-dap").setup({
				ensure_installed = { 'php' },
				automatic_installation = false,
				handlers = {
					function(config)
						require('mason-nvim-dap').default_setup(config)
					end
				}
			})

			dap.configurations.php = {
				{
					type = 'php',
					request = 'launch',
					name = 'Listen for Xdebug for PHP 5.6',
					port = 39056,
				},
				{
					type = 'php',
					request = 'launch',
					name = 'Listen for Xdebug for PHP 7.1',
					port = 39071,
				},
				{
					type = 'php',
					request = 'launch',
					name = 'Listen for Xdebug for PHP 7.4',
					port = 39074,
				},
				{
					type = 'php',
					request = 'launch',
					name = 'Listen for Xdebug for PHP 8.0',
					port = 39080,
				},
				{
					type = 'php',
					request = 'launch',
					name = 'Listen for Xdebug for PHP 8.1',
					port = 39081,
				},
				{
					type = 'php',
					request = 'launch',
					name = 'Listen for Xdebug for PHP 8.2',
					port = 39082,
				},
				{
					type = 'php',
					request = 'launch',
					name = 'Listen for Xdebug for PHP 8.3',
					port = 39083,
				},
				{
					type = 'php',
					request = 'launch',
					name = 'Listen for Xdebug for PHP 8.4',
					port = 39084,
				},
			}
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio"
		},
		config = function()
			local dap = require("dapui")

			dap.setup()

			vim.keymap.set('n', '<leader>do', dap.toggle)
		end,
	},
}
