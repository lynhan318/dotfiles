return {
  "neovim/nvim-lspconfig",
  version = false, -- Latest tag is behind
  name = "lsp",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "saghen/blink.cmp",
    {
      "williamboman/mason.nvim",
      opts = {
        ensure_installed = {
          "lua-language-server",
          "stylua",
          "typescript-language-server",
          "css-lsp",
          "json-lsp",
          "html-lsp",
          "rust-analyzer",
          "svelte-language-server",
          "woke",
        },
      },
      config = function(_, opts)
        require("mason").setup(opts)
        local mr = require "mason-registry"
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end

        require("mason-lspconfig").setup {
          automatic_installation = true,
        }
      end,
    },
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    {
      "folke/neoconf.nvim",
      cmd = "Neoconf",
      config = true,
    },
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
    require "mason"
    local nvim_lsp = require "lspconfig"
    local opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = false,
        serverity_sort = true,
      },
      inlay_hints = {
        enabled = true,
      },
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      servers = {
        jsonls = {
          -- lazy-load schemastore when needed
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
        },
        rust_analyzer = {
          -- settings = {
          --   ["rust-analyzer"] = {
          --     cargo = {
          --       allFeatures = true,
          --     },
          --     checkOnSave = {
          --       command = "clippy",
          --       extraArgs = { "--no-deps" },
          --     },
          --   },
          -- },
        },
        tailwindcss = {},
        ts_ls = {
          init_options = {
            enabledFeatures = {
              foldingRange = true,
            },
          },
          root_dir = nvim_lsp.util.root_pattern "package.json",
          single_file_support = false,
        },
        cssls = {},
        biome = {},
        vimls = {},
        svelte = {},
        -- denols = {
        --   root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
        -- },
      },
    }

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

    vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
    vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
    vim.fn.sign_define("DiagnosticSignInformation", { text = "", texthl = "DiagnosticSignInfo" })
    vim.fn.sign_define("DiagnosticSignHint", { text = "i", texthl = "DiagnosticSignHint" })

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local buffer = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        on_attach(client, buffer)

        vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
      end,
    })

    vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

    local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      has_cmp and cmp_nvim_lsp.default_capabilities() or {},
      opts.capabilities or {},
      {
        textDocument = {
          foldingRange = { dynamicRegistration = false, lineFoldingOnly = true },
        },
      }
    )

    local servers = opts.servers

    local function setup(server)
      local server_opts = vim.tbl_deep_extend("force", {
        capabilities = vim.deepcopy(capabilities),
      }, servers[server] or {})
      server_opts.capabilities = require("blink.cmp").get_lsp_capabilities(server_opts.capabilities)
      nvim_lsp[server].setup(server_opts)
    end

    local mlsp = require "mason-lspconfig"
    local available = mlsp.get_available_servers()

    local ensure_installed = {} ---@type string[]
    for server, server_opts in pairs(servers) do
      if server_opts then
        server_opts = server_opts == true and {} or server_opts
        -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
        if server_opts.mason == false or not vim.tbl_contains(available, server) then
          setup(server)
        else
          ensure_installed[#ensure_installed + 1] = server
        end
      end
    end

    require("mason-lspconfig").setup { ensure_installed = ensure_installed }
    require("mason-lspconfig").setup_handlers { setup }
  end,
}
