local on_attach = function(client, bufnr)
	if client.server_capabilities.documentHighlightProvider then
		local group = vim.api.nvim_create_augroup(
			"LspDocumentHighlight",
			{ clear = false }
		)

		vim.api.nvim_clear_autocmds({
			buffer = bufnr,
			group = group,
		})

		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			group = group,
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})

		vim.api.nvim_create_autocmd("CursorMoved", {
			group = group,
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local servers = {
	lua_ls = {},
	clangd = {},
	jsonls = {},
	pyright = {},
	ts_ls = {},
}

require("mason-lspconfig").setup({
	automatic_enable = false,
})

for server_name, config in pairs(servers) do
	config.capabilities = capabilities
	config.on_attach = on_attach

	vim.lsp.config(server_name, config)
	vim.lsp.enable(server_name)
end
