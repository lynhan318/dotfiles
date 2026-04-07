-- Native LSP setup using vim.lsp.config / vim.lsp.enable (Neovim 0.12+)

-- ============================================================================
-- Diagnostics
-- ============================================================================
vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 2, prefix = "●", source = "if_many" },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "󰋼",
      [vim.diagnostic.severity.HINT] = "󰌵",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
    },
  },
})

-- ============================================================================
-- Global capabilities (blink.cmp adds completion caps if available)
-- ============================================================================
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_blink, blink = pcall(require, "blink.cmp")
if ok_blink then
  capabilities = blink.get_lsp_capabilities(capabilities)
end

vim.lsp.config("*", {
  capabilities = capabilities,
  root_markers = { ".git" },
})

-- ============================================================================
-- Server configurations
-- ============================================================================

-- Lua
vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
      },
      diagnostics = { globals = { "vim" } },
      telemetry = { enable = false },
    },
  },
})

-- TypeScript / JavaScript
vim.lsp.config("ts_ls", {
  cmd = { "bunx", "--bun", "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
})

-- JSON (with SchemaStore)
vim.lsp.config("jsonls", {
  cmd = { "bunx", "--bun", "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  root_markers = { ".git" },
  settings = {
    json = {
      schemas = (function()
        local ok, schemastore = pcall(require, "schemastore")
        return ok and schemastore.json.schemas() or nil
      end)(),
      validate = { enable = true },
      format = { enable = true },
    },
  },
})

-- Tailwind
vim.lsp.config("tailwindcss", {
  cmd = { "bunx", "--bun", "tailwindcss-language-server", "--stdio" },
  filetypes = {
    "html", "css", "scss", "javascript", "javascriptreact",
    "typescript", "typescriptreact", "svelte",
  },
  root_markers = { "tailwind.config.js", "tailwind.config.ts", "package.json", ".git" },
})

-- CSS
vim.lsp.config("cssls", {
  cmd = { "bunx", "--bun", "vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss", "less" },
  root_markers = { "package.json", ".git" },
})

-- Svelte
vim.lsp.config("svelte", {
  cmd = { "bunx", "--bun", "svelteserver", "--stdio" },
  filetypes = { "svelte" },
  root_markers = { "package.json", ".git" },
})

-- Rust
vim.lsp.config("rust_analyzer", {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", "rust-project.json", ".git" },
})

-- Zig
vim.lsp.config("zls", {
  cmd = { "zls" },
  filetypes = { "zig" },
  root_markers = { "build.zig", ".git" },
  settings = {
    zls = {
      enable_inlay_hints = true,
      enable_snippets = true,
      warn_style = true,
    },
  },
})

-- Activate
vim.lsp.enable({
  "lua_ls",
  "ts_ls",
  "jsonls",
  "tailwindcss",
  "cssls",
  "svelte",
  "rust_analyzer",
  "zls",
})

-- ============================================================================
-- LspAttach: keymaps + per-client behavior
-- ============================================================================
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end

    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
    end

    -- Replacements for lspsaga
    map("n", "K", vim.lsp.buf.hover, "Hover")
    map("n", "gd", vim.lsp.buf.definition, "Goto definition")
    map("n", "gD", vim.lsp.buf.declaration, "Goto declaration")
    map("n", "gv", "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>", "Goto def in vsplit")
    map("n", "gs", "<cmd>split | lua vim.lsp.buf.definition()<cr>", "Goto def in split")
    map("n", "gi", vim.lsp.buf.implementation, "Goto implementation")
    map("n", "gr", vim.lsp.buf.references, "References")
    map("n", "<leader>rf", vim.lsp.buf.rename, "Rename")
    map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("n", "[w", vim.diagnostic.open_float, "Show line diagnostics")
    map("n", "[b", function()
      vim.diagnostic.setloclist()
    end, "Buffer diagnostics")
    -- Note: defaults grn/grr/gri/gra/grt + <C-s> in insert are auto-set by Nvim 0.12

    -- Inlay hints off by default (was disabled in old config)
    if client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
    end

    -- Svelte: notify on JS/TS changes
    if client.name == "svelte" then
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = { "*.js", "*.ts" },
        group = vim.api.nvim_create_augroup("svelte_ondidchangetsorjsfile", { clear = true }),
        callback = function(ctx)
          client:notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
        end,
      })
    end

    -- Document highlight on CursorHold
    if client:supports_method("textDocument/documentHighlight") then
      local grp = vim.api.nvim_create_augroup("lsp_document_highlight_" .. bufnr, { clear = true })
      vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        group = grp,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd("CursorMoved", {
        buffer = bufnr,
        group = grp,
        callback = vim.lsp.buf.clear_references,
      })
    end

    -- nvim-navic for breadcrumbs
    if client:supports_method("textDocument/documentSymbol") then
      local ok_navic, navic = pcall(require, "nvim-navic")
      if ok_navic then
        navic.attach(client, bufnr)
      end
    end
  end,
})
