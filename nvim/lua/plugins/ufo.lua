return {
  "kevinhwang91/nvim-ufo",
  version = false,
  event = { "VeryLazy", "InsertEnter" },
  dependencies = { "kevinhwang91/promise-async" },
  keys = {
    {
      "zM",
      function()
        require("ufo").closeAllFolds()
      end,
      desc = "Close all folds",
    },
    {
      "zR",
      function()
        require("ufo").openAllFolds()
      end,
      desc = "Open all folds",
    },
  },
  opts = {
    open_fold_hl_timeout = 200,
    preview = {
      mappings = {
        scrollB = "<C-b>",
        scrollF = "<C-f>",
        scrollU = "<C-u>",
        scrollD = "<C-d>",
      },
    },
    provider_selector = function(_, filetype, buftype)
      local function handleFallbackException(bufnr, err, providerName)
        if type(err) == "string" and err:match("UfoFallbackException") then
          return require("ufo").getFolds(bufnr, providerName)
        else
          return require("promise").reject(err)
        end
      end

      return (filetype == "" or buftype == "nofile") and "indent" -- only use indent until a file is opened
        or function(bufnr)
          return require("ufo")
            .getFolds(bufnr, "lsp")
            :catch(function(err)
              return handleFallbackException(bufnr, err, "treesitter")
            end)
            :catch(function(err)
              return handleFallbackException(bufnr, err, "indent")
            end)
        end
    end,
    fold_virt_text_handler = function(virtual_text, lnum, end_lnum, width, truncate)
      local new_virtual_text = {}
      local suffix = (" %d "):format(end_lnum - lnum)
      local suffix_width = vim.fn.strdisplaywidth(suffix)
      local target_width = width - suffix_width
      local current_width = 0
      for _, chunk in ipairs(virtual_text) do
        local chunk_text = chunk[1]
        local chunk_width = vim.fn.strdisplaywidth(chunk_text)
        if target_width > current_width + chunk_width then
          table.insert(new_virtual_text, chunk)
        else
          chunk_text = truncate(chunk_text, target_width - current_width)
          local hl_group = chunk[2]
          table.insert(new_virtual_text, { chunk_text, hl_group })
          chunk_width = vim.fn.strdisplaywidth(chunk_text)
          -- str width returned from truncate() may less than 2nd argument, need padding
          if current_width + chunk_width < target_width then
            suffix = suffix .. (" "):rep(target_width - current_width - chunk_width)
          end
          break
        end
        current_width = current_width + chunk_width
      end
      table.insert(new_virtual_text, { suffix, "MoreMsg" })
      return new_virtual_text
    end,
  },
}
