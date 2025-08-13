vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.loaded_netrw = false
vim.g.loader_netrwPlugin = false

require("lazy-init")
require("keymap")

vim.wo.number = true
vim.wo.relativenumber = true

vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.breakindent = true

vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.wo.signcolumn = 'yes'

vim.o.completeopt = 'menuone,noselect'

vim.o.termguicolors = true

vim.g.editorconfig = true

vim.g.shiftwidth = 1
vim.g.autoindent = true
vim.g.smartindent = false

vim.o.scrolloff = 4

vim.o.foldenable = false
vim.o.foldlevel = 100

vim.o.wrap = false
vim.o.breakindent = true
vim.o.showbreak = ''

vim.opt.list = true
vim.opt.listchars = { tab = '   ', trail = '·', nbsp = '␣' }

vim.opt.inccommand = 'split'

vim.opt.cursorline = true

vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = true,
	severity_sort = true,
})

vim.o.textwidth = 120
-- vim.o.colorcolumn = "100"

-- transparent background
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'none' })

