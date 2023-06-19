return function()
  -- mappings
  vim.api.nvim_set_keymap('n', '<leader>p', ':Telescope find_files find_command=rg,--ignore,--hidden,--files<cr>', { noremap = true })
  vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope live_grep find_command=rg,--ignore,--hidden,--files<cr>', { noremap = true })
  vim.api.nvim_set_keymap('n', '<leader>b', ':Telescope buffers<cr>', { noremap = true })
  vim.api.nvim_set_keymap('n', '<leader>fh', ':Telescope help_tags<cr>', { noremap = true })

  vim.o.termguicolors = true
  local actions = require('telescope.actions')

  require('telescope').setup{
    defaults = {
      mappings = {
        i = {
          ["<esc>"] = actions.close,
        },
        n = {
          ["<esc>"] = actions.close,
        },
      },
      vimgrep_arguments = {
        'rg',
        '--hidden',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case'
      },
      prompt_position = "bottom",
      prompt_prefix = "> ",
      selection_caret = "> ",
      entry_prefix = "  ",
      prompt_prefix = "> ",
      selection_caret = "> ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "descending",
      layout_strategy = "horizontal",
      layout_defaults = {
        horizontal = {
          mirror = false,
        },
        vertical = {
          mirror = false,
        },
      },
      file_sorter =  require'telescope.sorters'.get_fuzzy_file,
      file_ignore_patterns = {"autoload/.*", "node_modules/.*", "plugged/.*", "android/.*", "ios/.*", "build/.*", "dist/.*", ".git/.*"},
      generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
      shorten_path = true,
      winblend = 0,
      width = 0.75,
      preview_cutoff = 60,
      results_height = 1,
      results_width = 0.8,
      border = {},
      borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      color_devicons = true,
      use_less = true,
      set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
      file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
      grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
      qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
  
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
    }
  }
end
