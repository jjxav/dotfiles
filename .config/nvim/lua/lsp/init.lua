return {
	clangd = {},
	pyright = {},
	html = {},
	angularls = {},
	eslint = {
		settings = {
			experimental = {
				useFlatConfig = false
			},
		},
	},
	intelephense = {
		environment = {
			phpVersion = "8.5.0"
		}
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
