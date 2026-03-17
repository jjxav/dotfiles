return {
    "ravibrock/spellwarn.nvim",
    event = "VeryLazy",
	config = function ()
		local spellwarn = require('spellwarn')
		spellwarn.setup({
			suggest = true,
			severity = { -- severity for each spelling error type (false to disable diagnostics for that type)
				spellbad   = "WARN",
				spellcap   = false,
				spelllocal = "HINT",
				spellrare  = "INFO",
			},
		})
		spellwarn.disable()
	end
}
