-- Relative line number
vim.o.relativenumber = true

-- Autoformat
vim.cmd [[ autocmd BufWritePre <buffer> lua vim.lsp.buf.format() ]]
