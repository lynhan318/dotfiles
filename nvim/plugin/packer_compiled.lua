-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/kevin/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/kevin/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/kevin/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/kevin/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/kevin/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["auto-pairs"] = {
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/auto-pairs",
    url = "https://github.com/jiangmiao/auto-pairs"
  },
  ["barbar.nvim"] = {
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/barbar.nvim",
    url = "https://github.com/romgrk/barbar.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lsp-signature-help"] = {
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp-signature-help",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help"
  },
  ["cmp-nvim-ultisnips"] = {
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/cmp-nvim-ultisnips",
    url = "https://github.com/quangnguyen30192/cmp-nvim-ultisnips"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["crates.nvim"] = {
    config = { "\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vcrates\frequire\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/crates.nvim",
    url = "https://github.com/saecki/crates.nvim"
  },
  everforest = {
    config = { "\27LJ\2\nø\1\0\0\4\0\t\0\0196\0\0\0009\0\1\0\18\1\0\0'\3\2\0B\1\2\0016\1\0\0009\1\3\1'\2\5\0=\2\4\1\18\1\0\0'\3\6\0B\1\2\1\18\1\0\0'\3\a\0B\1\2\1\18\1\0\0'\3\b\0B\1\2\1K\0\1\0\22set termguicolors\24set background=dark\27colorscheme everforest\tsoft\26everforest_background\6g\14syntax on\bcmd\bvim\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/everforest",
    url = "https://github.com/sainnhe/everforest"
  },
  ["formatter.nvim"] = {
    config = { "\27LJ\2\nÄ\1\0\0\5\0\6\1\n5\0\0\0005\1\1\0006\2\2\0009\2\3\0029\2\4\2)\4\0\0B\2\2\0?\2\0\0=\1\5\0L\0\2\0\targs\22nvim_buf_get_name\bapi\bvim\1\2\0\0\21--stdin-filepath\1\0\2\bexe\rprettier\nstdin\2\5ÄÄ¿ô\4(\0\0\1\0\1\0\0025\0\0\0L\0\2\0\1\0\2\nstdin\2\bexe\15lua-formatÊ\4\1\0\b\0\25\00086\0\0\0'\2\1\0B\0\2\0023\1\2\0006\2\3\0009\2\4\0029\2\5\2'\4\6\0+\5\2\0B\2\3\0019\2\a\0005\4\b\0005\5\t\0004\6\3\0>\1\1\6=\6\n\0054\6\3\0>\1\1\6=\6\v\0054\6\3\0>\1\1\6=\6\f\0054\6\3\0>\1\1\6=\6\r\0054\6\3\0>\1\1\6=\6\14\0054\6\3\0>\1\1\6=\6\15\0054\6\3\0>\1\1\6=\6\16\0054\6\3\0>\1\1\6=\6\17\0054\6\3\0>\1\1\6=\6\18\0054\6\3\0>\1\1\6=\6\19\0054\6\3\0>\1\1\6=\6\20\0054\6\3\0>\1\1\6=\6\21\0054\6\3\0003\a\22\0>\a\1\6=\6\23\5=\5\24\4B\2\2\1K\0\1\0\rfiletype\blua\0\rmarkdown\tyaml\tscss\tjson\bvue\bcss\vsvelte\thtml\15javascript\15typescript\20typescriptreact\20javascriptreact\1\0\0\1\0\1\flogging\1\nsetupÿ\1        augroup FormatAutogroup\n          autocmd!\n          autocmd BufWritePost *.js,*.mjs,*.ts,*.lua,*.jsx,*.tsx,*.md,*.mdx,*.yml,*.json,*.css,*.scss,*.html,*.vue,*.svelte FormatWrite\n        augroup END\n    \14nvim_exec\bapi\bvim\0\14formatter\frequire\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/formatter.nvim",
    url = "https://github.com/mhartington/formatter.nvim"
  },
  fzf = {
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/fzf",
    url = "https://github.com/junegunn/fzf"
  },
  ["fzf.vim"] = {
    config = { "\27LJ\2\n‰\1\0\0\3\0\6\0\0176\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\0016\0\0\0009\0\1\0'\2\4\0B\0\2\0016\0\0\0009\0\1\0'\2\5\0B\0\2\1K\0\1\0(nnoremap <Leader>s <cmd>GFiles?<CR>0nnoremap <nowait><Leader>b <cmd>Buffers<CR>#nnoremap <Leader>l <cmd>Rg<CR>&nnoremap <Leader>p <cmd>Files<CR>\bcmd\bvim\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/fzf.vim",
    url = "https://github.com/junegunn/fzf.vim"
  },
  ["goto-preview"] = {
    config = { "\27LJ\2\n>\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\17goto-preview\frequire\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/goto-preview",
    url = "https://github.com/rmagatti/goto-preview"
  },
  ["hop.nvim"] = {
    config = { "\27LJ\2\n˝\1\0\0\5\0\14\0\0286\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0'\3\b\0'\4\t\0B\0\4\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0'\3\n\0'\4\v\0B\0\4\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0'\3\f\0'\4\r\0B\0\4\1K\0\1\0\25<cmd>:HopPattern<cr>\afe\22<cmd>:HopLine<cr>\afl\23<cmd>:HopChar2<cr>\afw\6n\bset\vkeymap\bvim\1\0\1\tkeys\28etovxqpdygfblzhckisuran\nsetup\bhop\frequire\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/hop.nvim",
    url = "https://github.com/phaazon/hop.nvim"
  },
  ["html5.vim"] = {
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/html5.vim",
    url = "https://github.com/othree/html5.vim"
  },
  ["lspsaga.nvim"] = {
    config = { "\27LJ\2\nΩ\2\0\4\n\0\16\00299\4\0\0009\4\1\0049\5\0\0009\5\2\5\a\2\3\0X\6\fÄ\t\1\0\0X\6\1ÄX\6/Ä6\6\4\0009\6\5\0069\6\6\0069\b\a\4\22\b\1\b9\t\b\4\22\t\1\tB\6\3\1X\6&Ä\a\2\t\0X\6\14Ä\a\3\n\0X\6\3Ä6\6\v\0'\b\f\0B\6\2\0016\6\4\0009\6\5\0069\6\6\0069\b\a\5\22\b\1\b9\t\b\5\22\t\1\tB\6\3\1X\6\22Ä\a\2\r\0X\6\20Ä6\6\4\0009\6\5\0069\6\6\0069\b\a\4\22\b\1\b9\t\b\4\22\t\1\tB\6\3\0016\6\4\0009\6\14\6'\b\15\0B\6\2\0016\6\4\0009\6\5\0069\6\6\0069\b\a\5\22\b\1\b9\t\b\5\22\t\1\tB\6\3\1K\0\1\0\rnormal v\bcmd\6m\flspsaga\nprint\6s\6r\14character\tline\vcursor\afn\bvim\6l\bend\nstart\nrange\4\2¥\3\0\1\15\0\26\0@6\1\0\0'\3\1\0B\1\2\0029\1\2\1B\1\1\0026\2\3\0009\2\4\0029\2\5\2'\4\6\0B\2\2\2\a\2\a\0X\2\2Ä'\2\a\0L\2\2\0\v\0\1\0X\2\1ÄL\1\2\0006\2\3\0009\2\b\0029\2\t\2B\2\1\0029\2\n\2\a\2\v\0X\2\2Ä'\2\f\0X\3\1Ä'\2\r\0006\3\3\0009\3\14\0036\5\15\0009\5\16\0056\a\3\0009\a\4\a9\a\17\a'\t\18\0B\a\2\2'\b\19\0'\t\a\0B\5\4\2\18\6\2\0B\3\3\2'\4\a\0006\5\20\0\18\a\3\0B\5\2\4X\b\fÄ\6\t\21\0X\n\2Ä\a\t\22\0X\n\2Ä'\4\a\0X\n\6Ä\18\n\4\0\18\v\t\0'\f\23\0'\r\24\0'\14\25\0&\4\14\nE\b\3\3R\bÚ\127\18\5\4\0\18\6\1\0&\5\6\5L\5\2\0\b %*\29%#LspSagaWinbarSep#Ôëä%*\6 \6~\6.\vipairs\a%%\f%:~:.:h\vexpand\tgsub\vstring\nsplit\6/\6\\\fWindows\fsysname\ros_uname\tloop\5\6%\fbufname\afn\bvim\18get_file_name\25lspsaga.symbolwinbar\frequireﬂ\2\0\0\b\1\14\0,5\0\0\0006\1\1\0009\1\2\0019\1\3\1)\3\0\0B\1\2\0029\1\4\1\14\0\1\0X\2\6Ä6\1\1\0009\1\5\0019\1\6\0018\1\1\0\15\0\1\0X\2\5Ä6\1\1\0009\1\a\1'\2\t\0=\2\b\1X\1\23Ä6\1\n\0006\3\v\0'\4\f\0B\1\3\3+\3\0\0\15\0\1\0X\4\3Ä9\4\r\2B\4\1\2\18\3\4\0'\4\t\0-\5\0\0+\a\2\0B\5\2\2\18\4\5\0\n\3\0\0X\5\3Ä\18\5\4\0\18\6\3\0&\4\6\0056\5\1\0009\5\a\5=\4\b\5K\0\1\0\1¿\20get_symbol_node\25lspsaga.symbolwinbar\frequire\npcall\5\vwinbar\awo\rfiletype\abo\vzindex\24nvim_win_get_config\bapi\bvim\1\0\6\rneo-tree\2\vprompt\2\thelp\2\fNeotree\2\15toggleterm\2\fteminal\2\21\0\0\2\1\0\0\3-\0\0\0B\0\1\1K\0\1\0\2¿\21\0\0\2\1\0\0\3-\0\0\0B\0\1\1K\0\1\0\2¿◊\t\1\0\n\0*\00096\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0034\4\0\0=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\0035\4\15\0=\4\16\0035\4\17\0003\5\18\0=\5\19\4=\4\20\0035\4\21\0=\4\22\0034\4\0\0=\4\23\3B\1\2\0013\1\24\0003\2\25\0005\3\26\0006\4\27\0009\4\28\0049\4\29\4\18\6\3\0005\a\30\0003\b\31\0=\b \aB\4\3\0016\4\27\0009\4\28\0049\4\29\4'\6!\0005\a\"\0003\b#\0=\b \aB\4\3\0016\4\27\0009\4$\0049\4%\4'\6&\0'\a'\0'\b(\0005\t)\0B\4\5\0012\0\0ÄK\0\1\0\1\0\1\vsilent\2\29<cmd>LSoutlineToggle<CR>\14<leader>o\6n\bset\vkeymap\0\1\0\1\fpattern\24LspsagaUpdateSymbol\tUser\rcallback\0\1\0\1\fpattern\6*\24nvim_create_autocmd\bapi\bvim\1\4\0\0\rBufEnter\16BufWinEnter\16CursorMoved\0\0\24server_filetype_map\17show_outline\1\0\b\17win_position\nright\rjump_key\6o\17auto_refresh\2\14virt_text\b‚îÉ\17auto_preview\2\15auto_enter\2\14win_width\3\30\rwin_with\5\21symbol_in_winbar\18click_support\0\1\0\1\14in_custom\2\21code_action_keys\1\0\2\tquit\6q\texec\t<CR>\23finder_action_keys\1\0\a\16scroll_down\n<C-f>\ttabe\6t\vvsplit\6s\topen\6o\tquit\6q\nsplit\6i\14scroll_up\n<C-b>\17finder_icons\1\0\3\bdef\nÓàï  \tlink\nÔ†∏  \bref\tÔ™æ \26code_action_lightbulb\1\0\5\21enable_in_insert\2\17virtual_text\2\18sign_priority\3\20\venable\2\tsign\2\30diagnostic_source_bracket\22diagnostic_header\1\5\0\0\tÔÅó \tÔÅ™ \tÔÅö \tÔ¥û \17move_in_saga\1\0\2\tnext\n<C-n>\tprev\n<C-p>\1\0\n\21rename_in_select\2\23rename_action_quit\n<C-c>\18saga_winblend\3\0\17border_style\vsingle\27finder_request_timeout\3‹\v\29code_action_num_shortcut\2\21code_action_icon\tüí°\22max_preview_lines\3\n\27show_diagnostic_source\2\28definition_preview_icon\nÔî∏  \18init_lsp_saga\flspsaga\frequire\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/lspsaga.nvim",
    url = "https://github.com/glepnir/lspsaga.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n‡\1\0\0\5\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\n\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\3=\3\v\2B\0\2\1K\0\1\0\foptions\1\0\0\23disabled_filetypes\1\2\0\0\rneo-tree\25component_separators\1\0\2\nright\5\tleft\5\23section_separators\1\0\2\nright\5\tleft\5\1\0\1\ntheme\15everforest\nsetup\flualine\frequire\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["marks.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\nmarks\frequire\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/marks.nvim",
    url = "https://github.com/chentoast/marks.nvim"
  },
  ["neo-tree.nvim"] = {
    config = { "\27LJ\2\nö\17\0\0\a\0008\0M6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\3\0'\2\4\0B\0\2\0029\0\5\0005\2\6\0005\3\b\0005\4\a\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\0035\4\14\0=\4\15\0035\4\16\0=\4\17\0035\4\19\0005\5\18\0=\5\20\4=\4\21\3=\3\22\0025\3\23\0005\4\24\0=\4\25\0035\4\27\0005\5\26\0=\5\28\0045\5\29\0005\6\30\0=\6\31\5=\5 \4=\4!\3=\3\"\0024\3\0\0=\3#\0025\3(\0005\4$\0004\5\0\0=\5%\0044\5\0\0=\5&\0044\5\0\0=\5'\4=\4)\0036\4*\0=\4+\0035\4-\0005\5,\0=\5!\4=\4\"\3=\3.\0025\3/\0005\0041\0005\0050\0=\5!\4=\4\"\3=\0032\0025\0035\0005\0043\0005\0054\0=\5!\4=\4\"\3=\3\21\2B\0\2\0016\0\0\0009\0\1\0'\0026\0B\0\2\0016\0\0\0009\0\1\0'\0027\0B\0\2\1K\0\1\0'nnoremap <c-b> :Neotree toggle<cr>#nnoremap \\ :Neotree reveal<cr>\1\0\0\1\0\a\agu\21git_unstage_file\agc\15git_commit\6A\16git_add_all\agp\rgit_push\agr\20git_revert_file\agg\24git_commit_and_push\aga\17git_add_file\1\0\1\rposition\nfloat\fbuffers\1\0\0\1\0\3\6.\rset_root\abd\18buffer_delete\t<bs>\16navigate_up\1\0\3\24follow_current_file\2\18show_unloaded\2\21group_empty_dirs\2\15filesystem\1\0\0\1\0\t\6D\27fuzzy_finder_directory\6f\21filter_on_submit\6C\rset_root\6H\18toggle_hidden\6/\17fuzzy_finder\6U\16navigate_up\a]g\22next_git_modified\a[g\22prev_git_modified\n<c-x>\17clear_filter\27use_libuv_file_watcher\btru\19filtered_items\1\0\3\24follow_current_file\2\26hijack_netrw_behavior\17open_current\21group_empty_dirs\1\15never_show\20hide_by_pattern\17hide_by_name\1\0\4\16hide_hidden\2\20hide_gitignored\2\18hide_dotfiles\2\fvisible\1\18nesting_rules\vwindow\rmappings\6a\vconfig\1\0\1\14show_path\tnone\1\2\0\0\badd\f<space>\1\0\15\6m\21cut_to_clipboard\6n\18add_directory\6S\15open_split\6p\25paste_from_clipboard\18<2-LeftMouse>\topen\t<cr>\topen\6R\frefresh\6r\vrename\6o\topen\6d\vdelete\6c\22copy_to_clipboard\6q\17close_window\6s\16open_vsplit\6?\14show_help\6z\15close_node\1\2\1\0\16toggle_node\vnowait\1\20mapping_options\1\0\2\vnowait\2\fnoremap\2\1\0\2\nwidth\3(\rposition\tleft\30default_component_configs\15git_status\fsymbols\1\0\0\1\0\t\runstaged\bÔò∞\rmodified\5\fignored\bÔë¥\14untracked\bÔÑ®\frenamed\bÔïî\fdeleted\b‚úñ\nadded\5\rconflict\bÓúß\vstaged\bÔÅÜ\tname\1\0\3\14highlight\20NeoTreeFileName\26use_git_status_colors\2\19trailing_slash\1\rmodified\1\0\2\vsymbol\b[+]\14highlight\20NeoTreeModified\ticon\1\0\5\14highlight\20NeoTreeFileIcon\18folder_closed\bÓóø\fdefault\6*\17folder_empty\bÔ∞ä\16folder_open\bÓóæ\vindent\1\0\t\14highlight\24NeoTreeIndentMarker\23last_indent_marker\b‚îî\18indent_marker\b‚îÇ\17with_markers\2\fpadding\3\1\16indent_size\3\2\23expander_highlight\20NeoTreeExpander\22expander_expanded\bÔëº\23expander_collapsed\bÔë†\14container\1\0\0\1\0\1\26enable_character_fade\2\1\0\5\23popup_border_style\frounded\25close_if_last_window\1\26sort_case_insensitive\1\23enable_diagnostics\1\22enable_git_status\1\nsetup\rneo-tree\frequire0 let g:neo_tree_remove_legacy_commands = 1 \bcmd\bvim\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/neo-tree.nvim",
    url = "https://github.com/nvim-neo-tree/neo-tree.nvim"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\n:\0\1\4\0\4\0\0066\1\0\0009\1\1\0019\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\19UltiSnips#Anon\afn\bvimò\1\0\2\4\1\5\0\n-\2\0\0009\3\0\0018\2\3\2=\2\0\0015\2\2\0009\3\3\0009\3\4\0038\2\3\2=\2\1\1L\1\2\0\1¿\tname\vsource\1\0\5\tpath\v[Path]\rnvim_lua\n[Lua]\14ultisnips\14[Snippet]\vbuffer\r[Buffer]\rnvim_lsp\n[LSP]\tmenu\tkindÄ\b\1\0\t\0\29\0.6\0\0\0'\2\1\0B\0\2\0025\1\2\0009\2\3\0005\4\n\0004\5\a\0005\6\4\0>\6\1\0055\6\5\0>\6\2\0055\6\6\0>\6\3\0055\6\a\0>\6\4\0055\6\b\0>\6\5\0055\6\t\0>\6\6\5=\5\v\0045\5\r\0003\6\f\0=\6\14\5=\5\15\0045\5\19\0009\6\16\0009\6\17\0065\b\18\0B\6\2\2=\6\20\0059\6\16\0009\6\21\6B\6\1\2=\6\22\0059\6\16\0009\6\23\6B\6\1\2=\6\24\5=\5\16\0045\5\26\0003\6\25\0=\6\27\5=\5\28\4B\2\2\0012\0\0ÄK\0\1\0\15formatting\vformat\1\0\0\0\n<tab>\21select_next_item\f<s-tab>\21select_prev_item\t<cr>\1\0\0\1\0\1\vselect\2\fconfirm\fmapping\fsnippet\vexpand\1\0\0\0\fsources\1\0\0\1\0\1\tname\28nvim_lsp_signature_help\1\0\1\tname\vcrates\1\0\1\tname\14ultisnips\1\0\1\tname\vbuffer\1\0\1\tname\tpath\1\0\1\tname\rnvim_lsp\nsetup\1\0\24\16Constructor\24 Ôê•  (Constructor)\vModule\19 Ôô®  (Module)\rFunction\21 Ôûî  (Function)\vFolder\19 Ôùä  (Folder)\vMethod\19 Ôö¶  (Method)\15EnumMember\23 ÔÖù  (EnumMember)\14Reference\22 Ôúú  (Reference)\rConstant\21 Ô≤Ä  (Constant)\tFile\17 Ôúì  (File)\vStruct\19 Ô≥§  (Struct)\nColor\18 Ô£ó  (Color)\nEvent\18 ÔÉß  (Event)\fKeyword\20 Ô†ä  (Keyword)\rOperator\21 Ôó´  (Operator)\tEnum\16 Ô©ó (Enum)\18TypeParameter\26 ÔûÉ  (TypeParameter)\nValue\18 Ô¢ü  (Value)\tUnit\17 Ôëµ  (Unit)\rProperty\20 Ô™∂ (Property)\tText\18 Ôíû  (Text) \14Interface\22 Ô∞Æ  (Interface)\nClass\18 Ô†ñ  (Class)\rVariable\21[Óúñ] (Variable)\nField\18 Ô¥≤  (Field)\bcmp\frequire\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\nÉ\1\0\0\4\0\5\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0B\0\3\1K\0\1\0\1\0\b\vcss_fn\2\vhsl_fn\2\vrgb_fn\2\rRRGGBBAA\2\nnames\1\vRRGGBB\2\bRGB\2\bcss\2\1\2\0\0\6*\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\n∏\4\0\1\5\0\6\0\v9\1\0\0009\1\1\1\15\0\1\0X\2\6Ä6\1\2\0009\1\3\0019\1\4\1'\3\5\0+\4\1\0B\1\3\1K\0\1\0œ\3          hi LspReferenceRead cterm=bold ctermbg=red guibg=#34495e\n          hi LspReferenceText cterm=bold ctermbg=red guibg=#34495e\n          hi LspReferenceWrite cterm=bold ctermbg=red guibg=#34495e\n          augroup lsp_document_highlight\n            autocmd! * <buffer>\n            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()\n            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()\n          augroup END\n        \14nvim_exec\bapi\bvim\23document_highlight\24server_capabilitiesÁ\6\0\0\3\0\r\0-6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\0016\0\0\0009\0\1\0'\2\4\0B\0\2\0016\0\0\0009\0\1\0'\2\5\0B\0\2\0016\0\0\0009\0\1\0'\2\6\0B\0\2\0016\0\0\0009\0\1\0'\2\a\0B\0\2\0016\0\0\0009\0\1\0'\2\b\0B\0\2\0016\0\0\0009\0\1\0'\2\t\0B\0\2\0016\0\0\0009\0\1\0'\2\n\0B\0\2\0016\0\0\0009\0\1\0'\2\v\0B\0\2\0016\0\0\0009\0\1\0'\2\f\0B\0\2\1K\0\1\0Tcommand! -nargs=0 LspVirtualTextToggle lua require(\"lsp/virtual_text\").toggle()?nnoremap <silent> g] <cmd>Lspsaga diagnostic_jump_next<CR>?nnoremap <silent> g[ <cmd>Lspsaga diagnostic_jump_prev<CR>Bnnoremap <silent> gD <cmd>lua vim.diagnostic.open_float()<CR>6nnoremap <silent> ca <cmd>Lspsaga code_action<CR>Xnnoremap <silent> gd <cmd>lua require('goto-preview').goto_preview_definition()<CR>\\nnoremap <silent> gi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>5nnoremap <silent> gr <cmd>Lspsaga lsp_finder<CR>3nnoremap <silent> K <cmd>Lspsaga hover_doc<CR>9nnoremap <silent> gh <cmd>Lspsaga signature_help<CR>1nnoremap <silent> rn <cmd>Lspsaga rename<CR>\bcmd\bvim#\0\1\4\2\0\0\6-\1\0\0\18\3\0\0B\1\2\1-\1\1\0B\1\1\1K\0\1\0\3¿\4¿É\r\1\0\16\0H\0î\0016\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0015\2\4\0006\3\2\0009\3\5\0039\3\6\3'\5\a\0005\6\b\0B\3\3\0016\3\2\0009\3\5\0039\3\6\3'\5\t\0005\6\n\0B\3\3\0016\3\2\0009\3\5\0039\3\6\3'\5\v\0005\6\f\0B\3\3\0016\3\2\0009\3\5\0039\3\6\3'\5\r\0005\6\14\0B\3\3\0019\3\15\0019\4\17\0019\6\15\0019\6\18\6\18\a\2\0B\4\3\2=\4\16\0039\3\15\0019\4\17\0019\6\15\0019\6\20\6\18\a\2\0B\4\3\2=\4\19\0039\3\15\0019\4\17\0016\6\2\0009\6\3\0069\6\22\0069\6\23\0065\a\24\0B\4\3\2=\4\21\0033\3\25\0003\4\26\0003\5\27\0005\6\31\0005\a\29\0005\b\28\0=\b\30\a=\a \0065\a\"\0005\b!\0=\b\30\a=\a#\0065\a%\0005\b$\0=\b\30\a=\a&\0065\a(\0005\b'\0=\b\30\a=\a)\0064\a\0\0=\a*\0064\a\0\0=\a+\0064\a\0\0=\a,\0064\a\0\0=\a-\0066\a.\0\18\t\6\0B\a\2\4H\n\25Ä6\f/\0\18\14\v\0B\f\2\2\a\f0\0X\f\3Ä\18\f\v\0B\f\1\2\18\v\f\0=\0051\v6\f\2\0009\f\3\f9\f2\f9\f3\fB\f\1\0026\r\0\0'\0155\0B\r\2\0029\r6\r\18\15\f\0B\r\2\2=\r4\v8\r\n\0009\r7\r\18\15\v\0B\r\2\1F\n\3\3R\nÂ\1276\a\2\0009\a\3\a9\a2\a9\a3\aB\a\1\0025\b=\0005\t8\0005\n9\0=\n:\t5\n;\0=\n<\t=\t>\b5\t?\0=\0051\t6\n\0\0'\f5\0B\n\2\0029\n6\n\18\f\a\0B\n\2\2=\n4\t5\nC\0005\vA\0005\f@\0=\fB\v=\vD\n=\nE\t=\tF\b6\t\0\0'\vG\0B\t\2\0029\t7\t\18\v\b\0B\t\2\0012\0\0ÄK\0\1\0\15rust-tools\vserver\rsettings\18rust-analyzer\1\0\0\16checkOnSave\1\0\0\1\0\1\fcommand\vclippy\1\0\0\ntools\1\0\0\16inlay_hints\1\0\3\27parameter_hints_prefix\b <-\25show_parameter_hints\1\23other_hints_prefix\b¬ª \14runnables\1\0\1\18use_telescope\2\1\0\1\17autoSetHints\2\nsetup\24update_capabilities\17cmp_nvim_lsp\17capabilities\29make_client_capabilities\rprotocol\14on_attach\rfunction\ttype\npairs\vsvelte\nvimls\nvuels\rtsserver\vjsonls\1\0\0\1\3\0\0\31vscode-json-languageserver\f--stdio\16sumneko_lua\1\0\0\1\3\0\0\24lua-language-server\f--stdio\thtml\1\0\0\1\3\0\0\24html-languageserver\f--stdio\ncssls\1\0\0\bcmd\1\0\0\1\3\0\0\23css-languageserver\f--stdio\0\0\0\1\0\4\14underline\2\21update_in_insert\1\nsigns\2\17virtual_text\1\27on_publish_diagnostics\15diagnostic$textDocument/publishDiagnostics\nhover\23textDocument/hover\19signature_help\twith\31textDocument/signatureHelp\rhandlers\1\0\2\vtexthl\23DiagnosticSignHint\ttext\bÔ†¥\23DiagnosticSignHint\1\0\2\vtexthl\23DiagnosticSignInfo\ttext\bÔÑ©\30DiagnosticSignInformation\1\0\2\vtexthl\23DiagnosticSignWarn\ttext\6!\23DiagnosticSignWarn\1\0\2\vtexthl\24DiagnosticSignError\ttext\b‚úó\24DiagnosticSignError\16sign_define\afn\1\0\3\14focusable\1\vborder\frounded\nscope\tline\blsp\bvim\14lspconfig\frequire\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-transparent"] = {
    config = { "\27LJ\2\nm\0\0\4\0\6\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0024\3\0\0=\3\5\2B\0\2\1K\0\1\0\fexclude\17extra_groups\1\0\1\venable\1\nsetup\16transparent\frequire\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/nvim-transparent",
    url = "https://github.com/xiyaowong/nvim-transparent"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\né\5\0\0\6\0\25\0\0296\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\0025\3\f\0=\3\r\0025\3\19\0005\4\14\0005\5\15\0=\5\16\0045\5\17\0=\5\18\4=\4\20\3=\3\21\0025\3\22\0004\4\0\0=\4\23\3=\3\24\2B\0\2\1K\0\1\0\15playground\fdisable\1\0\3\20persist_queries\1\15updatetime\3\25\venable\2\16textobjects\vselect\1\0\0\20selection_modes\1\0\3\17@class.outer\n<c-v>\20@function.outer\6V\21@parameter.outer\6v\fkeymaps\1\0\4\aof\20@function.outer\aoc\17@class.outer\aic\17@class.inner\aif\20@function.inner\1\0\3\14lookahead\2\venable\2#include_surrounding_whitespace\2\26context_commentstring\1\0\1\venable\2\14highlight\1\0\2\21use_languagetree\2\venable\2\vindent\1\0\1\venable\2\fautotag\1\0\1\venable\2\21ensure_installed\1\0\0\1\f\0\0\15javascript\15typescript\tjson\fgraphql\btsx\thtml\njsdoc\trust\bcss\tbash\blua\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-ts-autotag"] = {
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-web-devicons"] = {
    config = { "\27LJ\2\nô\5\0\0\5\0\30\0!6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\28\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\0035\4\14\0=\4\15\0035\4\16\0=\4\17\0035\4\18\0=\4\19\0035\4\20\0=\4\21\0035\4\22\0=\4\23\0035\4\24\0=\4\25\0035\4\26\0=\4\27\3=\3\29\2B\0\2\1K\0\1\0\roverride\1\0\0\tlock\1\0\3\ticon\bÔ†Ω\tname\tlock\ncolor\f#5c6370\bmp4\1\0\3\ticon\bÔÖÑ\tname\bmp4\ncolor\f#5c6370\bmp3\1\0\3\ticon\bÔ¢Ö\tname\bmp3\ncolor\f#566370\btxt\1\0\3\ticon\bÔÖú\tname\ttext\ncolor\f#61afef\bmap\1\0\3\ticon\bÓòî\tname\btxt\ncolor\f#566370\taxml\1\0\3\ticon\bÔú≠\tname\taxml\ncolor\f#f76c7c\ttxml\1\0\3\ticon\bÔú≠\tname\ttxml\ncolor\f#f76c7c\bxml\1\0\3\ticon\bÔú≠\tname\bxml\ncolor\f#f76c7c\tacss\1\0\3\ticon\bÓùâ\tname\bcss\ncolor\f#61afef\ttcss\1\0\3\ticon\bÓùâ\tname\bcss\ncolor\f#61afef\bcss\1\0\3\ticon\bÓùâ\tname\bcss\ncolor\f#61afef\thtml\1\0\0\1\0\3\ticon\bÔÑª\tname\thtml\ncolor\f#f76c7c\nsetup\22nvim-web-devicons\frequire\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["nvim-window-picker"] = {
    config = { "\27LJ\2\n˛\1\0\0\6\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\t\0005\4\5\0005\5\4\0=\5\6\0045\5\a\0=\5\b\4=\4\n\3=\3\v\2B\0\2\1K\0\1\0\17filter_rules\abo\1\0\0\fbuftype\1\2\0\0\rterminal\rfiletype\1\0\0\1\5\0\0\rneo-tree\19neo-tree-popup\vnotify\rquickfix\1\0\3\19autoselect_one\2\23other_win_hl_color\f#f3a14e\20include_current\1\nsetup\18window-picker\frequire\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/nvim-window-picker",
    url = "https://github.com/s1n7ax/nvim-window-picker"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/opt/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["rust-tools.nvim"] = {
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/rust-tools.nvim",
    url = "https://github.com/simrat39/rust-tools.nvim"
  },
  ["rust.vim"] = {
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/rust.vim",
    url = "https://github.com/rust-lang/rust.vim"
  },
  ["smart-splits.nvim"] = {
    config = { "\27LJ\2\n¶\1\0\0\a\0\n\0\0216\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0006\4\5\0'\6\6\0B\4\2\0029\4\a\4B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\b\0006\4\5\0'\6\6\0B\4\2\0029\4\t\4B\0\4\1K\0\1\0\17resize_right\n<S-l>\16resize_left\17smart-splits\frequire\n<S-h>\6n\bset\vkeymap\bvim\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/smart-splits.nvim",
    url = "https://github.com/mrjones2014/smart-splits.nvim"
  },
  ultisnips = {
    config = { "\27LJ\2\n>\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\n<C-o>\27UltiSnipsExpandTrigger\6g\bvim\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/ultisnips",
    url = "https://github.com/SirVer/ultisnips"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/vim-commentary",
    url = "https://github.com/tpope/vim-commentary"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/vim-devicons",
    url = "https://github.com/ryanoasis/vim-devicons"
  },
  ["vim-floaterm"] = {
    config = { "\27LJ\2\n‚\1\0\0\2\0\n\2\0216\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0*\1\0\0=\1\6\0006\0\0\0009\0\1\0*\1\1\0=\1\a\0006\0\0\0009\0\1\0'\1\t\0=\1\b\0K\0\1\0\n<C-\\>\27floaterm_keymap_toggle\20floaterm_height\19floaterm_width\16bottomright\22floaterm_position\nfloat\21floaterm_wintype\6g\bvimÁÃô≥\6≥Êåˇ\3\1ÄÄÄˇ\3\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/vim-floaterm",
    url = "https://github.com/voldikss/vim-floaterm"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-multiple-cursors"] = {
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/vim-multiple-cursors",
    url = "https://github.com/terryma/vim-multiple-cursors"
  },
  ["vim-smoothie"] = {
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/vim-smoothie",
    url = "https://github.com/psliwka/vim-smoothie"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/vim-snippets",
    url = "https://github.com/honza/vim-snippets"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-svelte"] = {
    config = { "\27LJ\2\nA\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\15typescript\25svelte_preprocessors\6g\bvim\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/vim-svelte",
    url = "https://github.com/evanleck/vim-svelte"
  },
  ["vim-toml"] = {
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/vim-toml",
    url = "https://github.com/cespare/vim-toml"
  },
  ["vim-vue"] = {
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/vim-vue",
    url = "https://github.com/posva/vim-vue"
  },
  ["vista.vim"] = {
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/vista.vim",
    url = "https://github.com/liuchengxu/vista.vim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: neo-tree.nvim
time([[Config for neo-tree.nvim]], true)
try_loadstring("\27LJ\2\nö\17\0\0\a\0008\0M6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\3\0'\2\4\0B\0\2\0029\0\5\0005\2\6\0005\3\b\0005\4\a\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\0035\4\14\0=\4\15\0035\4\16\0=\4\17\0035\4\19\0005\5\18\0=\5\20\4=\4\21\3=\3\22\0025\3\23\0005\4\24\0=\4\25\0035\4\27\0005\5\26\0=\5\28\0045\5\29\0005\6\30\0=\6\31\5=\5 \4=\4!\3=\3\"\0024\3\0\0=\3#\0025\3(\0005\4$\0004\5\0\0=\5%\0044\5\0\0=\5&\0044\5\0\0=\5'\4=\4)\0036\4*\0=\4+\0035\4-\0005\5,\0=\5!\4=\4\"\3=\3.\0025\3/\0005\0041\0005\0050\0=\5!\4=\4\"\3=\0032\0025\0035\0005\0043\0005\0054\0=\5!\4=\4\"\3=\3\21\2B\0\2\0016\0\0\0009\0\1\0'\0026\0B\0\2\0016\0\0\0009\0\1\0'\0027\0B\0\2\1K\0\1\0'nnoremap <c-b> :Neotree toggle<cr>#nnoremap \\ :Neotree reveal<cr>\1\0\0\1\0\a\agu\21git_unstage_file\agc\15git_commit\6A\16git_add_all\agp\rgit_push\agr\20git_revert_file\agg\24git_commit_and_push\aga\17git_add_file\1\0\1\rposition\nfloat\fbuffers\1\0\0\1\0\3\6.\rset_root\abd\18buffer_delete\t<bs>\16navigate_up\1\0\3\24follow_current_file\2\18show_unloaded\2\21group_empty_dirs\2\15filesystem\1\0\0\1\0\t\6D\27fuzzy_finder_directory\6f\21filter_on_submit\6C\rset_root\6H\18toggle_hidden\6/\17fuzzy_finder\6U\16navigate_up\a]g\22next_git_modified\a[g\22prev_git_modified\n<c-x>\17clear_filter\27use_libuv_file_watcher\btru\19filtered_items\1\0\3\24follow_current_file\2\26hijack_netrw_behavior\17open_current\21group_empty_dirs\1\15never_show\20hide_by_pattern\17hide_by_name\1\0\4\16hide_hidden\2\20hide_gitignored\2\18hide_dotfiles\2\fvisible\1\18nesting_rules\vwindow\rmappings\6a\vconfig\1\0\1\14show_path\tnone\1\2\0\0\badd\f<space>\1\0\15\6m\21cut_to_clipboard\6n\18add_directory\6S\15open_split\6p\25paste_from_clipboard\18<2-LeftMouse>\topen\t<cr>\topen\6R\frefresh\6r\vrename\6o\topen\6d\vdelete\6c\22copy_to_clipboard\6q\17close_window\6s\16open_vsplit\6?\14show_help\6z\15close_node\1\2\1\0\16toggle_node\vnowait\1\20mapping_options\1\0\2\vnowait\2\fnoremap\2\1\0\2\nwidth\3(\rposition\tleft\30default_component_configs\15git_status\fsymbols\1\0\0\1\0\t\runstaged\bÔò∞\rmodified\5\fignored\bÔë¥\14untracked\bÔÑ®\frenamed\bÔïî\fdeleted\b‚úñ\nadded\5\rconflict\bÓúß\vstaged\bÔÅÜ\tname\1\0\3\14highlight\20NeoTreeFileName\26use_git_status_colors\2\19trailing_slash\1\rmodified\1\0\2\vsymbol\b[+]\14highlight\20NeoTreeModified\ticon\1\0\5\14highlight\20NeoTreeFileIcon\18folder_closed\bÓóø\fdefault\6*\17folder_empty\bÔ∞ä\16folder_open\bÓóæ\vindent\1\0\t\14highlight\24NeoTreeIndentMarker\23last_indent_marker\b‚îî\18indent_marker\b‚îÇ\17with_markers\2\fpadding\3\1\16indent_size\3\2\23expander_highlight\20NeoTreeExpander\22expander_expanded\bÔëº\23expander_collapsed\bÔë†\14container\1\0\0\1\0\1\26enable_character_fade\2\1\0\5\23popup_border_style\frounded\25close_if_last_window\1\26sort_case_insensitive\1\23enable_diagnostics\1\22enable_git_status\1\nsetup\rneo-tree\frequire0 let g:neo_tree_remove_legacy_commands = 1 \bcmd\bvim\0", "config", "neo-tree.nvim")
time([[Config for neo-tree.nvim]], false)
-- Config for: smart-splits.nvim
time([[Config for smart-splits.nvim]], true)
try_loadstring("\27LJ\2\n¶\1\0\0\a\0\n\0\0216\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0006\4\5\0'\6\6\0B\4\2\0029\4\a\4B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\b\0006\4\5\0'\6\6\0B\4\2\0029\4\t\4B\0\4\1K\0\1\0\17resize_right\n<S-l>\16resize_left\17smart-splits\frequire\n<S-h>\6n\bset\vkeymap\bvim\0", "config", "smart-splits.nvim")
time([[Config for smart-splits.nvim]], false)
-- Config for: goto-preview
time([[Config for goto-preview]], true)
try_loadstring("\27LJ\2\n>\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\17goto-preview\frequire\0", "config", "goto-preview")
time([[Config for goto-preview]], false)
-- Config for: lspsaga.nvim
time([[Config for lspsaga.nvim]], true)
try_loadstring("\27LJ\2\nΩ\2\0\4\n\0\16\00299\4\0\0009\4\1\0049\5\0\0009\5\2\5\a\2\3\0X\6\fÄ\t\1\0\0X\6\1ÄX\6/Ä6\6\4\0009\6\5\0069\6\6\0069\b\a\4\22\b\1\b9\t\b\4\22\t\1\tB\6\3\1X\6&Ä\a\2\t\0X\6\14Ä\a\3\n\0X\6\3Ä6\6\v\0'\b\f\0B\6\2\0016\6\4\0009\6\5\0069\6\6\0069\b\a\5\22\b\1\b9\t\b\5\22\t\1\tB\6\3\1X\6\22Ä\a\2\r\0X\6\20Ä6\6\4\0009\6\5\0069\6\6\0069\b\a\4\22\b\1\b9\t\b\4\22\t\1\tB\6\3\0016\6\4\0009\6\14\6'\b\15\0B\6\2\0016\6\4\0009\6\5\0069\6\6\0069\b\a\5\22\b\1\b9\t\b\5\22\t\1\tB\6\3\1K\0\1\0\rnormal v\bcmd\6m\flspsaga\nprint\6s\6r\14character\tline\vcursor\afn\bvim\6l\bend\nstart\nrange\4\2¥\3\0\1\15\0\26\0@6\1\0\0'\3\1\0B\1\2\0029\1\2\1B\1\1\0026\2\3\0009\2\4\0029\2\5\2'\4\6\0B\2\2\2\a\2\a\0X\2\2Ä'\2\a\0L\2\2\0\v\0\1\0X\2\1ÄL\1\2\0006\2\3\0009\2\b\0029\2\t\2B\2\1\0029\2\n\2\a\2\v\0X\2\2Ä'\2\f\0X\3\1Ä'\2\r\0006\3\3\0009\3\14\0036\5\15\0009\5\16\0056\a\3\0009\a\4\a9\a\17\a'\t\18\0B\a\2\2'\b\19\0'\t\a\0B\5\4\2\18\6\2\0B\3\3\2'\4\a\0006\5\20\0\18\a\3\0B\5\2\4X\b\fÄ\6\t\21\0X\n\2Ä\a\t\22\0X\n\2Ä'\4\a\0X\n\6Ä\18\n\4\0\18\v\t\0'\f\23\0'\r\24\0'\14\25\0&\4\14\nE\b\3\3R\bÚ\127\18\5\4\0\18\6\1\0&\5\6\5L\5\2\0\b %*\29%#LspSagaWinbarSep#Ôëä%*\6 \6~\6.\vipairs\a%%\f%:~:.:h\vexpand\tgsub\vstring\nsplit\6/\6\\\fWindows\fsysname\ros_uname\tloop\5\6%\fbufname\afn\bvim\18get_file_name\25lspsaga.symbolwinbar\frequireﬂ\2\0\0\b\1\14\0,5\0\0\0006\1\1\0009\1\2\0019\1\3\1)\3\0\0B\1\2\0029\1\4\1\14\0\1\0X\2\6Ä6\1\1\0009\1\5\0019\1\6\0018\1\1\0\15\0\1\0X\2\5Ä6\1\1\0009\1\a\1'\2\t\0=\2\b\1X\1\23Ä6\1\n\0006\3\v\0'\4\f\0B\1\3\3+\3\0\0\15\0\1\0X\4\3Ä9\4\r\2B\4\1\2\18\3\4\0'\4\t\0-\5\0\0+\a\2\0B\5\2\2\18\4\5\0\n\3\0\0X\5\3Ä\18\5\4\0\18\6\3\0&\4\6\0056\5\1\0009\5\a\5=\4\b\5K\0\1\0\1¿\20get_symbol_node\25lspsaga.symbolwinbar\frequire\npcall\5\vwinbar\awo\rfiletype\abo\vzindex\24nvim_win_get_config\bapi\bvim\1\0\6\rneo-tree\2\vprompt\2\thelp\2\fNeotree\2\15toggleterm\2\fteminal\2\21\0\0\2\1\0\0\3-\0\0\0B\0\1\1K\0\1\0\2¿\21\0\0\2\1\0\0\3-\0\0\0B\0\1\1K\0\1\0\2¿◊\t\1\0\n\0*\00096\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0034\4\0\0=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\0035\4\15\0=\4\16\0035\4\17\0003\5\18\0=\5\19\4=\4\20\0035\4\21\0=\4\22\0034\4\0\0=\4\23\3B\1\2\0013\1\24\0003\2\25\0005\3\26\0006\4\27\0009\4\28\0049\4\29\4\18\6\3\0005\a\30\0003\b\31\0=\b \aB\4\3\0016\4\27\0009\4\28\0049\4\29\4'\6!\0005\a\"\0003\b#\0=\b \aB\4\3\0016\4\27\0009\4$\0049\4%\4'\6&\0'\a'\0'\b(\0005\t)\0B\4\5\0012\0\0ÄK\0\1\0\1\0\1\vsilent\2\29<cmd>LSoutlineToggle<CR>\14<leader>o\6n\bset\vkeymap\0\1\0\1\fpattern\24LspsagaUpdateSymbol\tUser\rcallback\0\1\0\1\fpattern\6*\24nvim_create_autocmd\bapi\bvim\1\4\0\0\rBufEnter\16BufWinEnter\16CursorMoved\0\0\24server_filetype_map\17show_outline\1\0\b\17win_position\nright\rjump_key\6o\17auto_refresh\2\14virt_text\b‚îÉ\17auto_preview\2\15auto_enter\2\14win_width\3\30\rwin_with\5\21symbol_in_winbar\18click_support\0\1\0\1\14in_custom\2\21code_action_keys\1\0\2\tquit\6q\texec\t<CR>\23finder_action_keys\1\0\a\16scroll_down\n<C-f>\ttabe\6t\vvsplit\6s\topen\6o\tquit\6q\nsplit\6i\14scroll_up\n<C-b>\17finder_icons\1\0\3\bdef\nÓàï  \tlink\nÔ†∏  \bref\tÔ™æ \26code_action_lightbulb\1\0\5\21enable_in_insert\2\17virtual_text\2\18sign_priority\3\20\venable\2\tsign\2\30diagnostic_source_bracket\22diagnostic_header\1\5\0\0\tÔÅó \tÔÅ™ \tÔÅö \tÔ¥û \17move_in_saga\1\0\2\tnext\n<C-n>\tprev\n<C-p>\1\0\n\21rename_in_select\2\23rename_action_quit\n<C-c>\18saga_winblend\3\0\17border_style\vsingle\27finder_request_timeout\3‹\v\29code_action_num_shortcut\2\21code_action_icon\tüí°\22max_preview_lines\3\n\27show_diagnostic_source\2\28definition_preview_icon\nÔî∏  \18init_lsp_saga\flspsaga\frequire\0", "config", "lspsaga.nvim")
time([[Config for lspsaga.nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\n:\0\1\4\0\4\0\0066\1\0\0009\1\1\0019\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\19UltiSnips#Anon\afn\bvimò\1\0\2\4\1\5\0\n-\2\0\0009\3\0\0018\2\3\2=\2\0\0015\2\2\0009\3\3\0009\3\4\0038\2\3\2=\2\1\1L\1\2\0\1¿\tname\vsource\1\0\5\tpath\v[Path]\rnvim_lua\n[Lua]\14ultisnips\14[Snippet]\vbuffer\r[Buffer]\rnvim_lsp\n[LSP]\tmenu\tkindÄ\b\1\0\t\0\29\0.6\0\0\0'\2\1\0B\0\2\0025\1\2\0009\2\3\0005\4\n\0004\5\a\0005\6\4\0>\6\1\0055\6\5\0>\6\2\0055\6\6\0>\6\3\0055\6\a\0>\6\4\0055\6\b\0>\6\5\0055\6\t\0>\6\6\5=\5\v\0045\5\r\0003\6\f\0=\6\14\5=\5\15\0045\5\19\0009\6\16\0009\6\17\0065\b\18\0B\6\2\2=\6\20\0059\6\16\0009\6\21\6B\6\1\2=\6\22\0059\6\16\0009\6\23\6B\6\1\2=\6\24\5=\5\16\0045\5\26\0003\6\25\0=\6\27\5=\5\28\4B\2\2\0012\0\0ÄK\0\1\0\15formatting\vformat\1\0\0\0\n<tab>\21select_next_item\f<s-tab>\21select_prev_item\t<cr>\1\0\0\1\0\1\vselect\2\fconfirm\fmapping\fsnippet\vexpand\1\0\0\0\fsources\1\0\0\1\0\1\tname\28nvim_lsp_signature_help\1\0\1\tname\vcrates\1\0\1\tname\14ultisnips\1\0\1\tname\vbuffer\1\0\1\tname\tpath\1\0\1\tname\rnvim_lsp\nsetup\1\0\24\16Constructor\24 Ôê•  (Constructor)\vModule\19 Ôô®  (Module)\rFunction\21 Ôûî  (Function)\vFolder\19 Ôùä  (Folder)\vMethod\19 Ôö¶  (Method)\15EnumMember\23 ÔÖù  (EnumMember)\14Reference\22 Ôúú  (Reference)\rConstant\21 Ô≤Ä  (Constant)\tFile\17 Ôúì  (File)\vStruct\19 Ô≥§  (Struct)\nColor\18 Ô£ó  (Color)\nEvent\18 ÔÉß  (Event)\fKeyword\20 Ô†ä  (Keyword)\rOperator\21 Ôó´  (Operator)\tEnum\16 Ô©ó (Enum)\18TypeParameter\26 ÔûÉ  (TypeParameter)\nValue\18 Ô¢ü  (Value)\tUnit\17 Ôëµ  (Unit)\rProperty\20 Ô™∂ (Property)\tText\18 Ôíû  (Text) \14Interface\22 Ô∞Æ  (Interface)\nClass\18 Ô†ñ  (Class)\rVariable\21[Óúñ] (Variable)\nField\18 Ô¥≤  (Field)\bcmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n‡\1\0\0\5\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\n\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\3=\3\v\2B\0\2\1K\0\1\0\foptions\1\0\0\23disabled_filetypes\1\2\0\0\rneo-tree\25component_separators\1\0\2\nright\5\tleft\5\23section_separators\1\0\2\nright\5\tleft\5\1\0\1\ntheme\15everforest\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: ultisnips
time([[Config for ultisnips]], true)
try_loadstring("\27LJ\2\n>\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\n<C-o>\27UltiSnipsExpandTrigger\6g\bvim\0", "config", "ultisnips")
time([[Config for ultisnips]], false)
-- Config for: crates.nvim
time([[Config for crates.nvim]], true)
try_loadstring("\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vcrates\frequire\0", "config", "crates.nvim")
time([[Config for crates.nvim]], false)
-- Config for: nvim-window-picker
time([[Config for nvim-window-picker]], true)
try_loadstring("\27LJ\2\n˛\1\0\0\6\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\t\0005\4\5\0005\5\4\0=\5\6\0045\5\a\0=\5\b\4=\4\n\3=\3\v\2B\0\2\1K\0\1\0\17filter_rules\abo\1\0\0\fbuftype\1\2\0\0\rterminal\rfiletype\1\0\0\1\5\0\0\rneo-tree\19neo-tree-popup\vnotify\rquickfix\1\0\3\19autoselect_one\2\23other_win_hl_color\f#f3a14e\20include_current\1\nsetup\18window-picker\frequire\0", "config", "nvim-window-picker")
time([[Config for nvim-window-picker]], false)
-- Config for: nvim-transparent
time([[Config for nvim-transparent]], true)
try_loadstring("\27LJ\2\nm\0\0\4\0\6\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0024\3\0\0=\3\5\2B\0\2\1K\0\1\0\fexclude\17extra_groups\1\0\1\venable\1\nsetup\16transparent\frequire\0", "config", "nvim-transparent")
time([[Config for nvim-transparent]], false)
-- Config for: nvim-web-devicons
time([[Config for nvim-web-devicons]], true)
try_loadstring("\27LJ\2\nô\5\0\0\5\0\30\0!6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\28\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\0035\4\14\0=\4\15\0035\4\16\0=\4\17\0035\4\18\0=\4\19\0035\4\20\0=\4\21\0035\4\22\0=\4\23\0035\4\24\0=\4\25\0035\4\26\0=\4\27\3=\3\29\2B\0\2\1K\0\1\0\roverride\1\0\0\tlock\1\0\3\ticon\bÔ†Ω\tname\tlock\ncolor\f#5c6370\bmp4\1\0\3\ticon\bÔÖÑ\tname\bmp4\ncolor\f#5c6370\bmp3\1\0\3\ticon\bÔ¢Ö\tname\bmp3\ncolor\f#566370\btxt\1\0\3\ticon\bÔÖú\tname\ttext\ncolor\f#61afef\bmap\1\0\3\ticon\bÓòî\tname\btxt\ncolor\f#566370\taxml\1\0\3\ticon\bÔú≠\tname\taxml\ncolor\f#f76c7c\ttxml\1\0\3\ticon\bÔú≠\tname\ttxml\ncolor\f#f76c7c\bxml\1\0\3\ticon\bÔú≠\tname\bxml\ncolor\f#f76c7c\tacss\1\0\3\ticon\bÓùâ\tname\bcss\ncolor\f#61afef\ttcss\1\0\3\ticon\bÓùâ\tname\bcss\ncolor\f#61afef\bcss\1\0\3\ticon\bÓùâ\tname\bcss\ncolor\f#61afef\thtml\1\0\0\1\0\3\ticon\bÔÑª\tname\thtml\ncolor\f#f76c7c\nsetup\22nvim-web-devicons\frequire\0", "config", "nvim-web-devicons")
time([[Config for nvim-web-devicons]], false)
-- Config for: vim-floaterm
time([[Config for vim-floaterm]], true)
try_loadstring("\27LJ\2\n‚\1\0\0\2\0\n\2\0216\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0*\1\0\0=\1\6\0006\0\0\0009\0\1\0*\1\1\0=\1\a\0006\0\0\0009\0\1\0'\1\t\0=\1\b\0K\0\1\0\n<C-\\>\27floaterm_keymap_toggle\20floaterm_height\19floaterm_width\16bottomright\22floaterm_position\nfloat\21floaterm_wintype\6g\bvimÁÃô≥\6≥Êåˇ\3\1ÄÄÄˇ\3\0", "config", "vim-floaterm")
time([[Config for vim-floaterm]], false)
-- Config for: vim-svelte
time([[Config for vim-svelte]], true)
try_loadstring("\27LJ\2\nA\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\15typescript\25svelte_preprocessors\6g\bvim\0", "config", "vim-svelte")
time([[Config for vim-svelte]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\né\5\0\0\6\0\25\0\0296\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\0025\3\f\0=\3\r\0025\3\19\0005\4\14\0005\5\15\0=\5\16\0045\5\17\0=\5\18\4=\4\20\3=\3\21\0025\3\22\0004\4\0\0=\4\23\3=\3\24\2B\0\2\1K\0\1\0\15playground\fdisable\1\0\3\20persist_queries\1\15updatetime\3\25\venable\2\16textobjects\vselect\1\0\0\20selection_modes\1\0\3\17@class.outer\n<c-v>\20@function.outer\6V\21@parameter.outer\6v\fkeymaps\1\0\4\aof\20@function.outer\aoc\17@class.outer\aic\17@class.inner\aif\20@function.inner\1\0\3\14lookahead\2\venable\2#include_surrounding_whitespace\2\26context_commentstring\1\0\1\venable\2\14highlight\1\0\2\21use_languagetree\2\venable\2\vindent\1\0\1\venable\2\fautotag\1\0\1\venable\2\21ensure_installed\1\0\0\1\f\0\0\15javascript\15typescript\tjson\fgraphql\btsx\thtml\njsdoc\trust\bcss\tbash\blua\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\nÉ\1\0\0\4\0\5\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0B\0\3\1K\0\1\0\1\0\b\vcss_fn\2\vhsl_fn\2\vrgb_fn\2\rRRGGBBAA\2\nnames\1\vRRGGBB\2\bRGB\2\bcss\2\1\2\0\0\6*\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: formatter.nvim
time([[Config for formatter.nvim]], true)
try_loadstring("\27LJ\2\nÄ\1\0\0\5\0\6\1\n5\0\0\0005\1\1\0006\2\2\0009\2\3\0029\2\4\2)\4\0\0B\2\2\0?\2\0\0=\1\5\0L\0\2\0\targs\22nvim_buf_get_name\bapi\bvim\1\2\0\0\21--stdin-filepath\1\0\2\bexe\rprettier\nstdin\2\5ÄÄ¿ô\4(\0\0\1\0\1\0\0025\0\0\0L\0\2\0\1\0\2\nstdin\2\bexe\15lua-formatÊ\4\1\0\b\0\25\00086\0\0\0'\2\1\0B\0\2\0023\1\2\0006\2\3\0009\2\4\0029\2\5\2'\4\6\0+\5\2\0B\2\3\0019\2\a\0005\4\b\0005\5\t\0004\6\3\0>\1\1\6=\6\n\0054\6\3\0>\1\1\6=\6\v\0054\6\3\0>\1\1\6=\6\f\0054\6\3\0>\1\1\6=\6\r\0054\6\3\0>\1\1\6=\6\14\0054\6\3\0>\1\1\6=\6\15\0054\6\3\0>\1\1\6=\6\16\0054\6\3\0>\1\1\6=\6\17\0054\6\3\0>\1\1\6=\6\18\0054\6\3\0>\1\1\6=\6\19\0054\6\3\0>\1\1\6=\6\20\0054\6\3\0>\1\1\6=\6\21\0054\6\3\0003\a\22\0>\a\1\6=\6\23\5=\5\24\4B\2\2\1K\0\1\0\rfiletype\blua\0\rmarkdown\tyaml\tscss\tjson\bvue\bcss\vsvelte\thtml\15javascript\15typescript\20typescriptreact\20javascriptreact\1\0\0\1\0\1\flogging\1\nsetupÿ\1        augroup FormatAutogroup\n          autocmd!\n          autocmd BufWritePost *.js,*.mjs,*.ts,*.lua,*.jsx,*.tsx,*.md,*.mdx,*.yml,*.json,*.css,*.scss,*.html,*.vue,*.svelte FormatWrite\n        augroup END\n    \14nvim_exec\bapi\bvim\0\14formatter\frequire\0", "config", "formatter.nvim")
time([[Config for formatter.nvim]], false)
-- Config for: fzf.vim
time([[Config for fzf.vim]], true)
try_loadstring("\27LJ\2\n‰\1\0\0\3\0\6\0\0176\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\0016\0\0\0009\0\1\0'\2\4\0B\0\2\0016\0\0\0009\0\1\0'\2\5\0B\0\2\1K\0\1\0(nnoremap <Leader>s <cmd>GFiles?<CR>0nnoremap <nowait><Leader>b <cmd>Buffers<CR>#nnoremap <Leader>l <cmd>Rg<CR>&nnoremap <Leader>p <cmd>Files<CR>\bcmd\bvim\0", "config", "fzf.vim")
time([[Config for fzf.vim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\n∏\4\0\1\5\0\6\0\v9\1\0\0009\1\1\1\15\0\1\0X\2\6Ä6\1\2\0009\1\3\0019\1\4\1'\3\5\0+\4\1\0B\1\3\1K\0\1\0œ\3          hi LspReferenceRead cterm=bold ctermbg=red guibg=#34495e\n          hi LspReferenceText cterm=bold ctermbg=red guibg=#34495e\n          hi LspReferenceWrite cterm=bold ctermbg=red guibg=#34495e\n          augroup lsp_document_highlight\n            autocmd! * <buffer>\n            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()\n            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()\n          augroup END\n        \14nvim_exec\bapi\bvim\23document_highlight\24server_capabilitiesÁ\6\0\0\3\0\r\0-6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\0016\0\0\0009\0\1\0'\2\4\0B\0\2\0016\0\0\0009\0\1\0'\2\5\0B\0\2\0016\0\0\0009\0\1\0'\2\6\0B\0\2\0016\0\0\0009\0\1\0'\2\a\0B\0\2\0016\0\0\0009\0\1\0'\2\b\0B\0\2\0016\0\0\0009\0\1\0'\2\t\0B\0\2\0016\0\0\0009\0\1\0'\2\n\0B\0\2\0016\0\0\0009\0\1\0'\2\v\0B\0\2\0016\0\0\0009\0\1\0'\2\f\0B\0\2\1K\0\1\0Tcommand! -nargs=0 LspVirtualTextToggle lua require(\"lsp/virtual_text\").toggle()?nnoremap <silent> g] <cmd>Lspsaga diagnostic_jump_next<CR>?nnoremap <silent> g[ <cmd>Lspsaga diagnostic_jump_prev<CR>Bnnoremap <silent> gD <cmd>lua vim.diagnostic.open_float()<CR>6nnoremap <silent> ca <cmd>Lspsaga code_action<CR>Xnnoremap <silent> gd <cmd>lua require('goto-preview').goto_preview_definition()<CR>\\nnoremap <silent> gi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>5nnoremap <silent> gr <cmd>Lspsaga lsp_finder<CR>3nnoremap <silent> K <cmd>Lspsaga hover_doc<CR>9nnoremap <silent> gh <cmd>Lspsaga signature_help<CR>1nnoremap <silent> rn <cmd>Lspsaga rename<CR>\bcmd\bvim#\0\1\4\2\0\0\6-\1\0\0\18\3\0\0B\1\2\1-\1\1\0B\1\1\1K\0\1\0\3¿\4¿É\r\1\0\16\0H\0î\0016\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0015\2\4\0006\3\2\0009\3\5\0039\3\6\3'\5\a\0005\6\b\0B\3\3\0016\3\2\0009\3\5\0039\3\6\3'\5\t\0005\6\n\0B\3\3\0016\3\2\0009\3\5\0039\3\6\3'\5\v\0005\6\f\0B\3\3\0016\3\2\0009\3\5\0039\3\6\3'\5\r\0005\6\14\0B\3\3\0019\3\15\0019\4\17\0019\6\15\0019\6\18\6\18\a\2\0B\4\3\2=\4\16\0039\3\15\0019\4\17\0019\6\15\0019\6\20\6\18\a\2\0B\4\3\2=\4\19\0039\3\15\0019\4\17\0016\6\2\0009\6\3\0069\6\22\0069\6\23\0065\a\24\0B\4\3\2=\4\21\0033\3\25\0003\4\26\0003\5\27\0005\6\31\0005\a\29\0005\b\28\0=\b\30\a=\a \0065\a\"\0005\b!\0=\b\30\a=\a#\0065\a%\0005\b$\0=\b\30\a=\a&\0065\a(\0005\b'\0=\b\30\a=\a)\0064\a\0\0=\a*\0064\a\0\0=\a+\0064\a\0\0=\a,\0064\a\0\0=\a-\0066\a.\0\18\t\6\0B\a\2\4H\n\25Ä6\f/\0\18\14\v\0B\f\2\2\a\f0\0X\f\3Ä\18\f\v\0B\f\1\2\18\v\f\0=\0051\v6\f\2\0009\f\3\f9\f2\f9\f3\fB\f\1\0026\r\0\0'\0155\0B\r\2\0029\r6\r\18\15\f\0B\r\2\2=\r4\v8\r\n\0009\r7\r\18\15\v\0B\r\2\1F\n\3\3R\nÂ\1276\a\2\0009\a\3\a9\a2\a9\a3\aB\a\1\0025\b=\0005\t8\0005\n9\0=\n:\t5\n;\0=\n<\t=\t>\b5\t?\0=\0051\t6\n\0\0'\f5\0B\n\2\0029\n6\n\18\f\a\0B\n\2\2=\n4\t5\nC\0005\vA\0005\f@\0=\fB\v=\vD\n=\nE\t=\tF\b6\t\0\0'\vG\0B\t\2\0029\t7\t\18\v\b\0B\t\2\0012\0\0ÄK\0\1\0\15rust-tools\vserver\rsettings\18rust-analyzer\1\0\0\16checkOnSave\1\0\0\1\0\1\fcommand\vclippy\1\0\0\ntools\1\0\0\16inlay_hints\1\0\3\27parameter_hints_prefix\b <-\25show_parameter_hints\1\23other_hints_prefix\b¬ª \14runnables\1\0\1\18use_telescope\2\1\0\1\17autoSetHints\2\nsetup\24update_capabilities\17cmp_nvim_lsp\17capabilities\29make_client_capabilities\rprotocol\14on_attach\rfunction\ttype\npairs\vsvelte\nvimls\nvuels\rtsserver\vjsonls\1\0\0\1\3\0\0\31vscode-json-languageserver\f--stdio\16sumneko_lua\1\0\0\1\3\0\0\24lua-language-server\f--stdio\thtml\1\0\0\1\3\0\0\24html-languageserver\f--stdio\ncssls\1\0\0\bcmd\1\0\0\1\3\0\0\23css-languageserver\f--stdio\0\0\0\1\0\4\14underline\2\21update_in_insert\1\nsigns\2\17virtual_text\1\27on_publish_diagnostics\15diagnostic$textDocument/publishDiagnostics\nhover\23textDocument/hover\19signature_help\twith\31textDocument/signatureHelp\rhandlers\1\0\2\vtexthl\23DiagnosticSignHint\ttext\bÔ†¥\23DiagnosticSignHint\1\0\2\vtexthl\23DiagnosticSignInfo\ttext\bÔÑ©\30DiagnosticSignInformation\1\0\2\vtexthl\23DiagnosticSignWarn\ttext\6!\23DiagnosticSignWarn\1\0\2\vtexthl\24DiagnosticSignError\ttext\b‚úó\24DiagnosticSignError\16sign_define\afn\1\0\3\14focusable\1\vborder\frounded\nscope\tline\blsp\bvim\14lspconfig\frequire\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: marks.nvim
time([[Config for marks.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\nmarks\frequire\0", "config", "marks.nvim")
time([[Config for marks.nvim]], false)
-- Config for: everforest
time([[Config for everforest]], true)
try_loadstring("\27LJ\2\nø\1\0\0\4\0\t\0\0196\0\0\0009\0\1\0\18\1\0\0'\3\2\0B\1\2\0016\1\0\0009\1\3\1'\2\5\0=\2\4\1\18\1\0\0'\3\6\0B\1\2\1\18\1\0\0'\3\a\0B\1\2\1\18\1\0\0'\3\b\0B\1\2\1K\0\1\0\22set termguicolors\24set background=dark\27colorscheme everforest\tsoft\26everforest_background\6g\14syntax on\bcmd\bvim\0", "config", "everforest")
time([[Config for everforest]], false)
-- Config for: hop.nvim
time([[Config for hop.nvim]], true)
try_loadstring("\27LJ\2\n˝\1\0\0\5\0\14\0\0286\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0'\3\b\0'\4\t\0B\0\4\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0'\3\n\0'\4\v\0B\0\4\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0'\3\f\0'\4\r\0B\0\4\1K\0\1\0\25<cmd>:HopPattern<cr>\afe\22<cmd>:HopLine<cr>\afl\23<cmd>:HopChar2<cr>\afw\6n\bset\vkeymap\bvim\1\0\1\tkeys\28etovxqpdygfblzhckisuran\nsetup\bhop\frequire\0", "config", "hop.nvim")
time([[Config for hop.nvim]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
