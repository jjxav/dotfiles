return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		vim.keymap.set("n", "<leader>ya", function() harpoon:list():add() end, { desc = "[A]ppend" })
		vim.keymap.set("n", "<leader>yd", function() harpoon:list():remove() end, { desc = "[D]elete" })
		vim.keymap.set("n", "<leader>yc", function() harpoon:list():clear() end, { desc = "[C]lear" })

		vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "" })

		-- vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
		-- vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
		-- vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
		-- vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<A-n>", function() harpoon:list():prev() end, { desc = "" })
		vim.keymap.set("n", "<A-m>", function() harpoon:list():next() end, { desc = "" })
	end,
}
