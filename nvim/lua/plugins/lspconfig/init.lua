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
                    ensure_installed = { "lua_ls", "cssls", "tailwindcss", "jsonls", "rust_analyzer", "svelte", "ts_ls" },
                }
            end,
        },
        "williamboman/mason-lspconfig.nvim",
        {
            "b0o/SchemaStore.nvim",
            version = false,
        },
    },
    config = function(_)
        -- On large monorepos, servers (tailwindcss, rust_analyzer, ...) register
        -- `workspace/didChangeWatchedFiles` with broad globs. Neovim then walks the
        -- whole tree (incl. every node_modules) synchronously to set up watchers,
        -- freezing the UI for ~15s on the first file open. Opt out of client-side
        -- file watching so servers do their own watching instead of blocking us.
        -- Set per-server (not on "*") because blink.cmp's "*" capabilities would
        -- otherwise clobber it; per-server config always wins the merge.
        for _, name in ipairs { "rust_analyzer", "jsonls", "ts_ls", "tailwindcss", "cssls", "svelte", "zls" } do
            vim.lsp.config(name, {
                capabilities = {
                    workspace = {
                        didChangeWatchedFiles = { dynamicRegistration = false },
                    },
                },
            })
        end

        -- Run the Node-based language servers with Bun instead of Node: faster
        -- cold start and lower memory (helps the tailwindcss server most). Native
        -- servers (tsgo, rust_analyzer, zls) are left on their own binaries.
        local mason_bin = vim.fn.stdpath "data" .. "/mason/bin/"
        local function bun_cmd(server, ...)
            return { "bun", "run", mason_bin .. server, ... }
        end

        vim.lsp.enable "rust_analyzer"
        vim.lsp.enable "jsonls"
        vim.lsp.config("jsonls", {
            cmd = bun_cmd("vscode-json-language-server", "--stdio"),
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
        -- vim.lsp.enable "ts_ls"
        local lspconfig = require "lspconfig"
        vim.lsp.enable "ts_ls"
        vim.lsp.config("ts_ls", {
            -- cmd = { "typescript-language-server", "--stdio" },
            cmd = { "tsgo", "--lsp", "--stdio" },
            filetypes = {
                "javascript",
                "javascriptreact",
                "javascript.jsx",
                "typescript",
                "typescriptreact",
                "typescript.tsx",
            },
            root_markers = {
                "tsconfig.json",
                "jsconfig.json",
                "package.json",
                ".git",
                "tsconfig.base.json",
            },
        })
        vim.lsp.enable "tailwindcss"
        vim.lsp.config("tailwindcss", {
            cmd = bun_cmd("tailwindcss-language-server", "--stdio"),
        })
        vim.lsp.enable "cssls"
        vim.lsp.config("cssls", {
            cmd = bun_cmd("vscode-css-language-server", "--stdio"),
        })
        vim.lsp.enable "svelte"
        vim.lsp.config("svelte", {
            cmd = bun_cmd("svelteserver", "--stdio"),
        })
        vim.lsp.config("zls", {
            -- Set to 'zls' if `zls` is in your PATH
            cmd = { "zls" },
            filetypes = { "zig" },
            root_markers = { "build.zig" },
            settings = {
                zls = {
                    enable_inlay_hints = true,
                    enable_snippets = true,
                    warn_style = true,
                },
            },
        })
        vim.lsp.enable "zls"
        vim.diagnostic.config {
            underline = true,
            update_in_insert = false,
            virtual_text = false,
            severity_sort = true,
            float = {
                border = "rounded",
                source = "if_many",
                max_width = 100,
                wrap = true,
            },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "",
                    [vim.diagnostic.severity.WARN] = "",
                    [vim.diagnostic.severity.INFO] = "󰋼",
                    [vim.diagnostic.severity.HINT] = "󰌵",
                },
                numhl = {
                    [vim.diagnostic.severity.ERROR] = "",
                    [vim.diagnostic.severity.WARN] = "",
                    [vim.diagnostic.severity.HINT] = "",
                    [vim.diagnostic.severity.INFO] = "",
                },
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

            local config = require "plugins.lspconfig.configs"
            config.setup(client, bufnr)
        end

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local buffer = args.buf
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                on_attach(client, buffer)

                vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
            end,
        })
    end,
}
