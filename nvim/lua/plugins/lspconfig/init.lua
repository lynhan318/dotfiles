return {
  "neovim/nvim-lspconfig",
  version = false, -- Latest tag is behind
  name = "lsp",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "saghen/blink.cmp",
    {
      "williamboman/mason.nvim",
      config = function(_, opts)
        require("mason").setup(opts)
        require("mason-lspconfig").setup {
          automatic_enable = true,
          ensure_installed = { "lua_ls", "ts_ls", "cssls", "tailwindcss" },
        }
      end,
    },
    "williamboman/mason-lspconfig.nvim",
    {
      "b0o/SchemaStore.nvim",
      version = false,
    },
    {
      "nvimdev/lspsaga.nvim",
      cmd = "Lspsaga",
      config = function()
        vim.diagnostic.config {
          severity_sort = true,
        }
        require("lspsaga").setup {
          lightbulb = {
            enable = false,
          },
          symbol_in_winbar = {
            enable = false,
          },
          diagnostic = {
            max_height = 0.8,
            severity_sort = true,
            keys = {
              quit = { "q", "<ESC>" },
            },
          },
          -- ui = {
          --   kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
          -- },
        }
      end,
    },
    "SmiteshP/nvim-navic",
  },
  config = function(_)
    local nvim_lsp = require "lspconfig"

    vim.lsp.enable "rust_analyzer"
    vim.lsp.enable "jsonls"
    vim.lsp.config("jsonls", {
      on_new_config = function(new_config)
        new_config.settings.json.schemas = new_config.settings.json.schemas or {}
        vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
      end,
      settings = {
        json = {
          format = {
            enable = true,
          },
          validate = {
            enable = true,
          },
        },
      },
    })

    vim.lsp.enable "ts_ls"
    vim.lsp.enable "tailwindcss"
    vim.lsp.enable "cssls"
    vim.lsp.enable "biome"
    vim.lsp.enable "svelte"

    vim.diagnostic.config {
      underline = true,
      update_in_insert = false,
      virtual_text = false,
      serverity_sort = true,
    }
    vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
    vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
    vim.fn.sign_define("DiagnosticSignInformation", { text = "", texthl = "DiagnosticSignInfo" })
    vim.fn.sign_define("DiagnosticSignHint", { text = "i", texthl = "DiagnosticSignHint" })
    local on_attach = function(client, bufnr)
      if client.name == "svelte" then
        vim.api.nvim_create_autocmd("BufWritePost", {
          pattern = { "*.js", "*.ts" },
          group = vim.api.nvim_create_augroup("svelte_ondidchangetsorjsfile", { clear = true }),
          callback = function(ctx)
            -- Here use ctx.match instead of ctx.file
            client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
          end,
        })
      end

      if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
      end
      local config = require "plugins.lspconfig.configs"
      config.setup(client, bufnr)
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local buffer = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        on_attach(client, buffer)

        vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
      end,
    })
  end,
}
