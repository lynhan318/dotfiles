return {
    "smoka7/hop.nvim",
    keys = {{
        "f",
        "<cmd>HopChar1CurrentLine<cr>",
        desc = "Hop Char 1",
        mode = "n"
    }, {
        "F",
        "<cmd>HopChar2<cr>",
        desc = "Hop Char 2",
        mode = "n"
    }},
    config = function()
        require("hop").setup({
            keys = "etovxqpdygfblzhckisuran"
        })

    end
}
