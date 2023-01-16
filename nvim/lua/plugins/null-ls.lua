return function()
	local null_ls = require("null-ls")
	local formatting = null_ls.builtins.formatting
	local diagnostics = null_ls.builtins.diagnostics

	local sources = {
		formatting.stylua,
		diagnostics.eslint,
        formatting.prettierd.with {
            extra_filetypes = { "svelte" }
        },
		-- formatting.latexindent,
	}

	null_ls.setup({
		sources = sources,
	})
end
-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
