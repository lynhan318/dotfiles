-- img-clip (optional dep of avante)
pcall(function()
  require("img-clip").setup({
    default = {
      embed_image_as_base64 = false,
      prompt_for_file_name = false,
      drag_and_drop = { insert_mode = true },
      use_absolute_path = true,
    },
  })
end)

-- render-markdown
pcall(function()
  require("render-markdown").setup({
    file_types = { "Avante" },
  })
end)

require("avante").setup({
  provider = "copilot",
  auto_suggestions_provider = "copilot",
  providers = {
    copilot = {
      model = "gpt-5.4",
      extra_request_body = {
        max_tokens = vim.NIL,
        max_completion_tokens = 20480,
      },
    },
    openai = {
      model = "gpt-5.4",
      extra_request_body = {
        max_completion_tokens = 20480,
      },
    },
  },
})
