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

			local set = require('jjxav.helper').keymap.set

			-- Navigation
			set(']c', function()
				if vim.wo.diff then
					vim.cmd.normal({ ']c', bang = true })
				else
					---@diagnostic disable-next-line
					gitsigns.nav_hunk('next')
				end
			end, 'Hunk Next')
			set('[c', function()
				if vim.wo.diff then
					vim.cmd.normal({ '[c', bang = true })
				else
					---@diagnostic disable-next-line
					gitsigns.nav_hunk('prev')
				end
			end, ' Hunk Previous')

			-- Actions
			set('<leader>hs', gitsigns.stage_hunk, 'Hunk Stage')
			set('<leader>hr', gitsigns.reset_hunk, 'Hunk Reset')

			set('<leader>hs', function() gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
				'Hunk Stage Lines', 'v')

			set('<leader>hr', function() gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
				'Hunk Reset Lines', 'v')

			set('<leader>hS', gitsigns.stage_buffer, 'Hunk Stage Buffer', 'v')
			set('<leader>hR', gitsigns.reset_buffer, 'Hunk Reset Buffer', 'v')
			set('<leader>hp', gitsigns.preview_hunk, 'Hunk Preview', 'v')
			set('<leader>hi', gitsigns.preview_hunk_inline, 'Hunk Inline Preview', 'v')

			set('<A-k>', function() gitsigns.blame_line({ full = true }) end, 'Blame current line')

			set('<leader>gdf', gitsigns.diffthis, 'Git Diff')

			set('<leader>hD', function()
				---@diagnostic disable-next-line
				gitsigns.diffthis('~')
			end, 'Git Diff')

			---@diagnostic disable-next-line
			set('<leader>hQ', function() gitsigns.setqflist('all') end, 'Add all changed file to QF')
			set('<leader>hq', gitsigns.setqflist, 'Add current file to QF')

			-- Toggles
			-- set('<leader>tb', gitsigns.toggle_current_line_blame)
			-- set('<leader>td', gitsigns.toggle_deleted)
			-- set('<leader>tw', gitsigns.toggle_word_diff)

			-- Text object
			-- set('ih', gitsigns.select_hunk, '', { 'o', 'x' })

			-- Document actions
			set('<leader>gbo', gitsigns.blame, '[D]ocument [B]lame [O]pen')
		end
	}
}
