return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		spec = {
			{ '<leader>f',  group = '[F]ile',        mode = nil },
			{ '<leader>g',  group = '[G]it',         mode = nil },
			{ '<leader>c',  group = '[C]ode',        mode = nil },
			{ '<leader>d',  group = '[D]ocument',    mode = nil },
			{ '<leader>t',  group = '[T]oggle',      mode = nil },
			{ '<leader>w',  group = '[W]orspace',    mode = nil },
			{ '<leader>gb', group = '[G]it [B]lame', mode = nil },
			{ '<leader>gb', group = '[G]it [D]iff',  mode = nil },
			{ '<leader>h', group = 'Git [H]unk',  mode = nil },
			{ '<leader>l',  group = '[L]ua',         mode = nil },
			{ '<leader>y',  group = 'Harpoon',       mode = nil },
			{ '<leader>s',  group = '[S]earch',      mode = nil },
			{ '<leader>sm', group = '[M]ulti',       mode = nil },
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
