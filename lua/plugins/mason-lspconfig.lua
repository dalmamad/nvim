local DEFAULT_SETTINGS = {
	-- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "sumneko_lua" }
	-- This setting has no relation with the `automatic_installation` setting.
	-- it was moved to mason config
	-- ensure_installed = { "jsonls", "sumneko_lua", "tsserver", "pyright", "clangd" },
	-- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
	-- This setting has no relation with the `ensure_installed` setting.
	-- Can either be:
	--   - false: Servers are not automatically installed.
	--   - true: All servers set up via lspconfig are automatically installed.
	--   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
	--       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
	automatic_enable = false,
	automatic_installation = false,
}
require("mason-lspconfig").setup(DEFAULT_SETTINGS)

local on_attach = function()
	-- Highlight
	vim.cmd([[
  augroup document_highlight
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
  augroup END
  ]])
end

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}

local server_names = require("mason-lspconfig").get_installed_servers()
for _, value in pairs(server_names) do
	require("lspconfig")[value].setup({
		on_attach = on_attach,
		flags = lsp_flags,
	})
end

-- -- 3. prepare capabilities for nvim-cmp (if you use cmp)
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- 4. set up each server with a default handler
-- require("mason-lspconfig").setup({
-- 	automatic_installation = false,
-- 	handler = {
-- 		function(server_name)
-- 			print(server_name)
-- 		end,

-- function(server_name) -- default handler (applies to every server)
-- require("lspconfig")[server_name].setup({
-- capabilities = capabilities,
-- on_attach = function(client, bufnr)
-- 	-- local buf_map = function(lhs, rhs, desc)
-- 	--   vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
-- 	-- end
--
-- 	-- -- optional: keymaps for LSP features
-- 	-- buf_map("gd", vim.lsp.buf.definition, "Go to definition")
-- 	-- buf_map("K",  vim.lsp.buf.hover,      "Hover docs")
--
-- 	-- 4a) documentHighlight (highlights all occurrences of symbol under cursor)
-- 	if client.server_capabilities.documentHighlightProvider then
-- 		vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = false })
-- 		vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "LspDocumentHighlight" })
-- 		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
-- 			group = "LspDocumentHighlight",
-- 			buffer = bufnr,
-- 			callback = vim.lsp.buf.document_highlight,
-- 		})
-- 		vim.api.nvim_create_autocmd("CursorMoved", {
-- 			group = "LspDocumentHighlight",
-- 			buffer = bufnr,
-- 			callback = vim.lsp.buf.clear_references,
-- 		})
-- 		print("xxxxxx")
-- 	end
--
-- 	-- 4b) semantic tokens (requires Neovim ≥0.9 & server support)
-- 	if client.server_capabilities.semanticTokensProvider then
-- 		-- kick off the semantic token refresh
-- 		vim.lsp.semantic_tokens.start(bufnr, client.id)
-- 	end
-- end,
-- on_attach = on_attach
-- })
-- end,
-- 	},
-- })
