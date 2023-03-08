local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {
  -- webdev stuff
  b.formatting.deno_fmt,

  -- b.formatting.prettier,
  b.formatting.prettier.with { extra_filetypes = { "svelte" } },

  -- Lua
  b.formatting.stylua,

  -- Shell
  b.formatting.shfmt,
  b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

  -- cpp
  b.formatting.clang_format,

  -- rust
  b.formatting.rustfmt,

  -- go
  b.formatting.gofmt,

  -- prisma
  b.formatting.prismaFmt,
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
  if client.name == "tsserver" or client.name == "rust_analyzer" or client.name == "pyright" then
    client.resolved_capabilities.document_formatting = false
  end

  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_clear_autocmds {
      group = augroup,
      buffer = bufnr,
    }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end
end

null_ls.setup {
  debug = true,
  sources = sources,
  on_attach = on_attach,
}
