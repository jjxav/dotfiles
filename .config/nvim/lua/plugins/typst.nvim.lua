return {
	'chomosuke/typst-preview.nvim',
	lazy = false, -- or ft = 'typst'
	version = '1.*',
	config = function()
		local typstp = require('typst-preview').setup {
			open_cmd = "echo '' > /dev/null",
			port = 3000,
		}

		local close_preview = function(buff_id)
			local cmd = vim.api.nvim_parse_cmd('TypstPreviewStop', {})
			--- @diagnostic disable-next-line param-type-mismatch
			vim.api.nvim_cmd(cmd, {})
		end
		local open_preview = function(buff_id)
			local cmd = vim.api.nvim_parse_cmd('TypstPreview', {})
			--- @diagnostic disable-next-line param-type-mismatch
			vim.api.nvim_cmd(cmd, {})
		end

		vim.api.nvim_create_autocmd('BufEnter', {
			pattern = { '*.typ', '*.typst' },
			group = vim.api.nvim_create_augroup('typst-attach', { clear = true }),
			callback = function(event)
				open_preview(event.buf)
			end
		})
		vim.api.nvim_create_autocmd('BufLeave', {
			pattern = { '*.typ', '*.typst' },
			group = vim.api.nvim_create_augroup('typst-detattach', { clear = true }),
			callback = function(event)
				close_preview(event.buf)
			end
		})
	end
}
