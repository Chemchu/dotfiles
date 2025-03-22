local on_attach = function(_, bufnr)
	local bufmap = function(keys, func)
		vim.keymap.set('n', keys, func, { buffer = bufnr })
	end

	bufmap('gd', vim.lsp.buf.definition)
	bufmap('gD', vim.lsp.buf.declaration)
	bufmap('gI', vim.lsp.buf.implementation)

	bufmap('gr', require('telescope.builtin').lsp_references)

	bufmap('K', vim.lsp.buf.hover)

	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
		vim.lsp.buf.format()
	end, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- LSP setup
local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')
require('neodev').setup()

-- Lua LSP
lspconfig.lua_ls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	root_dir = function()
		return vim.loop.cwd()
	end,
	cmd = { "lua-language-server" }, -- Make sure the correct command is specified
	settings = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	}
}

-- Rust LSP (rust-analyzer)
lspconfig.rust_analyzer.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	root_dir = function()
		return vim.loop.cwd()
	end,
	cmd = { "rust-analyzer" }, -- Make sure the correct command is specified
	settings = {
		["rust-analyzer"] = {
			checkOnSave = {
				command = "clippy",
			},
		},
	}
}

-- TypeScript LSP (typescript-language-server, aka ts_ls)
lspconfig.ts_ls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	root_dir = function()
		return vim.loop.cwd()
	end,
	cmd = { "typescript-language-server", "--stdio" }, -- Make sure the correct command is specified
	filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact", "html", "css", "json" },
}

-- Godot 4 LSP
lspconfig.godot.setup({
	cmd = { "/home/gus/.nix-profile/bin/godot", "--lsp" },        -- Command to start the Godot LSP
	filetypes = { "gdscript", "gd" },                             -- Supported filetypes for Godot scripts
	root_dir = lspconfig.util.root_pattern("project.godot", ".git"), -- Root of the project (check for project.godot file)
	settings = {},
})

vim.filetype.add {
	extension = {
		jinja = 'jinja',
		jinja2 = 'jinja',
		j2 = 'jinja',
	},
}

-- if you want to debug
vim.lsp.set_log_level("debug")

-- Jinja and Askama with Rust
if not configs.jinja_lsp then
	configs.jinja_lsp = {
		default_config = {
			name = "jinja-lsp",
			cmd = { 'path_to_lsp_or_command' },
			filetypes = { 'jinja', 'rust' },
			root_dir = function(fname)
				return "."
				--return lspconfig.util.find_git_ancestor(fname)
			end,
			init_options = {
				templates = './templates',
				backend = { './src' },
				lang = "rust"
			},
		},
	}
end
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
lspconfig.jinja_lsp.setup {
	capabilities = capabilities
}
lspconfig.jinja_lsp.setup {
}
