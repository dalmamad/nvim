local signs = {
	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn", text = "" },
	{ name = "DiagnosticSignHint", text = "" },
	{ name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
	-- disable virtual text
	virtual_text = false,
	-- show signs
	signs = {
		active = signs,
	},
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
}

vim.diagnostic.config(config)
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
-- vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
-- vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Highlight
	vim.cmd([[
  augroup document_highlight
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
  augroup END
  ]])

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	-- vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, bufopts)
  vim.api.nvim_buf_set_keymap(0, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap=true, silent=true})
	vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, bufopts)
	vim.keymap.set("n", "gi", require("telescope.builtin").lsp_implementations, bufopts)
	vim.keymap.set("n", "gz", require("telescope.builtin").lsp_incoming_calls, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)

	-- vim.keymap.set("n", "<leader>fz", require('telescope.builtin').treesitter, bufopts)
	-- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	-- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	-- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	-- vim.keymap.set("n", "<space>wl", function()
	-- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"gl",
		'<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>',
		opts
	)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)

	-- vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	-- vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)

	-- vim.keymap.set("n", "<space>f", function()
	-- 	vim.lsp.buf.format({ async = true })
	-- end, bufopts)
end

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}
require("lspconfig")["pyright"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})

-- require("lspconfig")["clangd"].setup({
--   on_attach = on_attach,
-- 	flags = lsp_flags,
-- })

require("lspconfig")["gopls"].setup({
	settings = {
		gopls = {
			-- not a good solution btw
			buildFlags = { "-tags=end2end" },
			gofumpt = true,
		},
	},
	on_attach = on_attach,
	flags = lsp_flags,
})

-- require("lspconfig")["csharp_ls"].setup({
--   on_attach = on_attach,
-- 	flags = lsp_flags,
-- })
-- require'lspconfig'["omnisharp"].setup{
--   cmd = { "omnisharp" },  -- Specify the correct path to omnisharp executable if needed
--   root_dir = require'lspconfig'.util.root_pattern("*.sln", "*.csproj"),
-- }

-- In init.lua or wherever you configure your LSPs
require("lspconfig").omnisharp.setup({
	cmd = { "omnisharp" },
  on_attach = on_attach,

	-- Enables support for reading code style, naming convention and analyzer
	-- settings from .editorconfig.
	enable_editorconfig_support = true,

	-- If true, MSBuild project system will only load projects for files that
	-- were opened in the editor. This setting is useful for big C# codebases
	-- and allows for faster initialization of code navigation features only
	-- for projects that are relevant to code you are working on.
	enable_ms_build_load_projects_on_demand = false,

	-- Enables support for roslyn analyzers, code fixes and rulesets.
	enable_roslyn_analyzers = true,

	-- Specifies whether 'using' directives should be grouped and sorted
	-- during document formatting.
	organize_imports_on_format = true,

	-- Enables support for showing unimported types and unimported extension
	-- methods in completion lists. When committed, the appropriate using
	-- directive will be added at the top of the current file. This option can
	-- have adverse performance implications depending on the specifics of your
	-- code base.
	enable_import_completion = true,

	-- Specifies whether to include preview versions of the .NET SDK when
	-- determining which version to use for project loading.
	sdk_include_prereleases = true,

	-- Only run analyzers against open files when 'enableRoslynAnalyzers' is
	-- true
	analyze_open_documents_only = true,
})

require("lspconfig")["lua_ls"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})
require("lspconfig")["ts_ls"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	init_options = {
		preferences = {
			disableSuggestions = false,
		},
	},
})
require("lspconfig")["rust_analyzer"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	-- Server-specific settings...
	settings = {
		["rust-analyzer"] = {},
	},
})
