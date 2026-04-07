require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "vim", "lua", "html", "css", "typescript", "tsx", "svelte",
    "javascript", "c", "markdown", "markdown_inline", "rust",
  },
  ignore_install = {},
  endwise = { enable = true },
  autotag = { enable = true },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      scope_incremental = "<CR>",
      node_incremental = "<Tab>",
      node_decremental = "<S-Tab>",
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ic"] = "@conditional.inner",
        ["ac"] = "@conditional.outer",
        ["il"] = "@loop.inner",
        ["al"] = "@loop.outer",
        ["ib"] = "@block.inner",
        ["ab"] = "@block.outer",
      },
      selection_modes = {
        ["@parameter.outer"] = "v",
        ["@function.outer"] = "V",
        ["@class.outer"] = "<c-v>",
      },
      include_surrounding_whitespace = true,
    },
  },
})

vim.treesitter.language.register("markdown", "mdx")

-- treesitter-context
local ok_ctx, ctx = pcall(require, "treesitter-context")
if ok_ctx then
  ctx.setup({
    max_lines = 3,
    multiline_threshold = 1,
    min_window_height = 20,
  })
  vim.keymap.set("n", "[c", function()
    if vim.wo.diff then
      return "[c"
    else
      vim.schedule(function() ctx.go_to_context() end)
      return "<Ignore>"
    end
  end, { expr = true, desc = "Jump to upper context" })
end

-- ts-autotag (separate module)
pcall(function() require("nvim-ts-autotag").setup() end)
