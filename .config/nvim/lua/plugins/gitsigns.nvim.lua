return {
	'lewis6991/gitsigns.nvim',
	opts = {
		signs = {
			add          = { text = '┃' },
			change       = { text = '┃' },
			delete       = { text = '_' },
			topdelete    = { text = '‾' },
			changedelete = { text = '~' },
			untracked    = { text = '┆' },
		},
		on_attach = function(bufnr)
			local gitsigns = require('gitsigns')

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map('n', ']c', function()
				if vim.wo.diff then
					vim.cmd.normal({ ']c', bang = true })
				else
					gitsigns.nav_hunk('next')
				end
			end, { desc = 'Hunk Next' })

			map('n', '[c', function()
				if vim.wo.diff then
					vim.cmd.normal({ '[c', bang = true })
				else
					gitsigns.nav_hunk('prev')
				end
			end, { desc = ' Hunk Previous' })

			-- Actions
			map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Hunk Stage' })
			map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'Hunk Reset' })

			map('v', '<leader>hs', function()
				gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
			end, { desc = 'Hunk Stage Lines' })

			map('v', '<leader>hr', function()
				gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
			end, { desc = 'Hunk Reset Lines' })

			map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'Hunk Stage Buffer' })
			map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'Hunk Reset Buffer' })
			map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'Hunk Preview' })
			map('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = 'Hunk Inline Preview' })

			map('n', '<C-K>', function()
				gitsigns.blame_line({ full = true })
			end, { desc = 'Blame current line' })

			map('n', '<leader>gdf', gitsigns.diffthis, { desc = 'Git Diff' })

			map('n', '<leader>hD', function()
				gitsigns.diffthis('~')
			end, { desc = 'Git Diff' })

			map('n', '<leader>hQ', function() gitsigns.setqflist('all') end, { desc = 'Add all changed file to QF' })
			map('n', '<leader>hq', gitsigns.setqflist, { desc = 'Add current file to QF' })

			-- Toggles
			-- map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
			-- map('n', '<leader>td', gitsigns.toggle_deleted)
			-- map('n', '<leader>tw', gitsigns.toggle_word_diff)

			-- Text object
			-- map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)

			-- Document actions
			map('n', '<leader>gbo', gitsigns.blame, { desc = '[D]ocument [B]lame [O]pen' })
		end
	}
}
