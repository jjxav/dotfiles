require("keymap.lua-exec")
require("keymap.chmod")

local set = function(keys, func, desc, mode, opts)
	local desc_option = { desc = desc }
	mode = mode or 'n'
	opts = opts or {}

	opts = vim.tbl_extend('error', opts, desc_option)

	vim.keymap.set(mode, keys, func, opts)
end

set('<leader>fp', vim.cmd.bprevious, 'Go to previous buffer')
set('<leader>fn', vim.cmd.bnext, 'Go to next buffer')

set('<C-d>', '<C-d>zz')
set('<C-u>', '<C-u>zz')

set('<leader>p', '"_dP', '[P]ut without replacing yank', { 'v' })

set('<ESC>', '<cmd>nohlsearch<CR>', 'Clear search result', { 'n' })

set('<leader>fc', '<cmd>let @+=@%<CR>', '[F]ile Path [C]opy Cliboard')

set(
	'<leader>cd',
	function()
		vim.diagnostic.open_float({
			scope = 'line'
		})
	end,
	'[C]ode toggle [D]iagnostic'
)

set(
	'<leader>dw',
	function()
		vim.o.wrap = not vim.o.wrap
		vim.o.linebreak = vim.o.wrap
	end,
	'[D]ocument Toggle [W]rap'
);
