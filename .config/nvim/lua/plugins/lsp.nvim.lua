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

			{ 'j-hui/fidget.nvim',       opts = {} },

			'hrsh7th/cmp-nvim-lsp',
		},
		config = function()
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
				callback = function(event)
					local builtin = require('telescope.builtin')

					local set = function(keys, func, desc, mode)
						mode = mode or 'n'
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
					end

					set('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
					set('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
					set('gr', builtin.lsp_references, '[G]oto [R]eferences')
					set('gI', builtin.lsp_implementations, '[G]oto [I]mplementation')
					set('<leader>D', builtin.lsp_type_definitions, 'Type [D]efinition')
					set('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
					set('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
					set('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
					set('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

					local client = vim.lsp.get_client_by_id(event.data.client_id)

					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_formatting) then
						set('<leader>ff', vim.lsp.buf.format, '[F]ile [F]ormat')
						vim.api.nvim_buf_create_user_command(event.buf, 'Format',
							function() vim.lsp.buf.format({ buffer = event.buf }) end, {})
					end

					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
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


					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
						set('<leader>th',
							function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end,
							'[T]oggle Inlay [H]ints')
					end
				end,
			})

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
	}
}
