return {
	-- DAP
	{
		"jay-babu/mason-nvim-dap.nvim",
		disabled = true,
		dependencies = {
			{
				"williamboman/mason.nvim",
				dependencies = {
					"mfussenegger/nvim-dap",
					"jay-babu/mason-nvim-dap.nvim",

				}
			},
			{
				"rcarriga/nvim-dap-ui",
				dependencies = {
					"mfussenegger/nvim-dap",
					"nvim-neotest/nvim-nio"
				},
				config = function()
					local dap = require("dapui")

					dap.setup()

					local set = require('jjxav.helper').keymap.set
					set('<leader>do', dap.toggle)
				end,
			},
		},
		config = function()
			local dap = require('dap')

			require("mason-nvim-dap").setup({
				ensure_installed = { 'php' },
				automatic_installation = false,
				handlers = {
					function(config)
						require('mason-nvim-dap').default_setup(config)
					end
				}
			})

			dap.configurations.php = {
				{
					type = 'php',
					request = 'launch',
					name = 'Listen for Xdebug for PHP 5.6',
					port = 39056,
				},
				{
					type = 'php',
					request = 'launch',
					name = 'Listen for Xdebug for PHP 7.1',
					port = 39071,
				},
				{
					type = 'php',
					request = 'launch',
					name = 'Listen for Xdebug for PHP 7.4',
					port = 39074,
				},
				{
					type = 'php',
					request = 'launch',
					name = 'Listen for Xdebug for PHP 8.0',
					port = 39080,
				},
				{
					type = 'php',
					request = 'launch',
					name = 'Listen for Xdebug for PHP 8.1',
					port = 39081,
				},
				{
					type = 'php',
					request = 'launch',
					name = 'Listen for Xdebug for PHP 8.2',
					port = 39082,
				},
				{
					type = 'php',
					request = 'launch',
					name = 'Listen for Xdebug for PHP 8.3',
					port = 39083,
				},
				{
					type = 'php',
					request = 'launch',
					name = 'Listen for Xdebug for PHP 8.4',
					port = 39084,
				},
			}
		end,
	},
}
