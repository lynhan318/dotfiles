local M = {
  "L3MON4D3/LuaSnip",
  version = "~2.2.0",
  dependencies = {
    "rafamadriz/friendly-snippets",
    {
      "danymat/neogen",
      config = true,
      -- Uncomment next line if you want to follow only stable versions
      -- version = "*"
    },
  },
  build = "make install_jsregexp",
}

function M.config()
  local luasnip = require "luasnip"
  require "neogen"

  require("luasnip.loaders.from_vscode").lazy_load()

  luasnip.setup {
    link_roots = true,
    keep_roots = true,
    link_children = true,
    enable_autosnippets = true,
  }

  -- Stop trying to jump through a snippet when changing modes
  local unlinkgrp = vim.api.nvim_create_augroup("UnlinkSnippetOnModeChange", { clear = true })
  vim.api.nvim_create_autocmd("ModeChanged", {
    group = unlinkgrp,
    pattern = { "s:n", "i:*" },
    desc = "Forget the current snippet when leaving the insert mode",
    callback = function(evt)
      if luasnip.session and luasnip.session.current_nodes[evt.buf] and not luasnip.session.jump_active then
        luasnip.unlink_current()
      end
    end,
  })
end

return M
