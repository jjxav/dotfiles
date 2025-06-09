require("keymap.lua-exec")
require("keymap.chmod")

local set = function(keys, func, desc, mode)
	mode = mode or 'n'
	vim.keymap.set(mode, keys, func, { desc = desc })
end

set('<leader>fp', vim.cmd.bprevious, 'Go to previous buffer')
set('<leader>fn', vim.cmd.bnext, 'Go to next buffer')

set('<C-d>', '<C-d>zz')
set('<C-u>', '<C-u>zz')

set('<leader>p', '"_dP', '[P]ut without replacing yank', { 'v' })

set('<ESC>', '<cmd>nohlsearch<CR>', 'Clear search result', { 'n' })

set('<leader>fc', '<cmd>let @+=@%<CR>', '[F]ile Path [C]opy Cliboard')


set(
	'<leader>d',
	function()
		vim.diagnostic.open_float({
			scope = 'line'
		})
	end
)
