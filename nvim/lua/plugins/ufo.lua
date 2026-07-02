return {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        provider_selector = function(_, ft, _)
            if ft == "" or ft == "git" then
                return ""
            end
            return { "treesitter", "indent" }
        end,
    },
    keys = {
        { "zR", function() require("ufo").openAllFolds() end,  desc = "UFO open all folds" },
        { "zM", function() require("ufo").closeAllFolds() end, desc = "UFO close all folds" },
        { "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "UFO open folds except kinds" },
        { "zm", function() require("ufo").closeFoldsWith() end, desc = "UFO close folds with level" },
        { "zp", function() require("ufo").peekFoldedLinesUnderCursor() end, desc = "UFO peek fold" },
    },
}
