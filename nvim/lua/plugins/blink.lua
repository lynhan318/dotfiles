require("blink.cmp").setup({
  keymap = {
    preset = "default",
    ["<CR>"] = { "accept", "fallback" },
    ["<Tab>"] = { "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "snippet_backward", "fallback" },
    ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
    ["<C-u>"] = { "scroll_documentation_up", "fallback" },
    ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
    ["<C-n>"] = { "select_next", "fallback_to_mappings" },
  },
  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
    },
  },
  signature = {
    enabled = true,
    trigger = {
      enabled = true,
      show_on_keyword = false,
      show_on_trigger_character = true,
      show_on_insert = false,
      show_on_insert_on_trigger_character = true,
    },
    window = {
      treesitter_highlighting = true,
      show_documentation = false,
    },
  },
  appearance = {
    use_nvim_cmp_as_default = true,
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
})
