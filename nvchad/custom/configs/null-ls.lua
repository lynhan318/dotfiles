local present, null_ls = pcall(require, "null-ls")

if not present then
	return
end

null_ls.setup({
	sources = {
		require("none-ls.formatting.jq"),
		require("none-ls.formatting.rustfmt"),
		-- require("none-ls.formatting.eslint_d"),
		-- require("none-ls.code_actions.eslint_d"),
	},
})
