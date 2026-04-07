require("ibl").setup({
  enabled = true,
  exclude = {
    filetypes = { "help", "Trouble", "lazy" },
  },
  scope = {
    highlight = {
      "RainbowDelimiterRed",
      "RainbowDelimiterYellow",
      "RainbowDelimiterBlue",
      "RainbowDelimiterOrange",
      "RainbowDelimiterGreen",
      "RainbowDelimiterViolet",
      "RainbowDelimiterCyan",
    },
  },
})
