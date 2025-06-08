-- Lualine
require("lualine").setup({
        icons_enabled = true,
        theme = 'onedark',
})

-- Colorscheme
vim.cmd("colorscheme onedark")

-- Comment
require("Comment").setup()

-- Gitsigns setup
require('gitsigns').setup()

-- Autopairs setup
require('nvim-autopairs').setup()

-- Nvim-tree setup
require("nvim-tree").setup({
  disable_netrw = true,
  hijack_netrw = true,
  view = {
    width = 35,
  },
})

-- Indent blankline setup
require('ibl').setup()

-- Which-key setup
require('which-key').setup()

