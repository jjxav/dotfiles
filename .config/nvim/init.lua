vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disabled netrw for file-tree
vim.g.loaded_netrw = false
vim.g.loader_netrwPlugin = false

require("lazy-init")

vim.wo.number = true
vim.wo.relativenumber = true

-- Decrease update time
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

vim.wo.wrap = false

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true
