-- Two complementary ways to preview markdown, because neither one alone covers
-- the whole job:
--
--   render-markdown.nvim  draws headings, tables, code blocks and callouts
--                         *in the buffer*, so the file stays editable while it
--                         looks rendered. No external deps — it reads the
--                         `markdown` / `markdown_inline` parsers that
--                         lua/plugins/treesitter.lua already installs.
--
--   markdown-preview.nvim opens a real browser tab with scroll-sync, for the
--                         things a terminal cannot draw: mermaid diagrams,
--                         KaTeX, and the actual GitHub stylesheet.
--
-- Inline *images* are already handled by snacks.image (see lua/plugins/snack.lua)
-- which draws them over the kitty graphics protocol that Ghostty speaks, so
-- neither plugin below needs to care about them.

return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "kyazdani42/nvim-web-devicons",
        },
        -- `mdx` is its own filetype (core/options.lua) but treesitter.lua maps it
        -- onto the markdown parser, so the same renderer works for both.
        ft = { "markdown", "mdx" },
        opts = {
            file_types = { "markdown", "mdx" },

            -- Uncover the raw text on whichever line the cursor sits on. Without
            -- this the concealed source shifts under you mid-edit, which is the
            -- single thing that makes in-buffer rendering unusable to type into.
            anti_conceal = { enabled = true },

            heading = {
                -- No sign column marker: signcolumn is "yes" globally and the
                -- icons below already say what level a heading is.
                sign = false,
                icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
                -- "block" stops the highlight bleeding to the window edge, which
                -- reads badly against the transparent background base16.lua sets.
                width = "block",
                left_pad = 0,
                right_pad = 2,
            },

            code = {
                sign = false,
                width = "block",
                right_pad = 2,
                -- Language name inset from the border rather than flush against it.
                language_pad = 2,
                border = "thick",
            },

            bullet = { icons = { "●", "○", "◆", "◇" } },

            checkbox = {
                unchecked = { icon = "󰄱 " },
                checked = { icon = "󰱒 " },
            },

            pipe_table = { preset = "round" },

            -- nvim 0.12 gives LSP hover / signature floats filetype=markdown, so
            -- this plugin used to render them too: `code.width = "block"` plus
            -- the thick border drew partial grey boxes inside the float. Leave
            -- those (buftype=nofile) to Neovim's own markdown float rendering.
            overrides = {
                buftype = {
                    nofile = { enabled = false },
                },
            },

            -- Needs the `latex` parser plus a `latex2text` binary, neither of
            -- which is installed here; leaving it on only earns a checkhealth
            -- warning and a per-buffer probe for a command that isn't there.
            latex = { enabled = false },
        },
        keys = {
            {
                "<leader>mr",
                "<cmd>RenderMarkdown toggle<cr>",
                desc = "Markdown: toggle in-buffer render",
            },
        },
    },

    {
        "iamcco/markdown-preview.nvim",
        -- Listed explicitly so the keymap below can pull the plugin in on demand
        -- rather than at startup; `ft` alone would load it for every .md opened.
        cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
        ft = { "markdown", "mdx" },
        build = "cd app && npx --yes yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown", "mdx" }

            -- With no browser named, the plugin falls back to `netrw#BrowserX`.
            -- core/options.lua sets g:loaded_netrw, which guards netrw's autoload
            -- file, so that fallback would fail — name a launcher explicitly.
            -- xdg-open rather than a hardcoded binary so this keeps following
            -- whatever the desktop default is (google-chrome as of writing).
            vim.g.mkdp_browser = "xdg-open"

            -- Leave the tab open when the buffer closes; the usual reason to
            -- close the buffer is to go edit something the preview is about.
            vim.g.mkdp_auto_close = 0
        end,
        keys = {
            {
                "<leader>mp",
                "<cmd>MarkdownPreviewToggle<cr>",
                desc = "Markdown: toggle browser preview",
            },
        },
    },
}
