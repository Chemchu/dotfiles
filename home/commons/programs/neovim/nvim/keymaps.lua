-- Make sure which-key is required
local wk = require("which-key")

local keymaps = {
	{ "<Esc>",      ":noh<CR>",                                               desc = "Clear Search Highlight" },
	{ "<leader>W",  ":wa<CR>",                                                desc = "Save all buffers" },
	{ "<leader>e",  "<cmd>Neotree toggle<CR>",                                desc = "Toggle Neotree" },
	{ "<leader>f",  "",                                                       desc = "Telescope" },
	{ "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>", desc = "Find Files" },
	{ "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>",  desc = "Live Grep" },
	{ "<leader>w",  ":w<CR>",                                                 desc = "Save buffer" },
}

local troublemaps =
{
	{ "<leader>x",  group = "Trouble" },
	{ "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Document Diagnostics" },
	{ "<leader>xl", "<cmd>TroubleToggle loclist<cr>",               desc = "Location List" },
	{ "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",              desc = "Quickfix List" },
	{ "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
	{ "<leader>xx", "<cmd>TroubleToggle<cr>",                       desc = "Toggle Trouble" },
}

local bufferlinemaps = {
	{ "<leader>b",  group = "Buffer" },
	{ "<leader>bc", ":BufferLinePickClose<CR>",  desc = "Close Buffer" },
	{ "<leader>bl", ":BufferLineCloseLeft<CR>",  desc = "Close Buffers to Left" },
	{ "<leader>bp", ":BufferLinePick<CR>",       desc = "Pick Buffer" },
	{ "<leader>br", ":BufferLineCloseRight<CR>", desc = "Close Buffers to Right" },
}

local lspmaps = {
	{ "<leader>r", vim.lsp.buf.rename,      desc = "Rename symbol" },
	{ "<leader>a", vim.lsp.buf.code_action, desc = "Code action" },
}

-- Register keymaps with which-key
wk.add(keymaps, { mode = "n" })
wk.add(troublemaps, { mode = "n" })
wk.add(bufferlinemaps, { mode = "n" });
wk.add(lspmaps, { mode = "n" });
