return {
    {
        "claudecode-tmux",
        dir = vim.fn.stdpath "config",
        name = "claudecode-tmux",
        lazy = true,
        keys = {
            {
                "<leader>cc",
                function()
                    require("claudecode_tmux").send_selection()
                end,
                mode = "v",
                desc = "Send selection to Claude Code",
            },
        },
        config = function() end,
    },
}
