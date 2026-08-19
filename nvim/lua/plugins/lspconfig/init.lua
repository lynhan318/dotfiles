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
                    ensure_installed = { "lua_ls", "cssls", "tailwindcss", "jsonls", "rust_analyzer", "svelte" },
                    -- TypeScript is served by the native TS 7 binary (see
                    -- plugins.lspconfig.typescript), so keep Mason from enabling
                    -- typescript-language-server alongside it.
                    automatic_enable = { exclude = { "ts_ls" } },
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
        -- Baseline for every server: no dynamic file watching. Servers that ask
        -- for it make Neovim watch the whole project (node_modules included) and
        -- re-send changes the server already sees through didOpen/didChange.
        vim.lsp.config("*", {
            capabilities = {
                workspace = {
                    didChangeWatchedFiles = { dynamicRegistration = false },
                },
            },
        })

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
        -- TypeScript 7's compiler binary is itself the language server, replacing
        -- typescript-language-server and the Node tsserver it drove: one Go
        -- process per project root, no JS heap to blow out.
        local typescript = require "plugins.lspconfig.typescript"
        vim.lsp.config("tsc", {
            cmd = typescript.cmd,
            root_dir = typescript.root_dir,
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        })
        vim.lsp.enable "tsc"
        -- Rooted at the nearest package that actually uses Tailwind, never at the
        -- repository, so a monorepo does not hand the server every app at once.
        local tailwind = require "plugins.lspconfig.tailwind"
        vim.lsp.config("tailwindcss", {
            root_dir = tailwind.root_dir,
            settings = tailwind.settings,
            -- Tailwind claims 50 filetypes, plain `typescript`/`javascript` among
            -- them, so any .ts buffer in a Tailwind package starts the server.
            -- Markup only; .tsx/.jsx keep their class completion.
            filetypes = tailwind.filetypes(vim.lsp.config.tailwindcss.filetypes),
        })
        vim.lsp.enable "tailwindcss"
        vim.lsp.enable "cssls"
        vim.lsp.enable "svelte"
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

        -- A single bundled or generated file is enough to pin a server at 100%
        -- CPU, re-parsing and re-tokenising on every keystroke. Semantic tokens
        -- go first (treesitter still highlights); past a megabyte the server has
        -- nothing useful to say about the file at all.
        local NO_SEMANTIC_TOKENS_BYTES = 256 * 1024
        local NO_LSP_BYTES = 1024 * 1024

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local buffer = args.buf
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if not client then
                    return
                end

                local size = vim.api.nvim_buf_get_offset(buffer, vim.api.nvim_buf_line_count(buffer))
                if size > NO_LSP_BYTES then
                    vim.schedule(function()
                        if vim.api.nvim_buf_is_valid(buffer) then
                            vim.lsp.buf_detach_client(buffer, client.id)
                        end
                    end)
                    return
                end
                if size > NO_SEMANTIC_TOKENS_BYTES then
                    vim.lsp.semantic_tokens.enable(false, { bufnr = buffer, client_id = client.id })
                end

                on_attach(client, buffer)

                vim.lsp.inlay_hint.enable(false, { bufnr = buffer })
            end,
        })
    end,
}
