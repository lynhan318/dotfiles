local present, null_ls = pcall(require, "null-ls")

if not present then
	return
end

local b = null_ls.builtins

local sources = {

	-- webdev stuff
	-- b.formatting.rome,

	-- Lua
	b.formatting.stylua,
	b.formatting.prettierd.with({
		extra_filetypes = { "svelte" },
	}),
	b.formatting.rustfmt,

	-- Shell
	b.formatting.shfmt,
	b.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),
}

null_ls.setup({
	debug = true,
	sources = sources,
})
