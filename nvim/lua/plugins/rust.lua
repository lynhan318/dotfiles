return function()
    local nvim_lsp = require 'lspconfig'
    local opts = {
        tools = {
            autoSetHints = true,
            hover_with_actions = true,
            -- runnables = {use_telescope = true},
            inlay_hints = {
                show_parameter_hints = false,
                parameter_hints_prefix = "",
                other_hints_prefix = "» "
            }
        }
    }

    require('rust-tools').setup(opts)
end
