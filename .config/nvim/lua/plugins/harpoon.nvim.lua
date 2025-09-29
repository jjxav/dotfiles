return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		local set = require('jjxav.helper').keymap.set

		set("<A-a>", function() harpoon:list():add() end, "[A]ppend")
		set("<A-d>", function() harpoon:list():remove() end, "[D]elete")
		set("<A-c>", function() harpoon:list():clear() end, "[C]lear")

		set("<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

		set("<A-Q>", function() harpoon:list():replace_at(1) end)
		set("<A-W>", function() harpoon:list():replace_at(2) end)
		set("<A-E>", function() harpoon:list():replace_at(3) end)
		set("<A-R>", function() harpoon:list():replace_at(4) end)

		set("<A-q>", function() harpoon:list():select(1) end)
		set("<A-w>", function() harpoon:list():select(2) end)
		set("<A-e>", function() harpoon:list():select(3) end)
		set("<A-r>", function() harpoon:list():select(4) end)

		-- Toggle previous & next buffers stored within Harpoon list
		set("<A-n>", function() harpoon:list():prev() end)
		set("<A-m>", function() harpoon:list():next() end)
	end,
}
