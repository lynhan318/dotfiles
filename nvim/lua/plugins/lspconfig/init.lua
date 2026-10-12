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

        -- Clippy on save through the server instead of a second `cargo clippy`
        -- from nvim-lint: one cargo process on the target-dir lock, and the
        -- lints arrive with quick-fixes (code actions) attached.
        vim.lsp.config("rust_analyzer", {
            settings = {
                ["rust-analyzer"] = {
                    check = { command = "clippy" },
                    cargo = { features = "all" },
                    inlayHints = {
                        chainingHints = { enable = true },
                        closureReturnTypeHints = { enable = "with_block" },
                        lifetimeElisionHints = { enable = "skip_trivial", useParameterNames = true },
                    },
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
        -- Deno, for packages/bevize. Kept apart from tsc by root, not by luck:
        -- denols needs a deno.json above the file, and tsc declines any buffer
        -- that has one (see plugins.lspconfig.typescript).
        vim.lsp.config("denols", {
            root_markers = { "deno.json", "deno.jsonc" },
            settings = { deno = { enable = true } },
        })
        vim.lsp.enable "denols"
        -- zls must match Zig's minor version (Zig 0.16.0 -> zls 0.16.0). The
        -- pacman package is 0.15.1, so the binary in ~/.local/bin comes from
        -- builds.zigtools.org. Filetypes/root markers (build.zig, zls.json,
        -- .git) come from lspconfig; nvim treats .zig.zon as filetype zig too.
        -- Keys are the zls 0.16 schema (`zls --version` / schema.json);
        -- `enable_inlay_hints` is gone, hints are toggled client-side below.
        vim.lsp.config("zls", {
            cmd = { "zls" },
            settings = {
                zls = {
                    enable_snippets = true,
                    enable_argument_placeholders = true,
                    semantic_tokens = "full",
                    warn_style = true,
                    -- Compile errors as diagnostics: zls runs `zig build check
                    -- --watch` when build.zig has a "check" step, otherwise the
                    -- install step. Plain ast-check only reports syntax/unused.
                    enable_build_on_save = true,
                    inlay_hints_show_variable_type_hints = true,
                    inlay_hints_show_struct_literal_field_type = true,
                    inlay_hints_show_parameter_name = true,
                    inlay_hints_show_builtin = true,
                    inlay_hints_exclude_single_argument = true,
                    inlay_hints_hide_redundant_param_names = true,
                    inlay_hints_hide_redundant_param_names_last_token = true,
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
                        if not vim.api.nvim_buf_is_valid(buffer) then
                            return
                        end
                        vim.lsp.buf_detach_client(buffer, client.id)
                        -- Say so. A buffer that silently loses every LSP feature
                        -- is indistinguishable from a broken server.
                        vim.notify(
                            ("%s: detached %s, %.1f MB exceeds the %d MB LSP limit"):format(
                                vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buffer), ":t"),
                                client.name,
                                size / 1048576,
                                NO_LSP_BYTES / 1048576
                            ),
                            vim.log.levels.WARN
                        )
                    end)
                    return
                end
                if size > NO_SEMANTIC_TOKENS_BYTES then
                    vim.lsp.semantic_tokens.enable(false, { bufnr = buffer, client_id = client.id })
                end

                on_attach(client, buffer)

                -- Inlay hints stay off by default; zls's and rust-analyzer's
                -- (types, parameter names, chaining) are worth it while
                -- learning those languages. <leader>ih toggles.
                local hint_languages = { zls = true, rust_analyzer = true }
                vim.lsp.inlay_hint.enable(hint_languages[client.name] == true, { bufnr = buffer })
                if client:supports_method("textDocument/inlayHint") then
                    vim.keymap.set("n", "<leader>ih", function()
                        local enabled = vim.lsp.inlay_hint.is_enabled { bufnr = buffer }
                        vim.lsp.inlay_hint.enable(not enabled, { bufnr = buffer })
                    end, { buffer = buffer, desc = "LSP: Toggle inlay hints" })
                end
            end,
        })
    end,
}
