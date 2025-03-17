local actions = require('telescope.actions')

require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,  -- Close the Telescope picker with Escape
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,  -- Use fuzzy matching
      override_generic_sorter = true,  -- Override the generic sorter
      override_file_sorter = true,  -- Override the file sorter
      case_mode = "smart_case",  -- Default case mode
    }
  }
})

-- Load the fzf extension
require('telescope').load_extension('fzf')
