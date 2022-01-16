return function() -- TODO figure out why this don't work
    local protocol = require('vim.lsp.protocol')
    local lspconfig = require('lspconfig')
    local lsp = vim.lsp

    local map_opts = {silent = true, noremap = true}
    local border_opts = {border = 'rounded', focusable = false, scope = 'line'}

    vim.fn.sign_define('DiagnosticSignError',
                       {text = '✗', texthl = 'DiagnosticSignError'})
    vim.fn.sign_define('DiagnosticSignWarn',
                       {text = '!', texthl = 'DiagnosticSignWarn'})
    vim.fn.sign_define('DiagnosticSignInformation',
                       {text = '', texthl = 'DiagnosticSignInfo'})
    vim.fn.sign_define('DiagnosticSignHint',
                       {text = '', texthl = 'DiagnosticSignHint'})

    -- handlers
    lsp.handlers['textDocument/signatureHelp'] =
        lsp.with(lsp.handlers.signature_help, border_opts)

    lsp.handlers['textDocument/hover'] =
        lsp.with(lsp.handlers.hover, border_opts)

    lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(vim.lsp
                                                                   .diagnostic
                                                                   .on_publish_diagnostics,
                                                               {
        virtual_text = false,
        signs = true,
        update_in_insert = false,
        underline = true
    })

    local function documentHighlight(client, bufnr)
        if client.resolved_capabilities.document_highlight then
            vim.api.nvim_exec([[
          hi LspReferenceRead cterm=bold ctermbg=red guibg=#34495e
          hi LspReferenceText cterm=bold ctermbg=red guibg=#34495e
          hi LspReferenceWrite cterm=bold ctermbg=red guibg=#34495e
          augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
          augroup END
        ]], false)
        end

        if client.resolved_capabilities.signature_help then
            vim.cmd(
                'autocmd CursorHoldI <buffer> lua vim.lsp.buf.signature_help()')
        end
    end

    local function lspSetup()
        vim.cmd("nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>")
        vim.cmd("nnoremap <silent> rn <cmd>lua vim.lsp.buf.rename()<CR>")
        vim.cmd('nnoremap <silent> gs <cmd>lua vim.lsp.buf.signature_help()<CR>')
        vim.cmd("nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>")
        vim.cmd("nnoremap <silent> gr <cmd>Telescope lsp_references<CR>")
        vim.cmd("nnoremap <silent> gi <cmd>Telescope lsp_implementations<CR>")
        vim.cmd("nnoremap <silent> ca <cmd>lua vim.lsp.buf.code_action()<CR>")
        -- vim.cmd("nnoremap <silent> gD <cmd>Telescope diagnostics<CR>")
        -- vim.cmd("nnoremap <silent> ca <cmd>Telescope lsp_code_actions<CR>")
        vim.cmd("nnoremap <silent> gD <cmd>lua vim.diagnostic.open_float()<CR>")
        vim.cmd("nnoremap <silent> g[ <cmd>lua vim.diagnostic.goto_prev()<CR>")
        vim.cmd("nnoremap <silent> g] <cmd>lua vim.diagnostic.goto_next()<CR>")

        vim.cmd(
            'command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()')
    end

    local function commonAttach(client, bufnr)
        documentHighlight(client, bufnr)
        lspSetup()
    end

    local servers = {
        cssls = {cmd = {'css-languageserver', '--stdio'}},
        html = {cmd = {'html-languageserver', '--stdio'}},
        jsonls = {cmd = {'vscode-json-languageserver', '--stdio'}},
        rust_analyzer = {
            settings = {
                ["rust-analyzer"] = {checkOnSave = {command = "clippy"}}
            }
        },
        tsserver = {},
        vimls = {}
    }
    for server, config in pairs(servers) do
        if type(config) == 'function' then config = config() end
        config.on_attach = commonAttach
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        config.capabilities = require('cmp_nvim_lsp').update_capabilities(
                                  capabilities)

        lspconfig[server].setup(config)
    end
end
