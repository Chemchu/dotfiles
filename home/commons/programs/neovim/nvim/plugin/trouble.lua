-- trouble.lua configuration for Neovim

local trouble = require("trouble")

trouble.setup({
	-- General settings
	position = "bottom", -- Position of the trouble window (top, bottom, left, right)
	height = 10, -- Height of the trouble window
	width = 50, -- Width of the trouble window
	icons = true, -- Use icons in the trouble window
	mode = "workspace_diagnostics", -- Default mode to open trouble in
	fold_open = "", -- Icon used for open folds
	fold_closed = "", -- Icon used for closed folds
	action_keys = { -- Key mappings for actions in the trouble window
		close = "q", -- Close the trouble window
		cancel = "<esc>", -- Cancel the current action
		refresh = "r", -- Refresh the trouble window
		jump = { "<cr>", "<tab>" }, -- Jump to the diagnostic or reference
		open_split = { "<c-x>" }, -- Open in a split
		open_vsplit = { "<c-v>" }, -- Open in a vertical split
		open_tab = { "<c-t>" }, -- Open in a new tab
		jump_close = { "o" }, -- Jump to the diagnostic or reference and close the trouble window
		toggle_mode = "m", -- Toggle between modes (e.g., diagnostics, references)
		toggle_preview = "P", -- Toggle the preview window
		hover = "K", -- Hover over the diagnostic or reference
		preview = "p", -- Preview the diagnostic or reference
		close_folds = { "zM", "zm" }, -- Close all folds
		open_folds = { "zR", "zr" }, -- Open all folds
		toggle_fold = { "zA", "za" }, -- Toggle fold
		previous = "k", -- Move to the previous item
		next = "j", -- Move to the next item
	},
	indent_lines = true, -- Show indent lines in the trouble window
	auto_open = false, -- Automatically open trouble when there are diagnostics
	auto_close = false, -- Automatically close trouble when there are no diagnostics
	auto_preview = true, -- Automatically preview the diagnostic or reference
	auto_fold = false, -- Automatically fold items
	auto_jump = { "lsp_definitions" }, -- Automatically jump to the diagnostic or reference
	include_declaration = { "lsp_references", "lsp_implementations", "lsp_definitions" }, -- Include declarations in the results
	signs = {
		-- Custom signs for diagnostics
		error = "",
		warning = "",
		hint = "",
		information = "",
		other = "﫠"
	},
	use_diagnostic_signs = true, -- Use the diagnostic signs defined above
})
