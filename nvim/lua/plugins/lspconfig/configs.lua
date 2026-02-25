local M = {}

function M.setup(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gD", "<cmd>Lspsaga finder<cr>", bufopts)
    vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "gv", "<cmd>vs<CR><cmd>lua vim.lsp.buf.definition()<CR>", bufopts)
    vim.keymap.set("n", "gs", "<cmd>sp<CR><cmd>lua vim.lsp.buf.definition()<CR>", bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "<leader>rf", vim.lsp.buf.rename, bufopts)
    -- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<cr>", bufopts)
    vim.keymap.set("n", "[w", "<cmd>Lspsaga show_cursor_diagnostics<cr>")
    vim.keymap.set("n", "[b", "<cmd>Lspsaga show_buf_diagnostics<cr>")
    vim.keymap.set("n", "t", "<cmd>Lspsaga term_toggle<cr>", bufopts)
    -- vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<cr>", bufopts)

    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
        vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
        vim.api.nvim_create_autocmd("CursorHold", {
            callback = function()
                -- Double check capability before calling to avoid errors
                local clients = vim.lsp.get_clients({ bufnr = bufnr })
                for _, c in ipairs(clients) do
                    if c.server_capabilities.documentHighlightProvider then
                        vim.lsp.buf.document_highlight()
                        return
                    end
                end
            end,
            buffer = bufnr,
            group = "lsp_document_highlight",
            desc = "Document Highlight",
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            callback = vim.lsp.buf.clear_references,
            buffer = bufnr,
            group = "lsp_document_highlight",
            desc = "Clear All the References",
        })
    end
end

function M.kind()
    require("lspkind").init {
        mode = "symbol_text",
        preset = "codicons",
        symbol_map = {
            Text = "󰉿",
            Method = "󰆧",
            Function = "󰊕",
            Constructor = "",
            Field = "󰜢",
            Variable = "󰀫",
            Class = "󰠱",
            Interface = "",
            Module = "",
            Property = "󰜢",
            Unit = "󰑭",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = "󰈇",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "󰙅",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "",
        },
    }
end

return M
