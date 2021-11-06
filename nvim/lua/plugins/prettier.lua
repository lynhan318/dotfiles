return function()
    local formatter = require('formatter')

    local function prettier()
        return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
            stdin = true
        }
    end

    vim.api.nvim_exec([[
        augroup FormatAutogroup
          autocmd!
          autocmd BufWritePost *.js,*.mjs,*.ts,*.rs,*.lua,*.jsx,*.tsx,*.md,*.mdx,*.yml,*.json,*.css,*.scss,*.html FormatWrite
        augroup END
    ]], true)

    formatter.setup({
        logging = false,
        filetype = {
            javascriptreact = {prettier},
            typescriptreact = {prettier},
            typescript = {prettier},
            javascript = {prettier},
            html = {prettier},
            css = {prettier},
            json = {prettier},
            scss = {prettier},
            yaml = {prettier},
            markdown = {prettier},
            rust = {
                -- Rustfmt
                function()
                    return {
                        exe = "rustfmt",
                        args = {"--emit=stdout"},
                        stdin = true
                    }
                end
            },
            lua = {
                -- luafmt
                function()
                    return {exe = "lua-format", stdin = true}
                end
            }

        }
    })
end
