return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		local set = require('jjxav.helper').keymap.set

		set("<leader>ya", function() harpoon:list():add() end, "[A]ppend")
		set("<leader>yd", function() harpoon:list():remove() end, "[D]elete")
		set("<leader>yc", function() harpoon:list():clear() end, "[C]lear")

		set("<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

		-- Toggle previous & next buffers stored within Harpoon list
		set("<A-n>", function() harpoon:list():prev() end)
		set("<A-m>", function() harpoon:list():next() end)
	end,
}
