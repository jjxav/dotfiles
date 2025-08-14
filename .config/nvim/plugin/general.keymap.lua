local set = require('jjxav.helper').keymap.set

set('<leader>fp', vim.cmd.bprevious, 'Go to previous buffer')
set('<leader>fn', vim.cmd.bnext, 'Go to next buffer')

set('<C-d>', '<C-d>zz')
set('<C-u>', '<C-u>zz')

set('<leader>p', '"_dP', '[P]ut without replacing yank', { 'v' })

set('<ESC>', '<cmd>nohlsearch<CR>', 'Clear search result', { 'n' })

set('<leader>fc', '<cmd>let @+=@%<CR>', '[F]ile Path [C]opy Cliboard')

set('<A-N>', '<cmd>cp<CR>')
set('<A-M>', '<cmd>cn<CR>')

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
