return {
    {
        "herdr-claude",
        dir = vim.fn.stdpath "config",
        name = "herdr-claude",
        lazy = true,
        keys = {
            {
                "<leader>cc",
                function()
                    if vim.env.HERDR_PANE_ID and vim.env.HERDR_PANE_ID ~= "" then
                        require("herdr_claude").send_selection()
                    else
                        require("claudecode_tmux").send_selection()
                    end
                end,
                mode = "v",
                desc = "Send selection location to Claude (herdr/tmux)",
            },
        },
        config = function() end,
    },
}
