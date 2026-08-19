local M = {}

-- Document highlight sends a request every time the cursor rests (updatetime is
-- 250ms), so keep it off buffers big enough for that to cost real CPU.
local HIGHLIGHT_MAX_BYTES = 256 * 1024

-- Created once: clearing the group on every attach would wipe the autocmds of
-- every other buffer that already has a client.
local highlight_group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })

function M.setup(client, bufnr)
    if client:supports_method("textDocument/documentHighlight") then
        if vim.api.nvim_buf_get_offset(bufnr, vim.api.nvim_buf_line_count(bufnr)) > HIGHLIGHT_MAX_BYTES then
            return
        end
        vim.api.nvim_clear_autocmds { buffer = bufnr, group = highlight_group }
        vim.api.nvim_create_autocmd("CursorHold", {
            callback = function()
                vim.lsp.buf.document_highlight()
            end,
            buffer = bufnr,
            group = highlight_group,
            desc = "Document Highlight",
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            callback = vim.lsp.buf.clear_references,
            buffer = bufnr,
            group = highlight_group,
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
