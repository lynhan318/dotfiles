require("which-key").setup({
  preset = "modern",
  delay = 400,
})

require("which-key").add({
  { "<leader>c", group = "code" },
  { "<leader>f", group = "find / file" },
  { "<leader>g", group = "git" },
  { "<leader>i", group = "inlay" },
  { "<leader>m", group = "multicursor" },
  { "<leader>r", group = "rename / refactor" },
  { "<leader>s", group = "search / symbols" },
  { "<leader>x", group = "diagnostics / trouble" },
})
