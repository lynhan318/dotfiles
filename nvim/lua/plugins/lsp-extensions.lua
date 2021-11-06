return function()
    require'lsp_extensions'.inlay_hints {
        prefix = '',
        highlight = "Comment",
        enabled = {"TypeHint", "ChainingHint", "ParameterHint"}
    }
end
