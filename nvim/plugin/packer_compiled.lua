-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

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
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

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
    config = { "\27LJ\2\nÏ\1\0\0\3\0\a\0\r6\0\0\0009\0\1\0005\1\3\0=\1\2\0006\0\0\0009\0\4\0'\2\5\0B\0\2\0016\0\0\0009\0\4\0'\2\6\0B\0\2\1K\0\1\0\26hi TabLine guibg=NONE$hi BufferTabpageFill guibg=NONE\bcmd\1\0\6\26icon_separator_active\5\19icon_close_tab\bÔôò\14clickable\2\rtabpages\2\14animation\2\28icon_separator_inactive\5\15bufferline\6g\bvim\0" },
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
  ["deno-nvim"] = {
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/deno-nvim",
    url = "https://github.com/sigmasd/deno-nvim"
  },
  ["diffview.nvim"] = {
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  everforest = {
    config = { "\27LJ\2\n˙\2\0\0\4\0\r\0#6\0\0\0009\0\1\0\18\1\0\0'\3\2\0B\1\2\1\18\1\0\0'\3\3\0B\1\2\1\18\1\0\0'\3\4\0B\1\2\0016\1\0\0009\1\5\1'\2\a\0=\2\6\0016\1\0\0009\1\5\1)\2\1\0=\2\b\0016\1\0\0009\1\5\1)\2\1\0=\2\t\0016\1\0\0009\1\5\1)\2\0\0=\2\n\0016\1\0\0009\1\5\1)\2\1\0=\2\v\1\18\1\0\0'\3\f\0B\1\2\1K\0\1\0\27colorscheme everforest&everforest_transparent_background&everforest_disable_italic_comment\29everforest_enable_italic\"everforest_better_performance\tsoft\26everforest_background\6g\24set background=dark\22set termguicolors\14syntax on\bcmd\bvim\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/everforest",
    url = "https://github.com/sainnhe/everforest"
  },
  fzf = {
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/fzf",
    url = "https://github.com/junegunn/fzf"
  },
  ["fzf.vim"] = {
    config = { "\27LJ\2\n‰\1\0\0\3\0\6\0\0176\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\0016\0\0\0009\0\1\0'\2\4\0B\0\2\0016\0\0\0009\0\1\0'\2\5\0B\0\2\1K\0\1\0(nnoremap <Leader>s <cmd>GFiles?<CR>0nnoremap <nowait><Leader>b <cmd>Buffers<CR>#nnoremap <Leader>w <cmd>Rg<CR>&nnoremap <Leader>p <cmd>Files<CR>\bcmd\bvim\0" },
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
    config = { "\27LJ\2\nÃ\1\0\0\5\0\f\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0'\3\b\0'\4\t\0B\0\4\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0'\3\n\0'\4\v\0B\0\4\1K\0\1\0\25<cmd>:HopPattern<cr>\afe\23<cmd>:HopChar2<cr>\afw\6n\bset\vkeymap\bvim\1\0\1\tkeys\28etovxqpdygfblzhckisuran\nsetup\bhop\frequire\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/hop.nvim",
    url = "https://github.com/phaazon/hop.nvim"
  },
  ["html5.vim"] = {
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/html5.vim",
    url = "https://github.com/othree/html5.vim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\nÅ\2\0\0\4\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\2B\0\2\0016\0\b\0009\0\t\0'\1\v\0=\1\n\0K\0\1\0\b‚àò\26indent_blankline_char\6g\bvim\20buftype_exclude\1\3\0\0\rterminal\vnofile\21filetype_exclude\1\5\0\0\thelp\btxt\tnorg\amd\1\0\2\31show_current_context_start\2\25show_current_context\2\nsetup\21indent_blankline\frequire\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lspsaga.nvim"] = {
    config = { "\27LJ\2\n¿\1\0\0\6\0\t\0\f6\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0019\1\4\0019\2\5\0005\4\a\0005\5\6\0=\5\b\4B\2\2\1K\0\1\0\21symbol_in_winbar\1\0\0\1\0\6\venable\2\17respect_root\1\17folder_level\3\2\14show_file\2\17hide_keyword\2\14separator\tÔëä \nsetup\bset\vkeymap\bvim\flspsaga\frequire\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/lspsaga.nvim",
    url = "https://github.com/glepnir/lspsaga.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n∑\2\0\0\5\0\14\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\f\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\3=\3\r\2B\0\2\1K\0\1\0\foptions\1\0\0\23section_separators\1\0\2\tleft\bÓÇ∏\nright\bÓÇ∫\frefresh\1\0\3\vwinbar\3Ë\a\ftabline\3Ë\a\15statusline\3Ë\a\15extensions\1\2\0\0\rquickfix\23disabled_filetypes\1\4\0\0\rneo-tree\vwinbar\15statusline\1\0\2\25component_separators\5\ntheme\15everforest\nsetup\flualine\frequire\0" },
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
  ["mason.nvim"] = {
    config = { "\27LJ\2\n3\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\nmason\frequire\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["neo-tree.nvim"] = {
    config = { "\27LJ\2\nö\17\0\0\a\0008\0M6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\3\0'\2\4\0B\0\2\0029\0\5\0005\2\6\0005\3\b\0005\4\a\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\0035\4\14\0=\4\15\0035\4\16\0=\4\17\0035\4\19\0005\5\18\0=\5\20\4=\4\21\3=\3\22\0025\3\23\0005\4\24\0=\4\25\0035\4\27\0005\5\26\0=\5\28\0045\5\29\0005\6\30\0=\6\31\5=\5 \4=\4!\3=\3\"\0024\3\0\0=\3#\0025\3(\0005\4$\0004\5\0\0=\5%\0044\5\0\0=\5&\0044\5\0\0=\5'\4=\4)\0036\4*\0=\4+\0035\4-\0005\5,\0=\5!\4=\4\"\3=\3.\0025\3/\0005\0041\0005\0050\0=\5!\4=\4\"\3=\0032\0025\0035\0005\0043\0005\0054\0=\5!\4=\4\"\3=\3\21\2B\0\2\0016\0\0\0009\0\1\0'\0026\0B\0\2\0016\0\0\0009\0\1\0'\0027\0B\0\2\1K\0\1\0'nnoremap <c-b> :Neotree toggle<cr>#nnoremap \\ :Neotree reveal<cr>\1\0\0\1\0\a\aga\17git_add_file\agg\24git_commit_and_push\agu\21git_unstage_file\agp\rgit_push\6A\16git_add_all\agc\15git_commit\agr\20git_revert_file\1\0\1\rposition\nfloat\fbuffers\1\0\0\1\0\3\6.\rset_root\t<bs>\16navigate_up\abd\18buffer_delete\1\0\3\18show_unloaded\2\21group_empty_dirs\2\24follow_current_file\2\15filesystem\1\0\0\1\0\t\6C\rset_root\a]g\22next_git_modified\a[g\22prev_git_modified\n<c-x>\17clear_filter\6f\21filter_on_submit\6D\27fuzzy_finder_directory\6/\17fuzzy_finder\6H\18toggle_hidden\6U\16navigate_up\27use_libuv_file_watcher\btru\19filtered_items\1\0\3\24follow_current_file\2\26hijack_netrw_behavior\17open_current\21group_empty_dirs\1\15never_show\20hide_by_pattern\17hide_by_name\1\0\4\20hide_gitignored\2\18hide_dotfiles\2\fvisible\1\16hide_hidden\2\18nesting_rules\vwindow\rmappings\6a\vconfig\1\0\1\14show_path\tnone\1\2\0\0\badd\f<space>\1\0\15\6p\25paste_from_clipboard\6d\vdelete\6S\15open_split\18<2-LeftMouse>\topen\6z\15close_node\6c\22copy_to_clipboard\6o\topen\6s\16open_vsplit\6r\vrename\6?\14show_help\6q\17close_window\t<cr>\topen\6m\21cut_to_clipboard\6R\frefresh\6n\18add_directory\1\2\1\0\16toggle_node\vnowait\1\20mapping_options\1\0\2\fnoremap\2\vnowait\2\1\0\2\rposition\tleft\nwidth\3(\30default_component_configs\15git_status\fsymbols\1\0\0\1\0\t\runstaged\bÔò∞\rmodified\5\fignored\bÔë¥\14untracked\bÔÑ®\frenamed\bÔïî\fdeleted\b‚úñ\nadded\5\rconflict\bÓúß\vstaged\bÔÅÜ\tname\1\0\3\26use_git_status_colors\2\19trailing_slash\1\14highlight\20NeoTreeFileName\rmodified\1\0\2\14highlight\20NeoTreeModified\vsymbol\b[+]\ticon\1\0\5\18folder_closed\bÓóø\fdefault\6*\14highlight\20NeoTreeFileIcon\17folder_empty\bÔ∞ä\16folder_open\bÓóæ\vindent\1\0\t\14highlight\24NeoTreeIndentMarker\23last_indent_marker\b‚îî\18indent_marker\b‚îÇ\17with_markers\2\fpadding\3\1\16indent_size\3\2\23expander_highlight\20NeoTreeExpander\22expander_expanded\bÔëº\23expander_collapsed\bÔë†\14container\1\0\0\1\0\1\26enable_character_fade\2\1\0\5\26sort_case_insensitive\1\23enable_diagnostics\1\22enable_git_status\1\23popup_border_style\frounded\25close_if_last_window\1\nsetup\rneo-tree\frequire0 let g:neo_tree_remove_legacy_commands = 1 \bcmd\bvim\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/neo-tree.nvim",
    url = "https://github.com/nvim-neo-tree/neo-tree.nvim"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["null-ls.nvim"] = {
    config = { "\27LJ\2\nÈ\1\0\0\b\0\15\1\0246\0\0\0'\2\1\0B\0\2\0029\1\2\0009\1\3\0019\2\2\0009\2\4\0024\3\4\0009\4\5\1>\4\1\0039\4\6\2>\4\2\0039\4\a\0019\4\b\0045\6\n\0005\a\t\0=\a\v\6B\4\2\0?\4\0\0009\4\f\0005\6\r\0=\3\14\6B\4\2\1K\0\1\0\fsources\1\0\0\nsetup\20extra_filetypes\1\0\0\1\2\0\0\vsvelte\twith\14prettierd\veslint\vstylua\16diagnostics\15formatting\rbuiltins\fnull-ls\frequire\aÄÄ¿ô\4\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\n:\0\1\4\0\4\0\0066\1\0\0009\1\1\0019\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\19UltiSnips#Anon\afn\bvimò\1\0\2\4\1\5\0\n-\2\0\0009\3\0\0018\2\3\2=\2\0\0015\2\2\0009\3\3\0009\3\4\0038\2\3\2=\2\1\1L\1\2\0\1¿\tname\vsource\1\0\5\rnvim_lsp\n[LSP]\tpath\v[Path]\rnvim_lua\n[Lua]\vbuffer\r[Buffer]\14ultisnips\14[Snippet]\tmenu\tkindÄ\b\1\0\t\0\29\0.6\0\0\0'\2\1\0B\0\2\0025\1\2\0009\2\3\0005\4\n\0004\5\a\0005\6\4\0>\6\1\0055\6\5\0>\6\2\0055\6\6\0>\6\3\0055\6\a\0>\6\4\0055\6\b\0>\6\5\0055\6\t\0>\6\6\5=\5\v\0045\5\r\0003\6\f\0=\6\14\5=\5\15\0045\5\19\0009\6\16\0009\6\17\0065\b\18\0B\6\2\2=\6\20\0059\6\16\0009\6\21\6B\6\1\2=\6\22\0059\6\16\0009\6\23\6B\6\1\2=\6\24\5=\5\16\0045\5\26\0003\6\25\0=\6\27\5=\5\28\4B\2\2\0012\0\0ÄK\0\1\0\15formatting\vformat\1\0\0\0\n<tab>\21select_next_item\f<s-tab>\21select_prev_item\t<cr>\1\0\0\1\0\1\vselect\2\fconfirm\fmapping\fsnippet\vexpand\1\0\0\0\fsources\1\0\0\1\0\1\tname\28nvim_lsp_signature_help\1\0\1\tname\vcrates\1\0\1\tname\14ultisnips\1\0\1\tname\vbuffer\1\0\1\tname\tpath\1\0\1\tname\rnvim_lsp\nsetup\1\0\24\14Reference\22 Ôúú  (Reference)\vModule\19 Ôô®  (Module)\vFolder\19 Ôùä  (Folder)\14Interface\22 Ô∞Æ  (Interface)\15EnumMember\23 ÔÖù  (EnumMember)\nClass\18 Ô†ñ  (Class)\rConstant\21 Ô≤Ä  (Constant)\rVariable\21[Óúñ] (Variable)\vStruct\19 Ô≥§  (Struct)\nField\18 Ô¥≤  (Field)\nEvent\18 ÔÉß  (Event)\16Constructor\24 Ôê•  (Constructor)\rOperator\21 Ôó´  (Operator)\rFunction\21 Ôûî  (Function)\18TypeParameter\26 ÔûÉ  (TypeParameter)\vMethod\19 Ôö¶  (Method)\tText\18 Ôíû  (Text) \tFile\17 Ôúì  (File)\nColor\18 Ô£ó  (Color)\fKeyword\20 Ô†ä  (Keyword)\tEnum\16 Ô©ó (Enum)\nValue\18 Ô¢ü  (Value)\tUnit\17 Ôëµ  (Unit)\rProperty\20 Ô™∂ (Property)\bcmp\frequire\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\nÉ\1\0\0\4\0\5\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0B\0\3\1K\0\1\0\1\0\b\bRGB\2\bcss\2\vcss_fn\2\vhsl_fn\2\vrgb_fn\2\rRRGGBBAA\2\nnames\1\vRRGGBB\2\1\2\0\0\6*\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-hlslens"] = {
    config = { "\27LJ\2\n∂\5\0\0\a\0\21\0?6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0015\0\3\0006\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\a\0'\5\b\0\18\6\0\0B\1\5\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\t\0'\5\n\0\18\6\0\0B\1\5\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\v\0'\5\f\0\18\6\0\0B\1\5\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\r\0'\5\14\0\18\6\0\0B\1\5\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\15\0'\5\16\0\18\6\0\0B\1\5\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\17\0'\5\18\0\18\6\0\0B\1\5\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\19\0'\5\20\0\18\6\0\0B\1\5\1K\0\1\0\r:noh<CR>\14<Leader>l.g#<Cmd>lua require('hlslens').start()<CR>\ag#.g*<Cmd>lua require('hlslens').start()<CR>\ag*-#<Cmd>lua require('hlslens').start()<CR>\6#-*<Cmd>lua require('hlslens').start()<CR>\6*Y<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>\6NY<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>\6n\20nvim_set_keymap\bapi\bvim\1\0\2\fnoremap\2\vsilent\2\nsetup\fhlslens\frequire\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/nvim-hlslens",
    url = "https://github.com/kevinhwang91/nvim-hlslens"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\n0\0\1\2\0\2\0\a9\1\0\0\6\1\1\0X\1\2Ä+\1\1\0X\2\1Ä+\1\2\0L\1\2\0\fnull-ls\tnameS\1\1\5\0\b\0\n6\1\0\0009\1\1\0019\1\2\0019\1\3\0015\3\5\0003\4\4\0=\4\6\3=\0\a\3B\1\2\1K\0\1\0\nbufnr\vfilter\1\0\0\0\vformat\bbuf\blsp\bvim\27\0\0\3\2\0\0\4-\0\0\0-\2\1\0B\0\2\1K\0\1\0\1\0\1¿†\6\1\2\a\2\17\0$9\2\0\0009\2\1\2\15\0\2\0X\3\6Ä6\2\2\0009\2\3\0029\2\4\2'\4\5\0+\5\1\0B\2\3\0019\2\6\0'\4\a\0B\2\2\2\15\0\2\0X\3\19Ä6\2\2\0009\2\3\0029\2\b\0025\4\t\0-\5\0\0=\5\n\4=\1\v\4B\2\2\0016\2\2\0009\2\3\0029\2\f\2'\4\r\0005\5\14\0-\6\0\0=\6\n\5=\1\v\0053\6\15\0=\6\16\5B\2\3\0012\0\0ÄK\0\1\0\4¿\3¿\rcallback\0\1\0\0\16BufWritePre\24nvim_create_autocmd\vbuffer\ngroup\1\0\0\24nvim_clear_autocmds\28textDocument/formatting\20supports_methodœ\3          hi LspReferenceRead cterm=bold ctermbg=red guibg=#34495e\n          hi LspReferenceText cterm=bold ctermbg=red guibg=#34495e\n          hi LspReferenceWrite cterm=bold ctermbg=red guibg=#34495e\n          augroup lsp_document_highlight\n            autocmd! * <buffer>\n            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()\n            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()\n          augroup END\n        \14nvim_exec\bapi\bvim\30documentHighlightProvider\24server_capabilities†\a\0\1\4\0\14\00016\1\0\0009\1\1\1'\3\2\0B\1\2\0016\1\0\0009\1\1\1'\3\3\0B\1\2\0016\1\0\0009\1\1\1'\3\4\0B\1\2\0016\1\0\0009\1\1\1'\3\5\0B\1\2\0016\1\0\0009\1\1\1'\3\6\0B\1\2\0016\1\0\0009\1\1\1'\3\a\0B\1\2\0016\1\0\0009\1\1\1'\3\b\0B\1\2\0016\1\0\0009\1\1\1'\3\t\0B\1\2\0016\1\0\0009\1\1\1'\3\n\0B\1\2\0016\1\0\0009\1\1\1'\3\v\0B\1\2\0016\1\0\0009\1\1\1'\3\f\0B\1\2\0016\1\0\0009\1\1\1'\3\r\0B\1\2\1K\0\1\0Tcommand! -nargs=0 LspVirtualTextToggle lua require(\"lsp/virtual_text\").toggle()?nnoremap <silent> g] <cmd>Lspsaga diagnostic_jump_next<CR>?nnoremap <silent> g[ <cmd>Lspsaga diagnostic_jump_prev<CR>Bnnoremap <silent> gD <cmd>lua vim.diagnostic.open_float()<CR>6nnoremap <silent> ca <cmd>Lspsaga code_action<CR>Xnnoremap <silent> gp <cmd>lua require('goto-preview').goto_preview_definition()<CR>?nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>Dnnoremap <silent> gi <cmd>lua vim.lsp.buff.implementation()<CR>5nnoremap <silent> gr <cmd>Lspsaga lsp_finder<CR>9nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>9nnoremap <silent> gh <cmd>Lspsaga signature_help<CR>1nnoremap <silent> rn <cmd>Lspsaga rename<CR>\bcmd\bvim#\0\1\4\2\0\0\6-\1\0\0\18\3\0\0B\1\2\1-\1\1\0B\1\1\1K\0\1\0\5¿\6¿®\14\1\0\18\0S\0ù\0016\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0015\2\4\0006\3\2\0009\3\5\0039\3\6\3'\5\a\0005\6\b\0B\3\3\0016\3\2\0009\3\5\0039\3\6\3'\5\t\0005\6\n\0B\3\3\0016\3\2\0009\3\5\0039\3\6\3'\5\v\0005\6\f\0B\3\3\0016\3\2\0009\3\5\0039\3\6\3'\5\r\0005\6\14\0B\3\3\0019\3\15\0019\4\17\0019\6\15\0019\6\18\6\18\a\2\0B\4\3\2=\4\16\0039\3\15\0019\4\17\0019\6\15\0019\6\20\6\18\a\2\0B\4\3\2=\4\19\0039\3\15\0019\4\17\0016\6\2\0009\6\3\0069\6\22\0069\6\23\0065\a\24\0B\4\3\2=\4\21\0033\3\25\0006\4\2\0009\4\26\0049\4\27\4'\6\28\0004\a\0\0B\4\3\0023\5\29\0003\6\30\0003\a\31\0005\b#\0005\t!\0005\n \0=\n\"\t=\t$\b5\t&\0005\n%\0=\n\"\t=\t'\b5\t)\0005\n(\0=\n\"\t=\t*\b5\t,\0005\n+\0=\n\"\t=\t-\b5\t1\0009\n.\0009\n/\n'\f0\0B\n\2\2=\n2\t=\t3\b5\t5\0005\n4\0=\n\"\t=\t6\b4\t\0\0=\t7\b4\t\0\0=\t8\b6\t\2\0009\t\3\t9\t9\t9\t:\tB\t\1\0026\n;\0\18\f\b\0B\n\2\4H\r\20Ä6\15<\0\18\17\14\0B\15\2\2\a\15=\0X\15\3Ä\18\15\14\0B\15\1\2\18\14\15\0006\15\0\0'\17?\0B\15\2\0029\15@\15\18\17\t\0B\15\2\2=\15>\14=\aA\0148\15\r\0009\15B\15\18\17\14\0B\15\2\1F\r\3\3R\rÍ\1275\nH\0005\vC\0005\fD\0=\fE\v5\fF\0=\fG\v=\vI\n5\vJ\0=\aA\v6\f\0\0'\14?\0B\f\2\0029\f@\f\18\14\t\0B\f\2\2=\f>\v5\fN\0005\rL\0005\14K\0=\14M\r=\rO\f=\fP\v=\vQ\n6\v\0\0'\rR\0B\v\2\0029\vB\v\18\r\n\0B\v\2\0012\0\0ÄK\0\1\0\15rust-tools\vserver\rsettings\18rust-analyzer\1\0\0\16checkOnSave\1\0\0\1\0\1\fcommand\vclippy\1\0\0\ntools\1\0\0\16inlay_hints\1\0\3\27parameter_hints_prefix\b <-\25show_parameter_hints\1\23other_hints_prefix\b¬ª \14runnables\1\0\1\18use_telescope\2\1\0\1\17autoSetHints\2\nsetup\14on_attach\25default_capabilities\17cmp_nvim_lsp\17capabilities\rfunction\ttype\npairs\29make_client_capabilities\rprotocol\vsvelte\nvimls\16tailwindcss\1\0\0\1\3\0\0 tailwindcss-language-server\f--stdio\rtsserver\rroot_dir\1\0\0\17package.json\17root_pattern\tutil\vjsonls\1\0\0\1\3\0\0\31vscode-json-languageserver\f--stdio\vlua_ls\1\0\0\1\3\0\0\24lua-language-server\f--stdio\thtml\1\0\0\1\3\0\0\24html-languageserver\f--stdio\ncssls\1\0\0\bcmd\1\0\0\1\3\0\0\23css-languageserver\f--stdio\0\0\0\18LspFormatting\24nvim_create_augroup\bapi\0\1\0\4\nsigns\2\17virtual_text\1\14underline\2\21update_in_insert\1\27on_publish_diagnostics\15diagnostic$textDocument/publishDiagnostics\nhover\23textDocument/hover\19signature_help\twith\31textDocument/signatureHelp\rhandlers\1\0\2\vtexthl\23DiagnosticSignHint\ttext\bÔ¥û\23DiagnosticSignHint\1\0\2\vtexthl\23DiagnosticSignInfo\ttext\bÔÅö\30DiagnosticSignInformation\1\0\2\vtexthl\23DiagnosticSignWarn\ttext\bÔÅ™\23DiagnosticSignWarn\1\0\2\vtexthl\24DiagnosticSignError\ttext\bÔÅó\24DiagnosticSignError\16sign_define\afn\1\0\3\nscope\tline\vborder\frounded\14focusable\1\blsp\bvim\14lspconfig\frequire\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-transparent"] = {
    config = { "\27LJ\2\në\1\0\0\4\0\a\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0024\3\0\0=\3\6\2B\0\2\1K\0\1\0\fexclude\17extra_groups\1\3\0\0\20NeoTreeFileIcon\20NeoTreeExpander\1\0\1\venable\1\nsetup\16transparent\frequire\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/nvim-transparent",
    url = "https://github.com/xiyaowong/nvim-transparent"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n∆\3\0\0\5\0\19\0\0266\0\0\0'\2\1\0B\0\2\2+\1\2\0=\1\2\0006\0\0\0'\2\3\0B\0\2\0029\0\4\0005\2\6\0005\3\5\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\0025\3\f\0=\3\r\0025\3\14\0=\3\15\0025\3\16\0004\4\0\0=\4\17\3=\3\18\2B\0\2\1K\0\1\0\15playground\fdisable\1\0\3\venable\2\15updatetime\3\25\20persist_queries\1\26context_commentstring\1\0\1\venable\2\14highlight\1\0\2\venable\2\21use_languagetree\2\vindent\1\0\1\venable\2\fautotag\1\0\1\venable\2\21ensure_installed\1\0\0\1\14\0\0\15javascript\15typescript\tjson\fgraphql\btsx\thtml\njsdoc\trust\bcss\tbash\blua\tscss\bvim\nsetup\28nvim-treesitter.configs\15prefer_git\28nvim-treesitter.install\frequire\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
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
    config = { "\27LJ\2\nô\5\0\0\5\0\30\0!6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\28\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\0035\4\14\0=\4\15\0035\4\16\0=\4\17\0035\4\18\0=\4\19\0035\4\20\0=\4\21\0035\4\22\0=\4\23\0035\4\24\0=\4\25\0035\4\26\0=\4\27\3=\3\29\2B\0\2\1K\0\1\0\roverride\1\0\0\tlock\1\0\3\tname\tlock\ncolor\f#5c6370\ticon\bÔ†Ω\bmp4\1\0\3\tname\bmp4\ncolor\f#5c6370\ticon\bÔÖÑ\bmp3\1\0\3\tname\bmp3\ncolor\f#566370\ticon\bÔ¢Ö\btxt\1\0\3\tname\ttext\ncolor\f#61afef\ticon\bÔÖú\bmap\1\0\3\tname\btxt\ncolor\f#566370\ticon\bÓòî\taxml\1\0\3\tname\taxml\ncolor\f#f76c7c\ticon\bÔú≠\ttxml\1\0\3\tname\ttxml\ncolor\f#f76c7c\ticon\bÔú≠\bxml\1\0\3\tname\bxml\ncolor\f#f76c7c\ticon\bÔú≠\tacss\1\0\3\tname\bcss\ncolor\f#61afef\ticon\bÓùâ\ttcss\1\0\3\tname\bcss\ncolor\f#61afef\ticon\bÓùâ\bcss\1\0\3\tname\bcss\ncolor\f#61afef\ticon\bÓùâ\thtml\1\0\0\1\0\3\tname\thtml\ncolor\f#f76c7c\ticon\bÔÑª\nsetup\22nvim-web-devicons\frequire\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["package-info.nvim"] = {
    config = { "\27LJ\2\nı\1\0\0\a\0\14\0\0286\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0009\0\5\0005\2\6\0'\3\a\0006\4\0\0'\6\1\0B\4\2\0029\4\b\0045\5\t\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0005\2\n\0'\3\v\0006\4\0\0'\6\1\0B\4\2\0029\4\f\0045\5\r\0B\0\5\1K\0\1\0\1\0\2\fnoremap\2\vsilent\2\thide\15<LEADER>nc\1\2\0\0\6n\1\0\2\fnoremap\2\vsilent\2\tshow\15<LEADER>ns\1\2\0\0\6n\bset\vkeymap\bvim\nsetup\17package-info\frequire\0" },
    loaded = true,
    path = "/Users/kevin/.local/share/nvim/site/pack/packer/start/package-info.nvim",
    url = "https://github.com/vuki656/package-info.nvim"
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
-- Config for: ultisnips
time([[Config for ultisnips]], true)
try_loadstring("\27LJ\2\n>\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\n<C-o>\27UltiSnipsExpandTrigger\6g\bvim\0", "config", "ultisnips")
time([[Config for ultisnips]], false)
-- Config for: null-ls.nvim
time([[Config for null-ls.nvim]], true)
try_loadstring("\27LJ\2\nÈ\1\0\0\b\0\15\1\0246\0\0\0'\2\1\0B\0\2\0029\1\2\0009\1\3\0019\2\2\0009\2\4\0024\3\4\0009\4\5\1>\4\1\0039\4\6\2>\4\2\0039\4\a\0019\4\b\0045\6\n\0005\a\t\0=\a\v\6B\4\2\0?\4\0\0009\4\f\0005\6\r\0=\3\14\6B\4\2\1K\0\1\0\fsources\1\0\0\nsetup\20extra_filetypes\1\0\0\1\2\0\0\vsvelte\twith\14prettierd\veslint\vstylua\16diagnostics\15formatting\rbuiltins\fnull-ls\frequire\aÄÄ¿ô\4\0", "config", "null-ls.nvim")
time([[Config for null-ls.nvim]], false)
-- Config for: package-info.nvim
time([[Config for package-info.nvim]], true)
try_loadstring("\27LJ\2\nı\1\0\0\a\0\14\0\0286\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0009\0\5\0005\2\6\0'\3\a\0006\4\0\0'\6\1\0B\4\2\0029\4\b\0045\5\t\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0005\2\n\0'\3\v\0006\4\0\0'\6\1\0B\4\2\0029\4\f\0045\5\r\0B\0\5\1K\0\1\0\1\0\2\fnoremap\2\vsilent\2\thide\15<LEADER>nc\1\2\0\0\6n\1\0\2\fnoremap\2\vsilent\2\tshow\15<LEADER>ns\1\2\0\0\6n\bset\vkeymap\bvim\nsetup\17package-info\frequire\0", "config", "package-info.nvim")
time([[Config for package-info.nvim]], false)
-- Config for: lspsaga.nvim
time([[Config for lspsaga.nvim]], true)
try_loadstring("\27LJ\2\n¿\1\0\0\6\0\t\0\f6\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0019\1\4\0019\2\5\0005\4\a\0005\5\6\0=\5\b\4B\2\2\1K\0\1\0\21symbol_in_winbar\1\0\0\1\0\6\venable\2\17respect_root\1\17folder_level\3\2\14show_file\2\17hide_keyword\2\14separator\tÔëä \nsetup\bset\vkeymap\bvim\flspsaga\frequire\0", "config", "lspsaga.nvim")
time([[Config for lspsaga.nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\n0\0\1\2\0\2\0\a9\1\0\0\6\1\1\0X\1\2Ä+\1\1\0X\2\1Ä+\1\2\0L\1\2\0\fnull-ls\tnameS\1\1\5\0\b\0\n6\1\0\0009\1\1\0019\1\2\0019\1\3\0015\3\5\0003\4\4\0=\4\6\3=\0\a\3B\1\2\1K\0\1\0\nbufnr\vfilter\1\0\0\0\vformat\bbuf\blsp\bvim\27\0\0\3\2\0\0\4-\0\0\0-\2\1\0B\0\2\1K\0\1\0\1\0\1¿†\6\1\2\a\2\17\0$9\2\0\0009\2\1\2\15\0\2\0X\3\6Ä6\2\2\0009\2\3\0029\2\4\2'\4\5\0+\5\1\0B\2\3\0019\2\6\0'\4\a\0B\2\2\2\15\0\2\0X\3\19Ä6\2\2\0009\2\3\0029\2\b\0025\4\t\0-\5\0\0=\5\n\4=\1\v\4B\2\2\0016\2\2\0009\2\3\0029\2\f\2'\4\r\0005\5\14\0-\6\0\0=\6\n\5=\1\v\0053\6\15\0=\6\16\5B\2\3\0012\0\0ÄK\0\1\0\4¿\3¿\rcallback\0\1\0\0\16BufWritePre\24nvim_create_autocmd\vbuffer\ngroup\1\0\0\24nvim_clear_autocmds\28textDocument/formatting\20supports_methodœ\3          hi LspReferenceRead cterm=bold ctermbg=red guibg=#34495e\n          hi LspReferenceText cterm=bold ctermbg=red guibg=#34495e\n          hi LspReferenceWrite cterm=bold ctermbg=red guibg=#34495e\n          augroup lsp_document_highlight\n            autocmd! * <buffer>\n            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()\n            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()\n          augroup END\n        \14nvim_exec\bapi\bvim\30documentHighlightProvider\24server_capabilities†\a\0\1\4\0\14\00016\1\0\0009\1\1\1'\3\2\0B\1\2\0016\1\0\0009\1\1\1'\3\3\0B\1\2\0016\1\0\0009\1\1\1'\3\4\0B\1\2\0016\1\0\0009\1\1\1'\3\5\0B\1\2\0016\1\0\0009\1\1\1'\3\6\0B\1\2\0016\1\0\0009\1\1\1'\3\a\0B\1\2\0016\1\0\0009\1\1\1'\3\b\0B\1\2\0016\1\0\0009\1\1\1'\3\t\0B\1\2\0016\1\0\0009\1\1\1'\3\n\0B\1\2\0016\1\0\0009\1\1\1'\3\v\0B\1\2\0016\1\0\0009\1\1\1'\3\f\0B\1\2\0016\1\0\0009\1\1\1'\3\r\0B\1\2\1K\0\1\0Tcommand! -nargs=0 LspVirtualTextToggle lua require(\"lsp/virtual_text\").toggle()?nnoremap <silent> g] <cmd>Lspsaga diagnostic_jump_next<CR>?nnoremap <silent> g[ <cmd>Lspsaga diagnostic_jump_prev<CR>Bnnoremap <silent> gD <cmd>lua vim.diagnostic.open_float()<CR>6nnoremap <silent> ca <cmd>Lspsaga code_action<CR>Xnnoremap <silent> gp <cmd>lua require('goto-preview').goto_preview_definition()<CR>?nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>Dnnoremap <silent> gi <cmd>lua vim.lsp.buff.implementation()<CR>5nnoremap <silent> gr <cmd>Lspsaga lsp_finder<CR>9nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>9nnoremap <silent> gh <cmd>Lspsaga signature_help<CR>1nnoremap <silent> rn <cmd>Lspsaga rename<CR>\bcmd\bvim#\0\1\4\2\0\0\6-\1\0\0\18\3\0\0B\1\2\1-\1\1\0B\1\1\1K\0\1\0\5¿\6¿®\14\1\0\18\0S\0ù\0016\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0015\2\4\0006\3\2\0009\3\5\0039\3\6\3'\5\a\0005\6\b\0B\3\3\0016\3\2\0009\3\5\0039\3\6\3'\5\t\0005\6\n\0B\3\3\0016\3\2\0009\3\5\0039\3\6\3'\5\v\0005\6\f\0B\3\3\0016\3\2\0009\3\5\0039\3\6\3'\5\r\0005\6\14\0B\3\3\0019\3\15\0019\4\17\0019\6\15\0019\6\18\6\18\a\2\0B\4\3\2=\4\16\0039\3\15\0019\4\17\0019\6\15\0019\6\20\6\18\a\2\0B\4\3\2=\4\19\0039\3\15\0019\4\17\0016\6\2\0009\6\3\0069\6\22\0069\6\23\0065\a\24\0B\4\3\2=\4\21\0033\3\25\0006\4\2\0009\4\26\0049\4\27\4'\6\28\0004\a\0\0B\4\3\0023\5\29\0003\6\30\0003\a\31\0005\b#\0005\t!\0005\n \0=\n\"\t=\t$\b5\t&\0005\n%\0=\n\"\t=\t'\b5\t)\0005\n(\0=\n\"\t=\t*\b5\t,\0005\n+\0=\n\"\t=\t-\b5\t1\0009\n.\0009\n/\n'\f0\0B\n\2\2=\n2\t=\t3\b5\t5\0005\n4\0=\n\"\t=\t6\b4\t\0\0=\t7\b4\t\0\0=\t8\b6\t\2\0009\t\3\t9\t9\t9\t:\tB\t\1\0026\n;\0\18\f\b\0B\n\2\4H\r\20Ä6\15<\0\18\17\14\0B\15\2\2\a\15=\0X\15\3Ä\18\15\14\0B\15\1\2\18\14\15\0006\15\0\0'\17?\0B\15\2\0029\15@\15\18\17\t\0B\15\2\2=\15>\14=\aA\0148\15\r\0009\15B\15\18\17\14\0B\15\2\1F\r\3\3R\rÍ\1275\nH\0005\vC\0005\fD\0=\fE\v5\fF\0=\fG\v=\vI\n5\vJ\0=\aA\v6\f\0\0'\14?\0B\f\2\0029\f@\f\18\14\t\0B\f\2\2=\f>\v5\fN\0005\rL\0005\14K\0=\14M\r=\rO\f=\fP\v=\vQ\n6\v\0\0'\rR\0B\v\2\0029\vB\v\18\r\n\0B\v\2\0012\0\0ÄK\0\1\0\15rust-tools\vserver\rsettings\18rust-analyzer\1\0\0\16checkOnSave\1\0\0\1\0\1\fcommand\vclippy\1\0\0\ntools\1\0\0\16inlay_hints\1\0\3\27parameter_hints_prefix\b <-\25show_parameter_hints\1\23other_hints_prefix\b¬ª \14runnables\1\0\1\18use_telescope\2\1\0\1\17autoSetHints\2\nsetup\14on_attach\25default_capabilities\17cmp_nvim_lsp\17capabilities\rfunction\ttype\npairs\29make_client_capabilities\rprotocol\vsvelte\nvimls\16tailwindcss\1\0\0\1\3\0\0 tailwindcss-language-server\f--stdio\rtsserver\rroot_dir\1\0\0\17package.json\17root_pattern\tutil\vjsonls\1\0\0\1\3\0\0\31vscode-json-languageserver\f--stdio\vlua_ls\1\0\0\1\3\0\0\24lua-language-server\f--stdio\thtml\1\0\0\1\3\0\0\24html-languageserver\f--stdio\ncssls\1\0\0\bcmd\1\0\0\1\3\0\0\23css-languageserver\f--stdio\0\0\0\18LspFormatting\24nvim_create_augroup\bapi\0\1\0\4\nsigns\2\17virtual_text\1\14underline\2\21update_in_insert\1\27on_publish_diagnostics\15diagnostic$textDocument/publishDiagnostics\nhover\23textDocument/hover\19signature_help\twith\31textDocument/signatureHelp\rhandlers\1\0\2\vtexthl\23DiagnosticSignHint\ttext\bÔ¥û\23DiagnosticSignHint\1\0\2\vtexthl\23DiagnosticSignInfo\ttext\bÔÅö\30DiagnosticSignInformation\1\0\2\vtexthl\23DiagnosticSignWarn\ttext\bÔÅ™\23DiagnosticSignWarn\1\0\2\vtexthl\24DiagnosticSignError\ttext\bÔÅó\24DiagnosticSignError\16sign_define\afn\1\0\3\nscope\tline\vborder\frounded\14focusable\1\blsp\bvim\14lspconfig\frequire\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\nÉ\1\0\0\4\0\5\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0B\0\3\1K\0\1\0\1\0\b\bRGB\2\bcss\2\vcss_fn\2\vhsl_fn\2\vrgb_fn\2\rRRGGBBAA\2\nnames\1\vRRGGBB\2\1\2\0\0\6*\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: goto-preview
time([[Config for goto-preview]], true)
try_loadstring("\27LJ\2\n>\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\17goto-preview\frequire\0", "config", "goto-preview")
time([[Config for goto-preview]], false)
-- Config for: everforest
time([[Config for everforest]], true)
try_loadstring("\27LJ\2\n˙\2\0\0\4\0\r\0#6\0\0\0009\0\1\0\18\1\0\0'\3\2\0B\1\2\1\18\1\0\0'\3\3\0B\1\2\1\18\1\0\0'\3\4\0B\1\2\0016\1\0\0009\1\5\1'\2\a\0=\2\6\0016\1\0\0009\1\5\1)\2\1\0=\2\b\0016\1\0\0009\1\5\1)\2\1\0=\2\t\0016\1\0\0009\1\5\1)\2\0\0=\2\n\0016\1\0\0009\1\5\1)\2\1\0=\2\v\1\18\1\0\0'\3\f\0B\1\2\1K\0\1\0\27colorscheme everforest&everforest_transparent_background&everforest_disable_italic_comment\29everforest_enable_italic\"everforest_better_performance\tsoft\26everforest_background\6g\24set background=dark\22set termguicolors\14syntax on\bcmd\bvim\0", "config", "everforest")
time([[Config for everforest]], false)
-- Config for: vim-floaterm
time([[Config for vim-floaterm]], true)
try_loadstring("\27LJ\2\n‚\1\0\0\2\0\n\2\0216\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0*\1\0\0=\1\6\0006\0\0\0009\0\1\0*\1\1\0=\1\a\0006\0\0\0009\0\1\0'\1\t\0=\1\b\0K\0\1\0\n<C-\\>\27floaterm_keymap_toggle\20floaterm_height\19floaterm_width\16bottomright\22floaterm_position\nfloat\21floaterm_wintype\6g\bvimÁÃô≥\6≥Êåˇ\3\1ÄÄÄˇ\3\0", "config", "vim-floaterm")
time([[Config for vim-floaterm]], false)
-- Config for: barbar.nvim
time([[Config for barbar.nvim]], true)
try_loadstring("\27LJ\2\nÏ\1\0\0\3\0\a\0\r6\0\0\0009\0\1\0005\1\3\0=\1\2\0006\0\0\0009\0\4\0'\2\5\0B\0\2\0016\0\0\0009\0\4\0'\2\6\0B\0\2\1K\0\1\0\26hi TabLine guibg=NONE$hi BufferTabpageFill guibg=NONE\bcmd\1\0\6\26icon_separator_active\5\19icon_close_tab\bÔôò\14clickable\2\rtabpages\2\14animation\2\28icon_separator_inactive\5\15bufferline\6g\bvim\0", "config", "barbar.nvim")
time([[Config for barbar.nvim]], false)
-- Config for: neo-tree.nvim
time([[Config for neo-tree.nvim]], true)
try_loadstring("\27LJ\2\nö\17\0\0\a\0008\0M6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\3\0'\2\4\0B\0\2\0029\0\5\0005\2\6\0005\3\b\0005\4\a\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\0035\4\14\0=\4\15\0035\4\16\0=\4\17\0035\4\19\0005\5\18\0=\5\20\4=\4\21\3=\3\22\0025\3\23\0005\4\24\0=\4\25\0035\4\27\0005\5\26\0=\5\28\0045\5\29\0005\6\30\0=\6\31\5=\5 \4=\4!\3=\3\"\0024\3\0\0=\3#\0025\3(\0005\4$\0004\5\0\0=\5%\0044\5\0\0=\5&\0044\5\0\0=\5'\4=\4)\0036\4*\0=\4+\0035\4-\0005\5,\0=\5!\4=\4\"\3=\3.\0025\3/\0005\0041\0005\0050\0=\5!\4=\4\"\3=\0032\0025\0035\0005\0043\0005\0054\0=\5!\4=\4\"\3=\3\21\2B\0\2\0016\0\0\0009\0\1\0'\0026\0B\0\2\0016\0\0\0009\0\1\0'\0027\0B\0\2\1K\0\1\0'nnoremap <c-b> :Neotree toggle<cr>#nnoremap \\ :Neotree reveal<cr>\1\0\0\1\0\a\aga\17git_add_file\agg\24git_commit_and_push\agu\21git_unstage_file\agp\rgit_push\6A\16git_add_all\agc\15git_commit\agr\20git_revert_file\1\0\1\rposition\nfloat\fbuffers\1\0\0\1\0\3\6.\rset_root\t<bs>\16navigate_up\abd\18buffer_delete\1\0\3\18show_unloaded\2\21group_empty_dirs\2\24follow_current_file\2\15filesystem\1\0\0\1\0\t\6C\rset_root\a]g\22next_git_modified\a[g\22prev_git_modified\n<c-x>\17clear_filter\6f\21filter_on_submit\6D\27fuzzy_finder_directory\6/\17fuzzy_finder\6H\18toggle_hidden\6U\16navigate_up\27use_libuv_file_watcher\btru\19filtered_items\1\0\3\24follow_current_file\2\26hijack_netrw_behavior\17open_current\21group_empty_dirs\1\15never_show\20hide_by_pattern\17hide_by_name\1\0\4\20hide_gitignored\2\18hide_dotfiles\2\fvisible\1\16hide_hidden\2\18nesting_rules\vwindow\rmappings\6a\vconfig\1\0\1\14show_path\tnone\1\2\0\0\badd\f<space>\1\0\15\6p\25paste_from_clipboard\6d\vdelete\6S\15open_split\18<2-LeftMouse>\topen\6z\15close_node\6c\22copy_to_clipboard\6o\topen\6s\16open_vsplit\6r\vrename\6?\14show_help\6q\17close_window\t<cr>\topen\6m\21cut_to_clipboard\6R\frefresh\6n\18add_directory\1\2\1\0\16toggle_node\vnowait\1\20mapping_options\1\0\2\fnoremap\2\vnowait\2\1\0\2\rposition\tleft\nwidth\3(\30default_component_configs\15git_status\fsymbols\1\0\0\1\0\t\runstaged\bÔò∞\rmodified\5\fignored\bÔë¥\14untracked\bÔÑ®\frenamed\bÔïî\fdeleted\b‚úñ\nadded\5\rconflict\bÓúß\vstaged\bÔÅÜ\tname\1\0\3\26use_git_status_colors\2\19trailing_slash\1\14highlight\20NeoTreeFileName\rmodified\1\0\2\14highlight\20NeoTreeModified\vsymbol\b[+]\ticon\1\0\5\18folder_closed\bÓóø\fdefault\6*\14highlight\20NeoTreeFileIcon\17folder_empty\bÔ∞ä\16folder_open\bÓóæ\vindent\1\0\t\14highlight\24NeoTreeIndentMarker\23last_indent_marker\b‚îî\18indent_marker\b‚îÇ\17with_markers\2\fpadding\3\1\16indent_size\3\2\23expander_highlight\20NeoTreeExpander\22expander_expanded\bÔëº\23expander_collapsed\bÔë†\14container\1\0\0\1\0\1\26enable_character_fade\2\1\0\5\26sort_case_insensitive\1\23enable_diagnostics\1\22enable_git_status\1\23popup_border_style\frounded\25close_if_last_window\1\nsetup\rneo-tree\frequire0 let g:neo_tree_remove_legacy_commands = 1 \bcmd\bvim\0", "config", "neo-tree.nvim")
time([[Config for neo-tree.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n∆\3\0\0\5\0\19\0\0266\0\0\0'\2\1\0B\0\2\2+\1\2\0=\1\2\0006\0\0\0'\2\3\0B\0\2\0029\0\4\0005\2\6\0005\3\5\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\0025\3\f\0=\3\r\0025\3\14\0=\3\15\0025\3\16\0004\4\0\0=\4\17\3=\3\18\2B\0\2\1K\0\1\0\15playground\fdisable\1\0\3\venable\2\15updatetime\3\25\20persist_queries\1\26context_commentstring\1\0\1\venable\2\14highlight\1\0\2\venable\2\21use_languagetree\2\vindent\1\0\1\venable\2\fautotag\1\0\1\venable\2\21ensure_installed\1\0\0\1\14\0\0\15javascript\15typescript\tjson\fgraphql\btsx\thtml\njsdoc\trust\bcss\tbash\blua\tscss\bvim\nsetup\28nvim-treesitter.configs\15prefer_git\28nvim-treesitter.install\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: mason.nvim
time([[Config for mason.nvim]], true)
try_loadstring("\27LJ\2\n3\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\nmason\frequire\0", "config", "mason.nvim")
time([[Config for mason.nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\n:\0\1\4\0\4\0\0066\1\0\0009\1\1\0019\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\19UltiSnips#Anon\afn\bvimò\1\0\2\4\1\5\0\n-\2\0\0009\3\0\0018\2\3\2=\2\0\0015\2\2\0009\3\3\0009\3\4\0038\2\3\2=\2\1\1L\1\2\0\1¿\tname\vsource\1\0\5\rnvim_lsp\n[LSP]\tpath\v[Path]\rnvim_lua\n[Lua]\vbuffer\r[Buffer]\14ultisnips\14[Snippet]\tmenu\tkindÄ\b\1\0\t\0\29\0.6\0\0\0'\2\1\0B\0\2\0025\1\2\0009\2\3\0005\4\n\0004\5\a\0005\6\4\0>\6\1\0055\6\5\0>\6\2\0055\6\6\0>\6\3\0055\6\a\0>\6\4\0055\6\b\0>\6\5\0055\6\t\0>\6\6\5=\5\v\0045\5\r\0003\6\f\0=\6\14\5=\5\15\0045\5\19\0009\6\16\0009\6\17\0065\b\18\0B\6\2\2=\6\20\0059\6\16\0009\6\21\6B\6\1\2=\6\22\0059\6\16\0009\6\23\6B\6\1\2=\6\24\5=\5\16\0045\5\26\0003\6\25\0=\6\27\5=\5\28\4B\2\2\0012\0\0ÄK\0\1\0\15formatting\vformat\1\0\0\0\n<tab>\21select_next_item\f<s-tab>\21select_prev_item\t<cr>\1\0\0\1\0\1\vselect\2\fconfirm\fmapping\fsnippet\vexpand\1\0\0\0\fsources\1\0\0\1\0\1\tname\28nvim_lsp_signature_help\1\0\1\tname\vcrates\1\0\1\tname\14ultisnips\1\0\1\tname\vbuffer\1\0\1\tname\tpath\1\0\1\tname\rnvim_lsp\nsetup\1\0\24\14Reference\22 Ôúú  (Reference)\vModule\19 Ôô®  (Module)\vFolder\19 Ôùä  (Folder)\14Interface\22 Ô∞Æ  (Interface)\15EnumMember\23 ÔÖù  (EnumMember)\nClass\18 Ô†ñ  (Class)\rConstant\21 Ô≤Ä  (Constant)\rVariable\21[Óúñ] (Variable)\vStruct\19 Ô≥§  (Struct)\nField\18 Ô¥≤  (Field)\nEvent\18 ÔÉß  (Event)\16Constructor\24 Ôê•  (Constructor)\rOperator\21 Ôó´  (Operator)\rFunction\21 Ôûî  (Function)\18TypeParameter\26 ÔûÉ  (TypeParameter)\vMethod\19 Ôö¶  (Method)\tText\18 Ôíû  (Text) \tFile\17 Ôúì  (File)\nColor\18 Ô£ó  (Color)\fKeyword\20 Ô†ä  (Keyword)\tEnum\16 Ô©ó (Enum)\nValue\18 Ô¢ü  (Value)\tUnit\17 Ôëµ  (Unit)\rProperty\20 Ô™∂ (Property)\bcmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\nÅ\2\0\0\4\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\2B\0\2\0016\0\b\0009\0\t\0'\1\v\0=\1\n\0K\0\1\0\b‚àò\26indent_blankline_char\6g\bvim\20buftype_exclude\1\3\0\0\rterminal\vnofile\21filetype_exclude\1\5\0\0\thelp\btxt\tnorg\amd\1\0\2\31show_current_context_start\2\25show_current_context\2\nsetup\21indent_blankline\frequire\0", "config", "indent-blankline.nvim")
time([[Config for indent-blankline.nvim]], false)
-- Config for: marks.nvim
time([[Config for marks.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\nmarks\frequire\0", "config", "marks.nvim")
time([[Config for marks.nvim]], false)
-- Config for: nvim-transparent
time([[Config for nvim-transparent]], true)
try_loadstring("\27LJ\2\në\1\0\0\4\0\a\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0024\3\0\0=\3\6\2B\0\2\1K\0\1\0\fexclude\17extra_groups\1\3\0\0\20NeoTreeFileIcon\20NeoTreeExpander\1\0\1\venable\1\nsetup\16transparent\frequire\0", "config", "nvim-transparent")
time([[Config for nvim-transparent]], false)
-- Config for: crates.nvim
time([[Config for crates.nvim]], true)
try_loadstring("\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vcrates\frequire\0", "config", "crates.nvim")
time([[Config for crates.nvim]], false)
-- Config for: fzf.vim
time([[Config for fzf.vim]], true)
try_loadstring("\27LJ\2\n‰\1\0\0\3\0\6\0\0176\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\0016\0\0\0009\0\1\0'\2\4\0B\0\2\0016\0\0\0009\0\1\0'\2\5\0B\0\2\1K\0\1\0(nnoremap <Leader>s <cmd>GFiles?<CR>0nnoremap <nowait><Leader>b <cmd>Buffers<CR>#nnoremap <Leader>w <cmd>Rg<CR>&nnoremap <Leader>p <cmd>Files<CR>\bcmd\bvim\0", "config", "fzf.vim")
time([[Config for fzf.vim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n∑\2\0\0\5\0\14\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\f\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\3=\3\r\2B\0\2\1K\0\1\0\foptions\1\0\0\23section_separators\1\0\2\tleft\bÓÇ∏\nright\bÓÇ∫\frefresh\1\0\3\vwinbar\3Ë\a\ftabline\3Ë\a\15statusline\3Ë\a\15extensions\1\2\0\0\rquickfix\23disabled_filetypes\1\4\0\0\rneo-tree\vwinbar\15statusline\1\0\2\25component_separators\5\ntheme\15everforest\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: vim-svelte
time([[Config for vim-svelte]], true)
try_loadstring("\27LJ\2\nA\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\15typescript\25svelte_preprocessors\6g\bvim\0", "config", "vim-svelte")
time([[Config for vim-svelte]], false)
-- Config for: nvim-web-devicons
time([[Config for nvim-web-devicons]], true)
try_loadstring("\27LJ\2\nô\5\0\0\5\0\30\0!6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\28\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\0035\4\14\0=\4\15\0035\4\16\0=\4\17\0035\4\18\0=\4\19\0035\4\20\0=\4\21\0035\4\22\0=\4\23\0035\4\24\0=\4\25\0035\4\26\0=\4\27\3=\3\29\2B\0\2\1K\0\1\0\roverride\1\0\0\tlock\1\0\3\tname\tlock\ncolor\f#5c6370\ticon\bÔ†Ω\bmp4\1\0\3\tname\bmp4\ncolor\f#5c6370\ticon\bÔÖÑ\bmp3\1\0\3\tname\bmp3\ncolor\f#566370\ticon\bÔ¢Ö\btxt\1\0\3\tname\ttext\ncolor\f#61afef\ticon\bÔÖú\bmap\1\0\3\tname\btxt\ncolor\f#566370\ticon\bÓòî\taxml\1\0\3\tname\taxml\ncolor\f#f76c7c\ticon\bÔú≠\ttxml\1\0\3\tname\ttxml\ncolor\f#f76c7c\ticon\bÔú≠\bxml\1\0\3\tname\bxml\ncolor\f#f76c7c\ticon\bÔú≠\tacss\1\0\3\tname\bcss\ncolor\f#61afef\ticon\bÓùâ\ttcss\1\0\3\tname\bcss\ncolor\f#61afef\ticon\bÓùâ\bcss\1\0\3\tname\bcss\ncolor\f#61afef\ticon\bÓùâ\thtml\1\0\0\1\0\3\tname\thtml\ncolor\f#f76c7c\ticon\bÔÑª\nsetup\22nvim-web-devicons\frequire\0", "config", "nvim-web-devicons")
time([[Config for nvim-web-devicons]], false)
-- Config for: hop.nvim
time([[Config for hop.nvim]], true)
try_loadstring("\27LJ\2\nÃ\1\0\0\5\0\f\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0'\3\b\0'\4\t\0B\0\4\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0'\3\n\0'\4\v\0B\0\4\1K\0\1\0\25<cmd>:HopPattern<cr>\afe\23<cmd>:HopChar2<cr>\afw\6n\bset\vkeymap\bvim\1\0\1\tkeys\28etovxqpdygfblzhckisuran\nsetup\bhop\frequire\0", "config", "hop.nvim")
time([[Config for hop.nvim]], false)
-- Config for: nvim-hlslens
time([[Config for nvim-hlslens]], true)
try_loadstring("\27LJ\2\n∂\5\0\0\a\0\21\0?6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0015\0\3\0006\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\a\0'\5\b\0\18\6\0\0B\1\5\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\t\0'\5\n\0\18\6\0\0B\1\5\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\v\0'\5\f\0\18\6\0\0B\1\5\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\r\0'\5\14\0\18\6\0\0B\1\5\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\15\0'\5\16\0\18\6\0\0B\1\5\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\17\0'\5\18\0\18\6\0\0B\1\5\0016\1\4\0009\1\5\0019\1\6\1'\3\a\0'\4\19\0'\5\20\0\18\6\0\0B\1\5\1K\0\1\0\r:noh<CR>\14<Leader>l.g#<Cmd>lua require('hlslens').start()<CR>\ag#.g*<Cmd>lua require('hlslens').start()<CR>\ag*-#<Cmd>lua require('hlslens').start()<CR>\6#-*<Cmd>lua require('hlslens').start()<CR>\6*Y<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>\6NY<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>\6n\20nvim_set_keymap\bapi\bvim\1\0\2\fnoremap\2\vsilent\2\nsetup\fhlslens\frequire\0", "config", "nvim-hlslens")
time([[Config for nvim-hlslens]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
