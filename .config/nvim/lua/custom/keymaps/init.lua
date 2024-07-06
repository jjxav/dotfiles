
vim.keymap.set('n', '<leader>fp', vim.cmd.bprevious, { desc = 'Go to previous buffer' })
vim.keymap.set('n', '<leader>fn', vim.cmd.bnext, { desc = 'Go to next buffer' })

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('v', '<leader>p', '"_dP')

vim.keymap.set('n', '<leader>ch', vim.lsp.buf.hover, { desc = 'Get cursor information' })

