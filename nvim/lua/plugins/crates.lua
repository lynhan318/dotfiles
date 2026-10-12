-- Version completion, hover docs and update actions inside Cargo.toml. The
-- in-process LSP route means blink.cmp picks the completions up like any
-- other server — no extra completion source to wire.
return {
  "saecki/crates.nvim",
  event = { "BufRead Cargo.toml" },
  opts = {
    lsp = {
      enabled = true,
      actions = true,
      completion = true,
      hover = true,
    },
  },
}
