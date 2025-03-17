-- java.lua

-- Get the JAVA_HOME environment variable
local java_home = os.getenv("JAVA_HOME")

if not java_home then
	vim.notify("JAVA_HOME environment variable is not set. Please set it to your JDK 17 path.", vim.log.levels.ERROR)
	return
end

local config = {
	cmd = { 'jdtls' },
	root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
	settings = {
		java = {
			configuration = {
				runtimes = {
					{
						name = "JavaSE-17",
						path = java_home, -- Use JAVA_HOME here
						default = true,
					},
				},
			},
			signatureHelp = { enabled = true },
			contentProvider = { preferred = 'fernflower' },
			completion = {
				favoriteStaticMembers = {
					"org.junit.Assert.*",
					"org.junit.jupiter.api.Assertions.*",
					"org.mockito.Mockito.*",
					"org.mockito.ArgumentMatchers.*",
				},
			},
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
			codeGeneration = {
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
				},
				hashCodeEquals = {
					useJava7Objects = true,
				},
				useBlocks = true,
			},
			format = {
				enabled = true,
				settings = {
					url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
					profile = "GoogleStyle",
				},
			},
			implementationsCodeLens = {
				enabled = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			inlayHints = {
				parameterNames = {
					enabled = true,
				},
			},
		},
	},
	init_options = {
		bundles = {}, -- Add any additional bundles here if needed
	},
}

-- Start the LSP client
require('jdtls').start_or_attach(config)
