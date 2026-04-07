require("lualine").setup({
  options = {
    theme = "everforest",
    globalstatus = true,
    component_separators = { left = "│", right = "│" },
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = {
      { "filename", path = 1 },
      {
        function()
          local ok, navic = pcall(require, "nvim-navic")
          return (ok and navic.is_available()) and navic.get_location() or ""
        end,
      },
    },
    lualine_x = {
      {
        function()
          local clients = vim.lsp.get_clients({ bufnr = 0 })
          if #clients == 0 then return "" end
          local names = {}
          for _, c in ipairs(clients) do table.insert(names, c.name) end
          return " " .. table.concat(names, ", ")
        end,
      },
      "encoding",
      "filetype",
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})
