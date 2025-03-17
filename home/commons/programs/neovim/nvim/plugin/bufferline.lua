-- bufferline.lua configuration for Neovim

require('bufferline').setup({
	options = {
		mode = "buffers", -- Set to "tabs" to show tabs instead of buffers
		numbers = "none", -- Show buffer numbers (options: "none", "ordinal", "buffer_id")
		close_command = "bdelete! %d", -- Command to close a buffer
		right_mouse_command = "bdelete! %d", -- Right-click to close a buffer
		left_mouse_command = "buffer %d", -- Left-click to switch to a buffer
		middle_mouse_command = nil, -- Middle-click command (disabled)
		indicator = {
			icon = '▎', -- Indicator icon for the current buffer
			style = 'underline', -- Indicator style (underline, icon, none)
		},
		buffer_close_icon = '', -- Icon for closing a buffer
		modified_icon = '●', -- Icon for modified buffers
		close_icon = '', -- Icon for the close button
		left_trunc_marker = '', -- Left truncation marker
		right_trunc_marker = '', -- Right truncation marker
		name_formatter = function(buf) -- Custom buffer name formatter
			return buf.name
		end,
		max_name_length = 18, -- Maximum length of buffer names
		max_prefix_length = 15, -- Maximum length of buffer prefixes
		tab_size = 18,      -- Size of tabs
		diagnostics = "nvim_lsp", -- Enable diagnostics (options: "nvim_lsp", "coc")
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local icon = level:match("error") and " " or " "
			return icon .. count
		end,
		offsets = { -- Offsets for other plugins (e.g., NvimTree)
			{
				filetype = "NeoTree",
				text = "File Explorer",
				highlight = "Directory",
				text_align = "left",
			}
		},
		color_icons = true,         -- Use colored icons
		show_buffer_icons = true,   -- Show buffer icons
		show_buffer_close_icons = true, -- Show close icons
		show_close_icon = true,     -- Show the close icon
		show_tab_indicators = true, -- Show tab indicators
		persist_buffer_sort = true, -- Persist buffer sorting
		separator_style = "thin",   -- Separator style (options: "slant", "thick", "thin", "padded_slant")
		enforce_regular_tabs = false, -- Force regular tabs (not buffers)
		always_show_bufferline = true, -- Always show the bufferline
		sort_by = 'insert_after_current', -- Sort buffers by insertion order
	}
})
