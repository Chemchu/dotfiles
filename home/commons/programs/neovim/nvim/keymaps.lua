-- Key mappings
local keymap = vim.keymap.set

-- File explorer
keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })

-- Telescope
keymap('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Find files' })
keymap('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = 'Live grep' })
keymap('n', '<leader>fb', require('telescope.builtin').buffers, { desc = 'Find buffers' })
keymap('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = 'Help tags' })

-- Buffer navigation
keymap('n', '<S-l>', ':bnext<CR>', { desc = 'Next buffer' })
keymap('n', '<S-h>', ':bprevious<CR>', { desc = 'Previous buffer' })

-- Window navigation
keymap('n', '<C-h>', '<C-w>h', { desc = 'Go to left window' })
keymap('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window' })
keymap('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window' })
keymap('n', '<C-l>', '<C-w>l', { desc = 'Go to right window' })

-- Clear search highlighting
keymap('n', '<leader>h', ':nohlsearch<CR>', { desc = 'Clear search highlight' })

-- LSP keybindings
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    keymap('n', 'gD', vim.lsp.buf.declaration, opts)
    keymap('n', 'gd', vim.lsp.buf.definition, opts)
    keymap('n', 'K', vim.lsp.buf.hover, opts)
    keymap('n', 'gi', vim.lsp.buf.implementation, opts)
    keymap('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    keymap('n', '<leader>rn', vim.lsp.buf.rename, opts)
    keymap('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    keymap('n', 'gr', vim.lsp.buf.references, opts)
    keymap('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

--[[ -- Make sure which-key is required
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
wk.add(lspmaps, { mode = "n" }); ]]
