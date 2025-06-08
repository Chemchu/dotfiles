-- Lualine setup
require('lualine').setup({
  options = {
    theme = 'onedark',
  },
})
      

--[[ require('lualine').setup({
	options = {
		icons_enabled = true, -- Enable icons
		theme = 'auto', -- Use an auto-detected theme (or specify a custom theme like 'onedark')
		component_separators = { left = '', right = '' }, -- Separators between components
		section_separators = { left = '', right = '' }, -- Separators between sections
		disabled_filetypes = {}, -- Disable lualine for specific filetypes
		always_divide_middle = true, -- Always divide the middle section
		globalstatus = true, -- Use a single status line for all windows
	},
	sections = {
		lualine_a = { 'mode' },                         -- Mode (Normal, Insert, Visual, etc.)
		lualine_b = { 'branch', 'diff', 'diagnostics' }, -- Git branch, diff, and diagnostics
		lualine_c = { 'filename' },                     -- Current filename
		lualine_x = { 'encoding', 'fileformat', 'filetype' }, -- Encoding, file format, and file type
		lualine_y = { 'progress' },                     -- Cursor position in the file
		lualine_z = { 'location' }                      -- Cursor line and column
	},
	inactive_sections = {
		lualine_a = {},       -- Inactive sections (not used in this config)
		lualine_b = {},
		lualine_c = { 'filename' }, -- Inactive filename
		lualine_x = { 'location' }, -- Inactive cursor location
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},                                       -- Disable tabline (we'll use bufferline for this)
	extensions = { 'fugitive', 'nvim-tree', 'toggleterm' } -- Extensions for specific plugins
}) ]]
