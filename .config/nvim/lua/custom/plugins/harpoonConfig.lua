
return {
    'ThePrimeagen/harpoon',
    dependencies = {
	"nvim-lua/plenary.nvim",
    },
    config = function()
	local mark = require "harpoon.mark"
	local ui = require "harpoon.ui"
	vim.keymap.set('n', '<leader>ha', mark.add_file, { desc = "Add file to harpoon" })

	vim.keymap.set('n', '<leader>ho', ui.toggle_quick_menu, { desc = "Open quick menu" })
	vim.keymap.set('n', '<leader>hn', ui.nav_next, { desc = "Next file" })
	vim.keymap.set('n', '<leader>hp', ui.nav_prev, { desc = "Previous file" })

	-- require('telescope').load_extension('telescope')
    end,
}

