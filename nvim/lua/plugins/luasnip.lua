local luasnip = require("luasnip")
pcall(require, "neogen")

require("luasnip.loaders.from_vscode").lazy_load()

luasnip.setup({
  link_roots = true,
  keep_roots = true,
  link_children = true,
  enable_autosnippets = true,
})

local unlinkgrp = vim.api.nvim_create_augroup("UnlinkSnippetOnModeChange", { clear = true })
vim.api.nvim_create_autocmd("ModeChanged", {
  group = unlinkgrp,
  pattern = { "s:n", "i:*" },
  desc = "Forget the current snippet when leaving insert mode",
  callback = function(evt)
    if luasnip.session and luasnip.session.current_nodes[evt.buf] and not luasnip.session.jump_active then
      luasnip.unlink_current()
    end
  end,
})
