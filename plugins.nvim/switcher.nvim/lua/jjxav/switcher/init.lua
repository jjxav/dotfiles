local M = { _config = {}, }

---@class Map<T>: { [string]: T }
---@class Array<T>: { [string]: T }
--- @alias jjxav.switcher.options.filetype Map<Array<string>>

M.switch = function()
	local opts = M._config

	local buf = vim.api.nvim_get_current_buf()
	local path = vim.api.nvim_buf_get_name(buf)
	local name = vim.fs.basename(path)
	local filetype = vim.bo.filetype

	if not opts[filetype] then
		return
	end

	local extentions = vim.fn.copy(opts[filetype])

	if #extentions <= 2 then
		return
	end

	local part = vim.split(name, ".", { plain = true })
	local original_extention = part[#part]
	local next

	for index, value in ipairs(extentions) do
		if not next and value == original_extention then
			next = index % #extentions + 1
		end
	end

	local new_path

	while not new_path do
		part[#part] = extentions[next]
		local new_name = vim.fn.join(part, ".")
		local found_path = vim.fn.findfile(new_name, ".;")

		if found_path ~= "" and not new_path then
			new_path = found_path
		end

		next = next % #extentions + 1
	end

	if not new_path then
		return
	end

	vim.cmd("e " .. new_path)
end

M.setup = function(opts)
	M._config = opts
	return M
end


return M
