return function() -- TODO figure out why this don't work
	local lspconfig = require("lspconfig")
	local lsp = vim.lsp

	local border_opts = { border = "rounded", focusable = false, scope = "line" }

	vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
	vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
	vim.fn.sign_define("DiagnosticSignInformation", { text = "", texthl = "DiagnosticSignInfo" })
	vim.fn.sign_define("DiagnosticSignHint", { text = "ﴞ", texthl = "DiagnosticSignHint" })

	-- handlers
	lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, border_opts)

	lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, border_opts)

	lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = false,
		signs = true,
		update_in_insert = false,
		underline = true,
	})

	local lsp_formatting = function(bufnr)
		vim.lsp.buf.format({
			-- async = true,
			filter = function(client)
				-- apply whatever logic you want (in this example, we'll only use null-ls)
				return client.name == "null-ls"
			end,
			bufnr = bufnr,
		})
	end

	-- if you want to set up formatting on save, you can use this as a callback
	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

	local function setupClient(client, bufnr)
		if client.server_capabilities.documentHighlightProvider then
			vim.api.nvim_exec(
				[[
          hi LspReferenceRead cterm=bold ctermbg=red guibg=#34495e
          hi LspReferenceText cterm=bold ctermbg=red guibg=#34495e
          hi LspReferenceWrite cterm=bold ctermbg=red guibg=#34495e
          augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
          augroup END
        ]],
				false
			)
		end

		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
		end
	end

	local function lspSetup(client)
		-- vim.cmd("nnoremap <silent> gi <cmd>lua vim.lsp.buf.definition()<CR>")
		vim.cmd("nnoremap <silent> rn <cmd>Lspsaga rename<CR>")
		vim.cmd("nnoremap <silent> gh <cmd>Lspsaga signature_help<CR>")
		vim.cmd("nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>")
		vim.cmd("nnoremap <silent> gr <cmd>Lspsaga lsp_finder<CR>")
		vim.cmd("nnoremap <silent> gi <cmd>lua vim.lsp.buff.implementation()<CR>")

		vim.cmd("nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>")

		vim.cmd("nnoremap <silent> gp <cmd>lua require('goto-preview').goto_preview_definition()<CR>")

		-- vim.cmd("nnoremap <silent> gd <cmd>Lspsaga preview_definition<CR>")
		vim.cmd("nnoremap <silent> ca <cmd>Lspsaga code_action<CR>")
		vim.cmd("nnoremap <silent> gD <cmd>lua vim.diagnostic.open_float()<CR>")
		-- vim.cmd("nnoremap <silent> ca <cmd>Telescope lsp_code_actions<CR>")
		-- vim.cmd("nnoremap <silent> gD <cmd>Lspsaga show_cursor_diagnostics<CR>")
		vim.cmd("nnoremap <silent> g[ <cmd>Lspsaga diagnostic_jump_prev<CR>")
		vim.cmd("nnoremap <silent> g] <cmd>Lspsaga diagnostic_jump_next<CR>")

		vim.cmd('command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()')
	end

	local function commonAttach(client)
		setupClient(client)
		lspSetup()
	end

	local servers = {
		cssls = { cmd = { "css-languageserver", "--stdio" } },
		html = { cmd = { "html-languageserver", "--stdio" } },
		lua_ls = { cmd = { "lua-language-server", "--stdio" } },
		jsonls = { cmd = { "vscode-json-languageserver", "--stdio" } },
		tsserver = { root_dir = lspconfig.util.root_pattern("package.json") },
		tailwindcss = { cmd = { "tailwindcss-language-server", "--stdio" } },
		vimls = {},
		svelte = {},
	}

	local capabilities = vim.lsp.protocol.make_client_capabilities()

	for server, config in pairs(servers) do
		if type(config) == "function" then
			config = config()
		end
		config.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
		config.on_attach = commonAttach
		lspconfig[server].setup(config)
	end

	-- setup rust-alanyzer with inlay_hints
	local opts = {
		tools = {
			autoSetHints = true,
			runnables = { use_telescope = true },
			inlay_hints = {
				show_parameter_hints = false,
				parameter_hints_prefix = " <-",
				other_hints_prefix = "» ",
			},
		},
		server = {
			on_attach = commonAttach,
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities),
			settings = {
				["rust-analyzer"] = { checkOnSave = { command = "clippy" } },
			},
		},
	}
	require("rust-tools").setup(opts)

	-- setup for deno
	-- require('deno-nvim').setup({
	--     server = {
	--         on_attach = commonAttach,
	--         capabilities = capabilities,
	--         root_dir = lspconfig.util.root_pattern("deno.json")
	--     },
	--     root_dir = lspconfig.util.root_pattern("deno.json")
	-- })
end
