-- Make sure which-key is required
local wk = require("which-key")

-- Define keymaps with descriptions
local keymaps = {
	["<Esc>"] = { ":noh<CR>", "Clear Search Highlight" },
	["<leader>f"] = { "", "Telescope" },
	["<leader>ff"] = { "<cmd>lua require('telescope.builtin').find_files()<CR>", "Find Files" },
	["<leader>fg"] = { "<cmd>lua require('telescope.builtin').live_grep()<CR>", "Live Grep" },
	["<leader>W"] = { ":wa<CR>", "Save all buffers" },
	["<leader>e"] = { "<cmd>Neotree toggle<CR>", "Toggle Neotree" },
	["<leader>w"] = { ":w<CR>", "Save buffer" },
}

-- Register keymaps with which-key
wk.register(keymaps, { mode = "n" })
