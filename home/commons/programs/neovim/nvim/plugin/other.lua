-- Lualine
require("lualine").setup({
        icons_enabled = true,
        theme = 'onedark',
})

-- Colorscheme
vim.cmd("colorscheme onedark")

-- Comment
require("Comment").setup()
