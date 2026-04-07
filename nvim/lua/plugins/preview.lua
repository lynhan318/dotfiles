require("goto-preview").setup({
  width = 120,
  height = 24,
  border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" },
  default_mappings = false,
  debug = false,
  resizing_mappings = false,
  focus_on_open = true,
  dismiss_on_move = false,
  force_close = true,
  bufhidden = "wipe",
  stack_floating_preview_windows = true,
  preview_window_title = { enable = true, position = "left" },
})

local map = vim.keymap.set
map("n", "gpd", function() require("goto-preview").goto_preview_definition() end, { desc = "Preview Definition" })
map("n", "gpi", function() require("goto-preview").goto_preview_implementation() end, { desc = "Preview Implementation" })
map("n", "gpr", function() require("goto-preview").goto_preview_references() end, { desc = "Preview References" })
map("n", "gpD", function() require("goto-preview").close_all_win() end, { desc = "Close all previews" })
