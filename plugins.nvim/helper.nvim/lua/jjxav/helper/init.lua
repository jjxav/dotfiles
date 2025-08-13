
---@class Keymap
local keymap = {
	---comment
	---@param keys string
	---@param func string|function
	---@param desc? string
	---@param mode? string|string[]
	---@param opts? vim.keymap.set.Opts
	set = function(keys, func, desc, mode, opts)
		local desc_option = { desc = desc }
		mode = mode or 'n'
		opts = opts or {}

		opts = vim.tbl_extend('error', opts, desc_option)

		vim.keymap.set(mode, keys, func, opts)
	end
}

---@class Helper
---@field keymap Keymap

---@type Helper
local module = {
	keymap = keymap
};

return module
