vim.pack.add({
	'http://github.com/saghen/blink.lib',
	'https://github.com/hrsh7th/nvim-cmp',
	'https://github.com/saghen/blink.cmp',
}, { load = false })

require('cmp').setup({})
local cmp = require('blink-cmp')
cmp.build():wait(60000)
cmp.setup({
	keymap = { preset = 'default' },
	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = 'mono'
	},
	sources = {
		default = { 'lsp', 'path', 'buffer' }, -- 'snippets', 
	},
})

