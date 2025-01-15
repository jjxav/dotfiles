local function set(mode, keys, cmd, desc)
	local _set = vim.keymap.set
	_set(mode, keys, cmd, { buffer = true, silent = true, desc = desc })
end

local lua_keymap = vim.api.nvim_create_augroup('lua-keymap', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
	group = lua_keymap,
	callback = function()
		if vim.bo.filetype == 'lua' then
			set('n', '<leader>lx', '<CMD>.lua<CR>', '[L]ua e[x]ectute line')
			set('n', '<leader>lX', '<CMD>%lua<CR>', '[L]ua e[X]ectute file')
			set('v', '<leader>lX', "<CMD>'<,'>lua<CR>", '[L]ua e[X]ectute selection')
		end
	end,
})
