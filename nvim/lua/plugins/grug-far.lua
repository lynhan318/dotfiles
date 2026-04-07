require("grug-far").setup({
  folding = { enabled = false },
  resultLocation = { showNumberLabel = false },
})
vim.keymap.set({ "n", "v" }, "<leader>cg", function()
  require("grug-far").open({ transient = true })
end, { desc = "GrugFar" })
