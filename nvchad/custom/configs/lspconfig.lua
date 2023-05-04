local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = false,
	signs = true,
	update_in_insert = false,
	underline = true,
})

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

vim.api.nvim_clear_autocmds({
	group = augroup,
	buffer = bufnr,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup,
	buffer = bufnr,
	callback = function()
		vim.lsp.buf.format({
			-- async = true,
			filter = function(client)
				-- apply whatever logic you want (in this example, we'll only use null-ls)
				return client.name == "null-ls"
			end,
			bufnr = bufnr,
		})
	end,
})

-- vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	group = "LspAttach_inlayhints",
-- 	callback = function(args)
-- 		if not (args.data and args.data.client_id) then
-- 			return
-- 		end
--
-- 		local bufnr = args.buf
-- 		local client = vim.lsp.get_client_by_id(args.data.client_id)
-- 		require("lsp-inlayhints").on_attach(client, bufnr)
-- 	end,
-- })

local servers = { "html", "cssls", "tsserver", "svelte", "jsonls", "eslint" }

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end
