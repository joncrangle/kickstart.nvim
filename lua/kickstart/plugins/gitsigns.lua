-- Here is a more advanced example where we pass configuration
-- options to `gitsigns.nvim`. This is equivalent to the following Lua:
--    require('gitsigns').setup({ ... })
--
-- See `:help gitsigns` to understand what the configuration keys do
return {
	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Next git hunk" })

				map("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Previous git hunk" })

				-- Actions
				map("n", "<leader>gs", gs.stage_hunk, { desc = "[G]it [S]tage hunk" })
				map("n", "<leader>gr", gs.reset_hunk, { desc = "[G]it [R]eset hunk" })
				map("v", "<leader>gs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end)
				map("v", "<leader>gr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end)
				map("n", "<leader>gS", gs.stage_buffer, { desc = "[G]it [S]tage buffer" })
				map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "[G]it [U]ndo stage hunk" })
				map("n", "<leader>gR", gs.reset_buffer, { desc = "[G]it [R]eset buffer" })
				map("n", "<leader>gp", gs.preview_hunk, { desc = "[G]it [P]review hunk" })
				map("n", "<leader>gb", function()
					gs.blame_line({ full = true })
				end, { desc = "[G]it [B]lame preview" })
				map("n", "<leader>gl", gs.toggle_current_line_blame, { desc = "[G]it [L]ine blame" })
				map("n", "<leader>gt", gs.toggle_deleted, { desc = "[G]it [T]oggle deleted" })

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select git hunk" })
			end,
		},
	},
}
-- vim: ts=2 sts=2 sw=2 et


