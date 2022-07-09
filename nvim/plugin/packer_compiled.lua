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
local package_path_str = "/home/tiny/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/tiny/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/tiny/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/tiny/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/tiny/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
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
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/auto-pairs",
    url = "https://github.com/jiangmiao/auto-pairs"
  },
  ["barbar.nvim"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/barbar.nvim",
    url = "https://github.com/romgrk/barbar.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lsp-signature-help"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp-signature-help",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help"
  },
  ["cmp-nvim-ultisnips"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/cmp-nvim-ultisnips",
    url = "https://github.com/quangnguyen30192/cmp-nvim-ultisnips"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["crates.nvim"] = {
    config = { "\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vcrates\frequire\0" },
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/crates.nvim",
    url = "https://github.com/saecki/crates.nvim"
  },
  everforest = {
    config = { "\27LJ\2\nø\1\0\0\4\0\t\0\0196\0\0\0009\0\1\0\18\1\0\0'\3\2\0B\1\2\0016\1\0\0009\1\3\1'\2\5\0=\2\4\1\18\1\0\0'\3\6\0B\1\2\1\18\1\0\0'\3\a\0B\1\2\1\18\1\0\0'\3\b\0B\1\2\1K\0\1\0\22set termguicolors\27colorscheme everforest\24set background=dark\tsoft\26everforest_background\6g\14syntax on\bcmd\bvim\0" },
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/everforest",
    url = "https://github.com/sainnhe/everforest"
  },
  ["formatter.nvim"] = {
    config = { "\27LJ\2\nÄ\1\0\0\5\0\6\1\n5\0\0\0005\1\1\0006\2\2\0009\2\3\0029\2\4\2)\4\0\0B\2\2\0?\2\0\0=\1\5\0L\0\2\0\targs\22nvim_buf_get_name\bapi\bvim\1\2\0\0\21--stdin-filepath\1\0\2\nstdin\2\bexe\rprettier\5ÄÄ¿ô\4(\0\0\1\0\1\0\0025\0\0\0L\0\2\0\1\0\2\nstdin\2\bexe\15lua-formatÊ\4\1\0\b\0\25\00086\0\0\0'\2\1\0B\0\2\0023\1\2\0006\2\3\0009\2\4\0029\2\5\2'\4\6\0+\5\2\0B\2\3\0019\2\a\0005\4\b\0005\5\t\0004\6\3\0>\1\1\6=\6\n\0054\6\3\0>\1\1\6=\6\v\0054\6\3\0>\1\1\6=\6\f\0054\6\3\0>\1\1\6=\6\r\0054\6\3\0>\1\1\6=\6\14\0054\6\3\0>\1\1\6=\6\15\0054\6\3\0>\1\1\6=\6\16\0054\6\3\0>\1\1\6=\6\17\0054\6\3\0>\1\1\6=\6\18\0054\6\3\0>\1\1\6=\6\19\0054\6\3\0>\1\1\6=\6\20\0054\6\3\0>\1\1\6=\6\21\0054\6\3\0003\a\22\0>\a\1\6=\6\23\5=\5\24\4B\2\2\1K\0\1\0\rfiletype\blua\0\rmarkdown\tyaml\tscss\tjson\bvue\bcss\vsvelte\thtml\15javascript\15typescript\20typescriptreact\20javascriptreact\1\0\0\1\0\1\flogging\1\nsetupÿ\1        augroup FormatAutogroup\n          autocmd!\n          autocmd BufWritePost *.js,*.mjs,*.ts,*.lua,*.jsx,*.tsx,*.md,*.mdx,*.yml,*.json,*.css,*.scss,*.html,*.vue,*.svelte FormatWrite\n        augroup END\n    \14nvim_exec\bapi\bvim\0\14formatter\frequire\0" },
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/formatter.nvim",
    url = "https://github.com/mhartington/formatter.nvim"
  },
  ["fzf-lua"] = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0ú\v\1\0\a\0,\00076\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\0016\0\0\0009\0\1\0'\2\4\0B\0\2\0016\0\5\0'\2\6\0B\0\2\0029\0\a\0005\2\b\0005\3\t\0005\4\n\0=\4\v\0035\4\f\0=\4\r\0035\4\14\0005\5\15\0=\5\16\0045\5\17\0=\5\18\4=\4\19\0033\4\20\0=\4\21\3=\3\18\0025\3\23\0005\4\22\0=\4\24\0035\4\25\0=\4\26\0035\4\27\0=\4\28\0035\4\29\0=\4\30\0035\4\31\0=\4 \0035\4!\0005\5#\0005\6\"\0=\6$\0055\6%\0=\6&\5=\5'\4=\4(\3=\3)\0025\3*\0=\3+\2B\0\2\1K\0\1\0\rquickfix\1\0\2\14git_icons\2\15file_icons\2\15previewers\fbuiltin\15extensions\bjpg\1\2\0\0\rueberzug\bpng\1\0\0\1\3\0\0\bviu\a-b\1\0\5\flimit_b\3ÄÄÄ\5\19syntax_limit_b\3ÄÄ@\19syntax_limit_l\3\0\vsyntax\2\20ueberzug_scaler\ncover\bman\1\0\1\bcmd\24man -c %s | col -bx\rgit_diff\1\0\3\18cmd_untracked*git diff --color --no-index /dev/null\16cmd_deleted\29git diff --color HEAD --\17cmd_modified\26git diff --color HEAD\thead\1\0\1\bcmd\thead\bbat\1\0\3\bcmd\bbat\ntheme\17Coldark-Dark\targs+--style=numbers,changes --color always\bcat\1\0\0\1\0\2\bcmd\bcat\targs\r--number\14on_create\0\fpreview\fwinopts\1\0\t\15cursorline\2\vnumber\2\17cursorcolumn\1\18cursorlineopt\tboth\15foldmethod\vmanual\19relativenumber\1\tlist\1\15signcolumn\ano\15foldenable\1\16scrollchars\1\3\0\0\b‚ñà\5\1\0\v\ndelay\3d\twrap\vnowrap\14scrollbar\nfloat\17flip_columns\3x\vlayout\rvertical\ntitle\2\15horizontal\14right:60%\vhidden\rnohidden\rvertical\rdown:45%\14scrolloff\a-2\vborder\vborder\ahl\1\0\5\15cursorline\15CursorLine\vcursor\vCursor\vnormal\vNormal\vsearch\vSearch\vborder\vNormal\vborder\1\t\0\0\b‚ï≠\b‚îÄ\b‚ïÆ\b‚îÇ\b‚ïØ\b‚îÄ\b‚ï∞\b‚îÇ\1\0\5\brow\4ÊÃô≥\6ÊÃŸ˛\3\15fullscreen\1\vheight\4≥ÊÃô\3≥Ê¨ˇ\3\nwidth\4ö≥ÊÃ\tô≥¶ˇ\3\bcol\4\0ÄÄÄˇ\3\1\0\2\24global_resume_query\2\18global_resume\2\nsetup\ffzf-lua\frequire2nnoremap <Leader>s <cmd>FzfLua git_status<CR>1nnoremap <Leader>l <cmd>FzfLua live_grep<CR>-nnoremap <Leader>p <cmd>FzfLua files<CR>\bcmd\bvim\0" },
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/fzf-lua",
    url = "https://github.com/ibhagwan/fzf-lua"
  },
  ["html5.vim"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/html5.vim",
    url = "https://github.com/othree/html5.vim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n‡\1\0\0\5\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\n\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\3=\3\v\2B\0\2\1K\0\1\0\foptions\1\0\0\23disabled_filetypes\1\2\0\0\rneo-tree\25component_separators\1\0\2\tleft\5\nright\5\23section_separators\1\0\2\tleft\5\nright\5\1\0\1\ntheme\15everforest\nsetup\flualine\frequire\0" },
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["neo-tree.nvim"] = {
    config = { "\27LJ\2\nﬂ\19\0\0\a\0A\0a6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\3\0009\0\4\0'\2\5\0005\3\6\0B\0\3\0016\0\0\0009\0\3\0009\0\4\0'\2\a\0005\3\b\0B\0\3\0016\0\0\0009\0\3\0009\0\4\0'\2\t\0005\3\n\0B\0\3\0016\0\0\0009\0\3\0009\0\4\0'\2\v\0005\3\f\0B\0\3\0016\0\r\0'\2\14\0B\0\2\0029\0\15\0005\2\16\0005\3\18\0005\4\17\0=\4\19\0035\4\20\0=\4\21\0035\4\22\0=\4\23\0035\4\24\0=\4\25\0035\4\26\0=\4\27\0035\4\29\0005\5\28\0=\5\30\4=\4\31\3=\3 \0025\3!\0005\4\"\0=\4#\0035\4%\0005\5$\0=\5&\0045\5'\0005\6(\0=\6)\5=\5*\4=\4+\3=\3,\0024\3\0\0=\3-\0025\0032\0005\4.\0004\5\0\0=\5/\0044\5\0\0=\0050\0044\5\0\0=\0051\4=\0043\0036\0044\0=\0045\0035\0047\0005\0056\0=\5+\4=\4,\3=\0038\0025\0039\0005\4;\0005\5:\0=\5+\4=\4,\3=\3<\0025\3?\0005\4=\0005\5>\0=\5+\4=\4,\3=\3\31\2B\0\2\0016\0\0\0009\0\1\0'\2@\0B\0\2\1K\0\1\0#nnoremap \\ :Neotree reveal<cr>\1\0\0\1\0\a\agc\15git_commit\aga\17git_add_file\agp\rgit_push\agu\21git_unstage_file\agg\24git_commit_and_push\6A\16git_add_all\agr\20git_revert_file\1\0\1\rposition\nfloat\fbuffers\1\0\0\1\0\3\abd\18buffer_delete\6.\rset_root\t<bs>\16navigate_up\1\0\3\18show_unloaded\2\21group_empty_dirs\2\24follow_current_file\2\15filesystem\1\0\0\1\0\t\n<c-x>\17clear_filter\6D\27fuzzy_finder_directory\6U\16navigate_up\6f\21filter_on_submit\6/\17fuzzy_finder\6H\18toggle_hidden\6C\rset_root\a]g\22next_git_modified\a[g\22prev_git_modified\27use_libuv_file_watcher\btru\19filtered_items\1\0\3\24follow_current_file\2\26hijack_netrw_behavior\17open_current\21group_empty_dirs\1\15never_show\20hide_by_pattern\17hide_by_name\1\0\4\16hide_hidden\2\20hide_gitignored\2\18hide_dotfiles\2\fvisible\1\18nesting_rules\vwindow\rmappings\6a\vconfig\1\0\1\14show_path\tnone\1\2\0\0\badd\f<space>\1\0\18\6o\topen\6p\25paste_from_clipboard\6r\vrename\6n\18add_directory\6d\vdelete\6q\17close_window\6?\14show_help\6m\tmove\6y\22copy_to_clipboard\6c\tcopy\6x\21cut_to_clipboard\6z\20close_all_nodes\6R\frefresh\6C\15close_node\6s\16open_vsplit\6S\15open_split\18<2-LeftMouse>\topen\t<cr>\topen\1\2\1\0\16toggle_node\vnowait\1\20mapping_options\1\0\2\fnoremap\2\vnowait\2\1\0\2\nwidth\3(\rposition\tleft\30default_component_configs\15git_status\fsymbols\1\0\0\1\0\t\fdeleted\b‚úñ\nadded\5\rconflict\bÓúß\vstaged\bÔÅÜ\runstaged\bÔò∞\fignored\bÔë¥\rmodified\5\14untracked\bÔÑ®\frenamed\bÔïî\tname\1\0\3\14highlight\20NeoTreeFileName\26use_git_status_colors\2\19trailing_slash\1\rmodified\1\0\2\14highlight\20NeoTreeModified\vsymbol\b[+]\ticon\1\0\5\fdefault\6*\18folder_closed\bÓóø\14highlight\20NeoTreeFileIcon\17folder_empty\bÔ∞ä\16folder_open\bÓóæ\vindent\1\0\t\14highlight\24NeoTreeIndentMarker\23expander_highlight\20NeoTreeExpander\22expander_expanded\bÔëº\23expander_collapsed\bÔë†\23last_indent_marker\b‚îî\18indent_marker\b‚îÇ\17with_markers\2\fpadding\3\1\16indent_size\3\2\14container\1\0\0\1\0\1\26enable_character_fade\2\1\0\5\26sort_case_insensitive\1\23enable_diagnostics\2\22enable_git_status\2\23popup_border_style\frounded\25close_if_last_window\1\nsetup\rneo-tree\frequire\1\0\2\vtexthl\23DiagnosticSignHint\ttext\bÔ†¥\23DiagnosticSignHint\1\0\2\vtexthl\23DiagnosticSignInfo\ttext\tÔÅö \23DiagnosticSignInfo\1\0\2\vtexthl\23DiagnosticSignWarn\ttext\tÔÅ± \23DiagnosticSignWarn\1\0\2\vtexthl\24DiagnosticSignError\ttext\tÔÅó \24DiagnosticSignError\16sign_define\afn0 let g:neo_tree_remove_legacy_commands = 1 \bcmd\bvim\0" },
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/neo-tree.nvim",
    url = "https://github.com/nvim-neo-tree/neo-tree.nvim"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\n:\0\1\4\0\4\0\0066\1\0\0009\1\1\0019\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\19UltiSnips#Anon\afn\bvim}\0\2\4\1\5\0\n-\2\0\0009\3\0\0018\2\3\2=\2\0\0015\2\2\0009\3\3\0009\3\4\0038\2\3\2=\2\1\1L\1\2\0\1¿\tname\vsource\1\0\3\14ultisnips\14[Snippet]\vbuffer\r[Buffer]\rnvim_lsp\n[LSP]\tmenu\tkindÄ\b\1\0\t\0\29\0.6\0\0\0'\2\1\0B\0\2\0025\1\2\0009\2\3\0005\4\n\0004\5\a\0005\6\4\0>\6\1\0055\6\5\0>\6\2\0055\6\6\0>\6\3\0055\6\a\0>\6\4\0055\6\b\0>\6\5\0055\6\t\0>\6\6\5=\5\v\0045\5\r\0003\6\f\0=\6\14\5=\5\15\0045\5\19\0009\6\16\0009\6\17\0065\b\18\0B\6\2\2=\6\20\0059\6\16\0009\6\21\6B\6\1\2=\6\22\0059\6\16\0009\6\23\6B\6\1\2=\6\24\5=\5\16\0045\5\26\0003\6\25\0=\6\27\5=\5\28\4B\2\2\0012\0\0ÄK\0\1\0\15formatting\vformat\1\0\0\0\n<tab>\21select_next_item\f<s-tab>\21select_prev_item\t<cr>\1\0\0\1\0\1\vselect\2\fconfirm\fmapping\fsnippet\vexpand\1\0\0\0\fsources\1\0\0\1\0\1\tname\28nvim_lsp_signature_help\1\0\1\tname\vcrates\1\0\1\tname\14ultisnips\1\0\1\tname\vbuffer\1\0\1\tname\tpath\1\0\1\tname\rnvim_lsp\nsetup\1\0\24\14Reference\22 Ôúú  (Reference)\nValue\18 Ô¢ü  (Value)\vFolder\19 Ôùä  (Folder)\tUnit\17 Ôëµ  (Unit)\15EnumMember\23 ÔÖù  (EnumMember)\rProperty\20 Ô™∂ (Property)\rConstant\21 Ô≤Ä  (Constant)\vModule\19 Ôô®  (Module)\vStruct\19 Ô≥§  (Struct)\14Interface\22 Ô∞Æ  (Interface)\nEvent\18 ÔÉß  (Event)\nClass\18 Ô†ñ  (Class)\rOperator\21 Ôó´  (Operator)\rVariable\21[Óúñ] (Variable)\18TypeParameter\26 ÔûÉ  (TypeParameter)\nField\18 Ô¥≤  (Field)\16Constructor\24 Ôê•  (Constructor)\rFunction\21 Ôûî  (Function)\vMethod\19 Ôö¶  (Method)\tText\18 Ôíû  (Text) \tFile\17 Ôúì  (File)\nColor\18 Ô£ó  (Color)\fKeyword\20 Ô†ä  (Keyword)\tEnum\16 Ô©ó (Enum)\bcmp\frequire\0" },
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\nÉ\1\0\0\4\0\5\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0B\0\3\1K\0\1\0\1\0\b\vrgb_fn\2\rRRGGBBAA\2\nnames\1\vRRGGBB\2\bRGB\2\bcss\2\vcss_fn\2\vhsl_fn\2\1\2\0\0\6*\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\n∫\4\0\1\5\0\6\0\v9\1\0\0009\1\1\1\15\0\1\0X\2\6Ä6\1\2\0009\1\3\0019\1\4\1'\3\5\0+\4\1\0B\1\3\1K\0\1\0œ\3          hi LspReferenceRead cterm=bold ctermbg=red guibg=#34495e\n          hi LspReferenceText cterm=bold ctermbg=red guibg=#34495e\n          hi LspReferenceWrite cterm=bold ctermbg=red guibg=#34495e\n          augroup lsp_document_highlight\n            autocmd! * <buffer>\n            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()\n            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()\n          augroup END\n        \14nvim_exec\bapi\bvim\23document_highlight\26resolved_capabilities⁄\6\0\0\3\0\r\0-6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\0016\0\0\0009\0\1\0'\2\4\0B\0\2\0016\0\0\0009\0\1\0'\2\5\0B\0\2\0016\0\0\0009\0\1\0'\2\6\0B\0\2\0016\0\0\0009\0\1\0'\2\a\0B\0\2\0016\0\0\0009\0\1\0'\2\b\0B\0\2\0016\0\0\0009\0\1\0'\2\t\0B\0\2\0016\0\0\0009\0\1\0'\2\n\0B\0\2\0016\0\0\0009\0\1\0'\2\v\0B\0\2\0016\0\0\0009\0\1\0'\2\f\0B\0\2\1K\0\1\0Tcommand! -nargs=0 LspVirtualTextToggle lua require(\"lsp/virtual_text\").toggle()Annoremap <silent> g] <cmd>lua vim.diagnostic.goto_next()<CR>Annoremap <silent> g[ <cmd>lua vim.diagnostic.goto_prev()<CR>Bnnoremap <silent> gD <cmd>lua vim.diagnostic.open_float()<CR>@nnoremap <silent> ca <cmd>lua vim.lsp.buf.code_action()<CR>=nnoremap <silent> gi <cmd>FzfLua lsp_implementations<CR>8nnoremap <silent> gr <cmd>FzfLua lsp_references<CR>9nnoremap <silent> D <cmd>lua vim.lsp.buf.hover()<CR>Cnnoremap <silent> gh <cmd>lua vim.lsp.buf.signature_help()<CR>;nnoremap <silent> rn <cmd>lua vim.lsp.buf.rename()<CR>?nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>\bcmd\bvim#\0\1\4\2\0\0\6-\1\0\0\18\3\0\0B\1\2\1-\1\1\0B\1\1\1K\0\1\0\5¿\6¿π\14\1\0\18\0R\0¢\0016\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\3\0009\2\4\0025\3\5\0005\4\6\0006\5\3\0009\5\a\0059\5\b\5'\a\t\0005\b\n\0B\5\3\0016\5\3\0009\5\a\0059\5\b\5'\a\v\0005\b\f\0B\5\3\0016\5\3\0009\5\a\0059\5\b\5'\a\r\0005\b\14\0B\5\3\0016\5\3\0009\5\a\0059\5\b\5'\a\15\0005\b\16\0B\5\3\0019\5\17\0029\6\19\0029\b\17\0029\b\20\b\18\t\4\0B\6\3\2=\6\18\0059\5\17\0029\6\19\0029\b\17\0029\b\22\b\18\t\4\0B\6\3\2=\6\21\0059\5\17\0029\6\19\0026\b\3\0009\b\4\b9\b\24\b9\b\25\b5\t\26\0B\6\3\2=\6\23\0053\5\27\0003\6\28\0003\a\29\0005\b!\0005\t\31\0005\n\30\0=\n \t=\t\"\b5\t$\0005\n#\0=\n \t=\t%\b5\t'\0005\n&\0=\n \t=\t(\b5\t*\0005\n)\0=\n \t=\t+\b4\t\0\0=\t,\b4\t\0\0=\t-\b4\t\0\0=\t.\b4\t\0\0=\t/\b5\t0\0=\a1\t9\n2\0019\n3\n'\f4\0B\n\2\2=\n5\t5\n6\0=\n7\t=\t8\b6\t9\0\18\v\b\0B\t\2\4H\f\25Ä6\14:\0\18\16\r\0B\14\2\2\a\14;\0X\14\3Ä\18\14\r\0B\14\1\2\18\r\14\0=\a1\r6\14\3\0009\14\4\0149\14<\0149\14=\14B\14\1\0026\15\0\0'\17?\0B\15\2\0029\15@\15\18\17\14\0B\15\2\2=\15>\r8\15\f\0019\15A\15\18\17\r\0B\15\2\1F\f\3\3R\fÂ6\t\3\0009\t\4\t9\t<\t9\t=\tB\t\1\0025\nG\0005\vB\0005\fC\0=\fD\v5\fE\0=\fF\v=\vH\n5\vI\0=\a1\v6\f\0\0'\14?\0B\f\2\0029\f@\f\18\14\t\0B\f\2\2=\f>\v5\fM\0005\rK\0005\14J\0=\14L\r=\rN\f=\fO\v=\vP\n6\v\0\0'\rQ\0B\v\2\0029\vA\v\18\r\n\0B\v\2\0012\0\0ÄK\0\1\0\15rust-tools\vserver\rsettings\18rust-analyzer\1\0\0\16checkOnSave\1\0\0\1\0\1\fcommand\vclippy\1\0\0\ntools\1\0\0\16inlay_hints\1\0\3\23other_hints_prefix\b¬ª \27parameter_hints_prefix\b <-\25show_parameter_hints\1\14runnables\1\0\1\18use_telescope\2\1\0\2\17autoSetHints\2\23hover_with_actions\2\nsetup\24update_capabilities\17cmp_nvim_lsp\17capabilities\29make_client_capabilities\rprotocol\rfunction\ttype\npairs\vdenols\17init_options\1\0\1\tlint\2\rroot_dir\14deno.json\17root_pattern\tutil\14on_attach\1\0\0\vsvelte\nvimls\nvuels\rtsserver\vjsonls\1\0\0\1\3\0\0\31vscode-json-languageserver\f--stdio\16sumneko_lua\1\0\0\1\3\0\0\24lua-language-server\f--stdio\thtml\1\0\0\1\3\0\0\24html-languageserver\f--stdio\ncssls\1\0\0\bcmd\1\0\0\1\3\0\0\23css-languageserver\f--stdio\0\0\0\1\0\4\17virtual_text\1\14underline\2\21update_in_insert\1\nsigns\2\27on_publish_diagnostics\15diagnostic$textDocument/publishDiagnostics\nhover\23textDocument/hover\19signature_help\twith\31textDocument/signatureHelp\rhandlers\1\0\2\vtexthl\23DiagnosticSignHint\ttext\bÔ†¥\23DiagnosticSignHint\1\0\2\vtexthl\23DiagnosticSignInfo\ttext\bÔÑ©\30DiagnosticSignInformation\1\0\2\vtexthl\23DiagnosticSignWarn\ttext\6!\23DiagnosticSignWarn\1\0\2\vtexthl\24DiagnosticSignError\ttext\b‚úó\24DiagnosticSignError\16sign_define\afn\1\0\3\nscope\tline\vborder\frounded\14focusable\1\1\0\2\vsilent\2\fnoremap\2\blsp\bvim\14lspconfig\21vim.lsp.protocol\frequire\0" },
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-transparent"] = {
    config = { "\27LJ\2\nm\0\0\4\0\6\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0024\3\0\0=\3\5\2B\0\2\1K\0\1\0\fexclude\17extra_groups\1\0\1\venable\2\nsetup\16transparent\frequire\0" },
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/nvim-transparent",
    url = "https://github.com/xiyaowong/nvim-transparent"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\nÜ\3\0\0\5\0\17\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\0025\3\f\0=\3\r\0025\3\14\0004\4\0\0=\4\15\3=\3\16\2B\0\2\1K\0\1\0\15playground\fdisable\1\0\3\venable\2\20persist_queries\1\15updatetime\3\25\26context_commentstring\1\0\1\venable\2\14highlight\1\0\2\venable\2\21use_languagetree\2\vindent\1\0\1\venable\2\fautotag\1\0\1\venable\2\21ensure_installed\1\0\0\1\f\0\0\15javascript\15typescript\tjson\fgraphql\btsx\thtml\njsdoc\trust\bcss\tbash\blua\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-ts-autotag"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-web-devicons"] = {
    config = { "\27LJ\2\nô\5\0\0\5\0\30\0!6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\28\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\0035\4\14\0=\4\15\0035\4\16\0=\4\17\0035\4\18\0=\4\19\0035\4\20\0=\4\21\0035\4\22\0=\4\23\0035\4\24\0=\4\25\0035\4\26\0=\4\27\3=\3\29\2B\0\2\1K\0\1\0\roverride\1\0\0\tlock\1\0\3\ncolor\f#5c6370\ticon\bÔ†Ω\tname\tlock\bmp4\1\0\3\ncolor\f#5c6370\ticon\bÔÖÑ\tname\bmp4\bmp3\1\0\3\ncolor\f#566370\ticon\bÔ¢Ö\tname\bmp3\btxt\1\0\3\ncolor\f#61afef\ticon\bÔÖú\tname\ttext\bmap\1\0\3\ncolor\f#566370\ticon\bÓòî\tname\btxt\taxml\1\0\3\ncolor\f#f76c7c\ticon\bÔú≠\tname\taxml\ttxml\1\0\3\ncolor\f#f76c7c\ticon\bÔú≠\tname\ttxml\bxml\1\0\3\ncolor\f#f76c7c\ticon\bÔú≠\tname\bxml\tacss\1\0\3\ncolor\f#61afef\ticon\bÓùâ\tname\bcss\ttcss\1\0\3\ncolor\f#61afef\ticon\bÓùâ\tname\bcss\bcss\1\0\3\ncolor\f#61afef\ticon\bÓùâ\tname\bcss\thtml\1\0\0\1\0\3\ncolor\f#f76c7c\ticon\bÔÑª\tname\thtml\nsetup\22nvim-web-devicons\frequire\0" },
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["nvim-window-picker"] = {
    config = { "\27LJ\2\n˛\1\0\0\6\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\t\0005\4\5\0005\5\4\0=\5\6\0045\5\a\0=\5\b\4=\4\n\3=\3\v\2B\0\2\1K\0\1\0\17filter_rules\abo\1\0\0\fbuftype\1\2\0\0\rterminal\rfiletype\1\0\0\1\5\0\0\rneo-tree\19neo-tree-popup\vnotify\rquickfix\1\0\3\20include_current\1\19autoselect_one\2\23other_win_hl_color\f#e35e4f\nsetup\18window-picker\frequire\0" },
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/nvim-window-picker",
    url = "https://github.com/s1n7ax/nvim-window-picker"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/opt/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["rust-tools.nvim"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/rust-tools.nvim",
    url = "https://github.com/simrat39/rust-tools.nvim"
  },
  ["rust.vim"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/rust.vim",
    url = "https://github.com/rust-lang/rust.vim"
  },
  ["smart-splits.nvim"] = {
    config = { "\27LJ\2\nò\2\0\0\a\0\14\0)6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0006\4\5\0'\6\6\0B\4\2\0029\4\a\4B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\b\0006\4\5\0'\6\6\0B\4\2\0029\4\t\4B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\n\0006\4\5\0'\6\6\0B\4\2\0029\4\v\4B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\f\0006\4\5\0'\6\6\0B\4\2\0029\4\r\4B\0\4\1K\0\1\0\17resize_right\n<S-l>\14resize_up\n<S-k>\16resize_down\n<S-j>\16resize_left\17smart-splits\frequire\n<S-h>\6n\bset\vkeymap\bvim\0" },
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/smart-splits.nvim",
    url = "https://github.com/mrjones2014/smart-splits.nvim"
  },
  ultisnips = {
    config = { "\27LJ\2\n>\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\n<C-o>\27UltiSnipsExpandTrigger\6g\bvim\0" },
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/ultisnips",
    url = "https://github.com/SirVer/ultisnips"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/vim-commentary",
    url = "https://github.com/tpope/vim-commentary"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/vim-devicons",
    url = "https://github.com/ryanoasis/vim-devicons"
  },
  ["vim-easymotion"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/vim-easymotion",
    url = "https://github.com/easymotion/vim-easymotion"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-multiple-cursors"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/vim-multiple-cursors",
    url = "https://github.com/terryma/vim-multiple-cursors"
  },
  ["vim-smoothie"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/vim-smoothie",
    url = "https://github.com/psliwka/vim-smoothie"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/vim-snippets",
    url = "https://github.com/honza/vim-snippets"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-svelte"] = {
    config = { "\27LJ\2\nA\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\15typescript\25svelte_preprocessors\6g\bvim\0" },
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/vim-svelte",
    url = "https://github.com/evanleck/vim-svelte"
  },
  ["vim-toml"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/vim-toml",
    url = "https://github.com/cespare/vim-toml"
  },
  ["vim-vue"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/vim-vue",
    url = "https://github.com/posva/vim-vue"
  },
  ["vista.vim"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/vista.vim",
    url = "https://github.com/liuchengxu/vista.vim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\n:\0\1\4\0\4\0\0066\1\0\0009\1\1\0019\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\19UltiSnips#Anon\afn\bvim}\0\2\4\1\5\0\n-\2\0\0009\3\0\0018\2\3\2=\2\0\0015\2\2\0009\3\3\0009\3\4\0038\2\3\2=\2\1\1L\1\2\0\1¿\tname\vsource\1\0\3\14ultisnips\14[Snippet]\vbuffer\r[Buffer]\rnvim_lsp\n[LSP]\tmenu\tkindÄ\b\1\0\t\0\29\0.6\0\0\0'\2\1\0B\0\2\0025\1\2\0009\2\3\0005\4\n\0004\5\a\0005\6\4\0>\6\1\0055\6\5\0>\6\2\0055\6\6\0>\6\3\0055\6\a\0>\6\4\0055\6\b\0>\6\5\0055\6\t\0>\6\6\5=\5\v\0045\5\r\0003\6\f\0=\6\14\5=\5\15\0045\5\19\0009\6\16\0009\6\17\0065\b\18\0B\6\2\2=\6\20\0059\6\16\0009\6\21\6B\6\1\2=\6\22\0059\6\16\0009\6\23\6B\6\1\2=\6\24\5=\5\16\0045\5\26\0003\6\25\0=\6\27\5=\5\28\4B\2\2\0012\0\0ÄK\0\1\0\15formatting\vformat\1\0\0\0\n<tab>\21select_next_item\f<s-tab>\21select_prev_item\t<cr>\1\0\0\1\0\1\vselect\2\fconfirm\fmapping\fsnippet\vexpand\1\0\0\0\fsources\1\0\0\1\0\1\tname\28nvim_lsp_signature_help\1\0\1\tname\vcrates\1\0\1\tname\14ultisnips\1\0\1\tname\vbuffer\1\0\1\tname\tpath\1\0\1\tname\rnvim_lsp\nsetup\1\0\24\14Reference\22 Ôúú  (Reference)\nValue\18 Ô¢ü  (Value)\vFolder\19 Ôùä  (Folder)\tUnit\17 Ôëµ  (Unit)\15EnumMember\23 ÔÖù  (EnumMember)\rProperty\20 Ô™∂ (Property)\rConstant\21 Ô≤Ä  (Constant)\vModule\19 Ôô®  (Module)\vStruct\19 Ô≥§  (Struct)\14Interface\22 Ô∞Æ  (Interface)\nEvent\18 ÔÉß  (Event)\nClass\18 Ô†ñ  (Class)\rOperator\21 Ôó´  (Operator)\rVariable\21[Óúñ] (Variable)\18TypeParameter\26 ÔûÉ  (TypeParameter)\nField\18 Ô¥≤  (Field)\16Constructor\24 Ôê•  (Constructor)\rFunction\21 Ôûî  (Function)\vMethod\19 Ôö¶  (Method)\tText\18 Ôíû  (Text) \tFile\17 Ôúì  (File)\nColor\18 Ô£ó  (Color)\fKeyword\20 Ô†ä  (Keyword)\tEnum\16 Ô©ó (Enum)\bcmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\n∫\4\0\1\5\0\6\0\v9\1\0\0009\1\1\1\15\0\1\0X\2\6Ä6\1\2\0009\1\3\0019\1\4\1'\3\5\0+\4\1\0B\1\3\1K\0\1\0œ\3          hi LspReferenceRead cterm=bold ctermbg=red guibg=#34495e\n          hi LspReferenceText cterm=bold ctermbg=red guibg=#34495e\n          hi LspReferenceWrite cterm=bold ctermbg=red guibg=#34495e\n          augroup lsp_document_highlight\n            autocmd! * <buffer>\n            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()\n            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()\n          augroup END\n        \14nvim_exec\bapi\bvim\23document_highlight\26resolved_capabilities⁄\6\0\0\3\0\r\0-6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\0016\0\0\0009\0\1\0'\2\4\0B\0\2\0016\0\0\0009\0\1\0'\2\5\0B\0\2\0016\0\0\0009\0\1\0'\2\6\0B\0\2\0016\0\0\0009\0\1\0'\2\a\0B\0\2\0016\0\0\0009\0\1\0'\2\b\0B\0\2\0016\0\0\0009\0\1\0'\2\t\0B\0\2\0016\0\0\0009\0\1\0'\2\n\0B\0\2\0016\0\0\0009\0\1\0'\2\v\0B\0\2\0016\0\0\0009\0\1\0'\2\f\0B\0\2\1K\0\1\0Tcommand! -nargs=0 LspVirtualTextToggle lua require(\"lsp/virtual_text\").toggle()Annoremap <silent> g] <cmd>lua vim.diagnostic.goto_next()<CR>Annoremap <silent> g[ <cmd>lua vim.diagnostic.goto_prev()<CR>Bnnoremap <silent> gD <cmd>lua vim.diagnostic.open_float()<CR>@nnoremap <silent> ca <cmd>lua vim.lsp.buf.code_action()<CR>=nnoremap <silent> gi <cmd>FzfLua lsp_implementations<CR>8nnoremap <silent> gr <cmd>FzfLua lsp_references<CR>9nnoremap <silent> D <cmd>lua vim.lsp.buf.hover()<CR>Cnnoremap <silent> gh <cmd>lua vim.lsp.buf.signature_help()<CR>;nnoremap <silent> rn <cmd>lua vim.lsp.buf.rename()<CR>?nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>\bcmd\bvim#\0\1\4\2\0\0\6-\1\0\0\18\3\0\0B\1\2\1-\1\1\0B\1\1\1K\0\1\0\5¿\6¿π\14\1\0\18\0R\0¢\0016\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\3\0009\2\4\0025\3\5\0005\4\6\0006\5\3\0009\5\a\0059\5\b\5'\a\t\0005\b\n\0B\5\3\0016\5\3\0009\5\a\0059\5\b\5'\a\v\0005\b\f\0B\5\3\0016\5\3\0009\5\a\0059\5\b\5'\a\r\0005\b\14\0B\5\3\0016\5\3\0009\5\a\0059\5\b\5'\a\15\0005\b\16\0B\5\3\0019\5\17\0029\6\19\0029\b\17\0029\b\20\b\18\t\4\0B\6\3\2=\6\18\0059\5\17\0029\6\19\0029\b\17\0029\b\22\b\18\t\4\0B\6\3\2=\6\21\0059\5\17\0029\6\19\0026\b\3\0009\b\4\b9\b\24\b9\b\25\b5\t\26\0B\6\3\2=\6\23\0053\5\27\0003\6\28\0003\a\29\0005\b!\0005\t\31\0005\n\30\0=\n \t=\t\"\b5\t$\0005\n#\0=\n \t=\t%\b5\t'\0005\n&\0=\n \t=\t(\b5\t*\0005\n)\0=\n \t=\t+\b4\t\0\0=\t,\b4\t\0\0=\t-\b4\t\0\0=\t.\b4\t\0\0=\t/\b5\t0\0=\a1\t9\n2\0019\n3\n'\f4\0B\n\2\2=\n5\t5\n6\0=\n7\t=\t8\b6\t9\0\18\v\b\0B\t\2\4H\f\25Ä6\14:\0\18\16\r\0B\14\2\2\a\14;\0X\14\3Ä\18\14\r\0B\14\1\2\18\r\14\0=\a1\r6\14\3\0009\14\4\0149\14<\0149\14=\14B\14\1\0026\15\0\0'\17?\0B\15\2\0029\15@\15\18\17\14\0B\15\2\2=\15>\r8\15\f\0019\15A\15\18\17\r\0B\15\2\1F\f\3\3R\fÂ6\t\3\0009\t\4\t9\t<\t9\t=\tB\t\1\0025\nG\0005\vB\0005\fC\0=\fD\v5\fE\0=\fF\v=\vH\n5\vI\0=\a1\v6\f\0\0'\14?\0B\f\2\0029\f@\f\18\14\t\0B\f\2\2=\f>\v5\fM\0005\rK\0005\14J\0=\14L\r=\rN\f=\fO\v=\vP\n6\v\0\0'\rQ\0B\v\2\0029\vA\v\18\r\n\0B\v\2\0012\0\0ÄK\0\1\0\15rust-tools\vserver\rsettings\18rust-analyzer\1\0\0\16checkOnSave\1\0\0\1\0\1\fcommand\vclippy\1\0\0\ntools\1\0\0\16inlay_hints\1\0\3\23other_hints_prefix\b¬ª \27parameter_hints_prefix\b <-\25show_parameter_hints\1\14runnables\1\0\1\18use_telescope\2\1\0\2\17autoSetHints\2\23hover_with_actions\2\nsetup\24update_capabilities\17cmp_nvim_lsp\17capabilities\29make_client_capabilities\rprotocol\rfunction\ttype\npairs\vdenols\17init_options\1\0\1\tlint\2\rroot_dir\14deno.json\17root_pattern\tutil\14on_attach\1\0\0\vsvelte\nvimls\nvuels\rtsserver\vjsonls\1\0\0\1\3\0\0\31vscode-json-languageserver\f--stdio\16sumneko_lua\1\0\0\1\3\0\0\24lua-language-server\f--stdio\thtml\1\0\0\1\3\0\0\24html-languageserver\f--stdio\ncssls\1\0\0\bcmd\1\0\0\1\3\0\0\23css-languageserver\f--stdio\0\0\0\1\0\4\17virtual_text\1\14underline\2\21update_in_insert\1\nsigns\2\27on_publish_diagnostics\15diagnostic$textDocument/publishDiagnostics\nhover\23textDocument/hover\19signature_help\twith\31textDocument/signatureHelp\rhandlers\1\0\2\vtexthl\23DiagnosticSignHint\ttext\bÔ†¥\23DiagnosticSignHint\1\0\2\vtexthl\23DiagnosticSignInfo\ttext\bÔÑ©\30DiagnosticSignInformation\1\0\2\vtexthl\23DiagnosticSignWarn\ttext\6!\23DiagnosticSignWarn\1\0\2\vtexthl\24DiagnosticSignError\ttext\b‚úó\24DiagnosticSignError\16sign_define\afn\1\0\3\nscope\tline\vborder\frounded\14focusable\1\1\0\2\vsilent\2\fnoremap\2\blsp\bvim\14lspconfig\21vim.lsp.protocol\frequire\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: fzf-lua
time([[Config for fzf-lua]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0ú\v\1\0\a\0,\00076\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\0016\0\0\0009\0\1\0'\2\4\0B\0\2\0016\0\5\0'\2\6\0B\0\2\0029\0\a\0005\2\b\0005\3\t\0005\4\n\0=\4\v\0035\4\f\0=\4\r\0035\4\14\0005\5\15\0=\5\16\0045\5\17\0=\5\18\4=\4\19\0033\4\20\0=\4\21\3=\3\18\0025\3\23\0005\4\22\0=\4\24\0035\4\25\0=\4\26\0035\4\27\0=\4\28\0035\4\29\0=\4\30\0035\4\31\0=\4 \0035\4!\0005\5#\0005\6\"\0=\6$\0055\6%\0=\6&\5=\5'\4=\4(\3=\3)\0025\3*\0=\3+\2B\0\2\1K\0\1\0\rquickfix\1\0\2\14git_icons\2\15file_icons\2\15previewers\fbuiltin\15extensions\bjpg\1\2\0\0\rueberzug\bpng\1\0\0\1\3\0\0\bviu\a-b\1\0\5\flimit_b\3ÄÄÄ\5\19syntax_limit_b\3ÄÄ@\19syntax_limit_l\3\0\vsyntax\2\20ueberzug_scaler\ncover\bman\1\0\1\bcmd\24man -c %s | col -bx\rgit_diff\1\0\3\18cmd_untracked*git diff --color --no-index /dev/null\16cmd_deleted\29git diff --color HEAD --\17cmd_modified\26git diff --color HEAD\thead\1\0\1\bcmd\thead\bbat\1\0\3\bcmd\bbat\ntheme\17Coldark-Dark\targs+--style=numbers,changes --color always\bcat\1\0\0\1\0\2\bcmd\bcat\targs\r--number\14on_create\0\fpreview\fwinopts\1\0\t\15cursorline\2\vnumber\2\17cursorcolumn\1\18cursorlineopt\tboth\15foldmethod\vmanual\19relativenumber\1\tlist\1\15signcolumn\ano\15foldenable\1\16scrollchars\1\3\0\0\b‚ñà\5\1\0\v\ndelay\3d\twrap\vnowrap\14scrollbar\nfloat\17flip_columns\3x\vlayout\rvertical\ntitle\2\15horizontal\14right:60%\vhidden\rnohidden\rvertical\rdown:45%\14scrolloff\a-2\vborder\vborder\ahl\1\0\5\15cursorline\15CursorLine\vcursor\vCursor\vnormal\vNormal\vsearch\vSearch\vborder\vNormal\vborder\1\t\0\0\b‚ï≠\b‚îÄ\b‚ïÆ\b‚îÇ\b‚ïØ\b‚îÄ\b‚ï∞\b‚îÇ\1\0\5\brow\4ÊÃô≥\6ÊÃŸ˛\3\15fullscreen\1\vheight\4≥ÊÃô\3≥Ê¨ˇ\3\nwidth\4ö≥ÊÃ\tô≥¶ˇ\3\bcol\4\0ÄÄÄˇ\3\1\0\2\24global_resume_query\2\18global_resume\2\nsetup\ffzf-lua\frequire2nnoremap <Leader>s <cmd>FzfLua git_status<CR>1nnoremap <Leader>l <cmd>FzfLua live_grep<CR>-nnoremap <Leader>p <cmd>FzfLua files<CR>\bcmd\bvim\0", "config", "fzf-lua")
time([[Config for fzf-lua]], false)
-- Config for: ultisnips
time([[Config for ultisnips]], true)
try_loadstring("\27LJ\2\n>\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\n<C-o>\27UltiSnipsExpandTrigger\6g\bvim\0", "config", "ultisnips")
time([[Config for ultisnips]], false)
-- Config for: smart-splits.nvim
time([[Config for smart-splits.nvim]], true)
try_loadstring("\27LJ\2\nò\2\0\0\a\0\14\0)6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0006\4\5\0'\6\6\0B\4\2\0029\4\a\4B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\b\0006\4\5\0'\6\6\0B\4\2\0029\4\t\4B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\n\0006\4\5\0'\6\6\0B\4\2\0029\4\v\4B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\f\0006\4\5\0'\6\6\0B\4\2\0029\4\r\4B\0\4\1K\0\1\0\17resize_right\n<S-l>\14resize_up\n<S-k>\16resize_down\n<S-j>\16resize_left\17smart-splits\frequire\n<S-h>\6n\bset\vkeymap\bvim\0", "config", "smart-splits.nvim")
time([[Config for smart-splits.nvim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n‡\1\0\0\5\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\n\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\3=\3\v\2B\0\2\1K\0\1\0\foptions\1\0\0\23disabled_filetypes\1\2\0\0\rneo-tree\25component_separators\1\0\2\tleft\5\nright\5\23section_separators\1\0\2\tleft\5\nright\5\1\0\1\ntheme\15everforest\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: nvim-window-picker
time([[Config for nvim-window-picker]], true)
try_loadstring("\27LJ\2\n˛\1\0\0\6\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\t\0005\4\5\0005\5\4\0=\5\6\0045\5\a\0=\5\b\4=\4\n\3=\3\v\2B\0\2\1K\0\1\0\17filter_rules\abo\1\0\0\fbuftype\1\2\0\0\rterminal\rfiletype\1\0\0\1\5\0\0\rneo-tree\19neo-tree-popup\vnotify\rquickfix\1\0\3\20include_current\1\19autoselect_one\2\23other_win_hl_color\f#e35e4f\nsetup\18window-picker\frequire\0", "config", "nvim-window-picker")
time([[Config for nvim-window-picker]], false)
-- Config for: neo-tree.nvim
time([[Config for neo-tree.nvim]], true)
try_loadstring("\27LJ\2\nﬂ\19\0\0\a\0A\0a6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\3\0009\0\4\0'\2\5\0005\3\6\0B\0\3\0016\0\0\0009\0\3\0009\0\4\0'\2\a\0005\3\b\0B\0\3\0016\0\0\0009\0\3\0009\0\4\0'\2\t\0005\3\n\0B\0\3\0016\0\0\0009\0\3\0009\0\4\0'\2\v\0005\3\f\0B\0\3\0016\0\r\0'\2\14\0B\0\2\0029\0\15\0005\2\16\0005\3\18\0005\4\17\0=\4\19\0035\4\20\0=\4\21\0035\4\22\0=\4\23\0035\4\24\0=\4\25\0035\4\26\0=\4\27\0035\4\29\0005\5\28\0=\5\30\4=\4\31\3=\3 \0025\3!\0005\4\"\0=\4#\0035\4%\0005\5$\0=\5&\0045\5'\0005\6(\0=\6)\5=\5*\4=\4+\3=\3,\0024\3\0\0=\3-\0025\0032\0005\4.\0004\5\0\0=\5/\0044\5\0\0=\0050\0044\5\0\0=\0051\4=\0043\0036\0044\0=\0045\0035\0047\0005\0056\0=\5+\4=\4,\3=\0038\0025\0039\0005\4;\0005\5:\0=\5+\4=\4,\3=\3<\0025\3?\0005\4=\0005\5>\0=\5+\4=\4,\3=\3\31\2B\0\2\0016\0\0\0009\0\1\0'\2@\0B\0\2\1K\0\1\0#nnoremap \\ :Neotree reveal<cr>\1\0\0\1\0\a\agc\15git_commit\aga\17git_add_file\agp\rgit_push\agu\21git_unstage_file\agg\24git_commit_and_push\6A\16git_add_all\agr\20git_revert_file\1\0\1\rposition\nfloat\fbuffers\1\0\0\1\0\3\abd\18buffer_delete\6.\rset_root\t<bs>\16navigate_up\1\0\3\18show_unloaded\2\21group_empty_dirs\2\24follow_current_file\2\15filesystem\1\0\0\1\0\t\n<c-x>\17clear_filter\6D\27fuzzy_finder_directory\6U\16navigate_up\6f\21filter_on_submit\6/\17fuzzy_finder\6H\18toggle_hidden\6C\rset_root\a]g\22next_git_modified\a[g\22prev_git_modified\27use_libuv_file_watcher\btru\19filtered_items\1\0\3\24follow_current_file\2\26hijack_netrw_behavior\17open_current\21group_empty_dirs\1\15never_show\20hide_by_pattern\17hide_by_name\1\0\4\16hide_hidden\2\20hide_gitignored\2\18hide_dotfiles\2\fvisible\1\18nesting_rules\vwindow\rmappings\6a\vconfig\1\0\1\14show_path\tnone\1\2\0\0\badd\f<space>\1\0\18\6o\topen\6p\25paste_from_clipboard\6r\vrename\6n\18add_directory\6d\vdelete\6q\17close_window\6?\14show_help\6m\tmove\6y\22copy_to_clipboard\6c\tcopy\6x\21cut_to_clipboard\6z\20close_all_nodes\6R\frefresh\6C\15close_node\6s\16open_vsplit\6S\15open_split\18<2-LeftMouse>\topen\t<cr>\topen\1\2\1\0\16toggle_node\vnowait\1\20mapping_options\1\0\2\fnoremap\2\vnowait\2\1\0\2\nwidth\3(\rposition\tleft\30default_component_configs\15git_status\fsymbols\1\0\0\1\0\t\fdeleted\b‚úñ\nadded\5\rconflict\bÓúß\vstaged\bÔÅÜ\runstaged\bÔò∞\fignored\bÔë¥\rmodified\5\14untracked\bÔÑ®\frenamed\bÔïî\tname\1\0\3\14highlight\20NeoTreeFileName\26use_git_status_colors\2\19trailing_slash\1\rmodified\1\0\2\14highlight\20NeoTreeModified\vsymbol\b[+]\ticon\1\0\5\fdefault\6*\18folder_closed\bÓóø\14highlight\20NeoTreeFileIcon\17folder_empty\bÔ∞ä\16folder_open\bÓóæ\vindent\1\0\t\14highlight\24NeoTreeIndentMarker\23expander_highlight\20NeoTreeExpander\22expander_expanded\bÔëº\23expander_collapsed\bÔë†\23last_indent_marker\b‚îî\18indent_marker\b‚îÇ\17with_markers\2\fpadding\3\1\16indent_size\3\2\14container\1\0\0\1\0\1\26enable_character_fade\2\1\0\5\26sort_case_insensitive\1\23enable_diagnostics\2\22enable_git_status\2\23popup_border_style\frounded\25close_if_last_window\1\nsetup\rneo-tree\frequire\1\0\2\vtexthl\23DiagnosticSignHint\ttext\bÔ†¥\23DiagnosticSignHint\1\0\2\vtexthl\23DiagnosticSignInfo\ttext\tÔÅö \23DiagnosticSignInfo\1\0\2\vtexthl\23DiagnosticSignWarn\ttext\tÔÅ± \23DiagnosticSignWarn\1\0\2\vtexthl\24DiagnosticSignError\ttext\tÔÅó \24DiagnosticSignError\16sign_define\afn0 let g:neo_tree_remove_legacy_commands = 1 \bcmd\bvim\0", "config", "neo-tree.nvim")
time([[Config for neo-tree.nvim]], false)
-- Config for: everforest
time([[Config for everforest]], true)
try_loadstring("\27LJ\2\nø\1\0\0\4\0\t\0\0196\0\0\0009\0\1\0\18\1\0\0'\3\2\0B\1\2\0016\1\0\0009\1\3\1'\2\5\0=\2\4\1\18\1\0\0'\3\6\0B\1\2\1\18\1\0\0'\3\a\0B\1\2\1\18\1\0\0'\3\b\0B\1\2\1K\0\1\0\22set termguicolors\27colorscheme everforest\24set background=dark\tsoft\26everforest_background\6g\14syntax on\bcmd\bvim\0", "config", "everforest")
time([[Config for everforest]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\nÜ\3\0\0\5\0\17\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\0025\3\f\0=\3\r\0025\3\14\0004\4\0\0=\4\15\3=\3\16\2B\0\2\1K\0\1\0\15playground\fdisable\1\0\3\venable\2\20persist_queries\1\15updatetime\3\25\26context_commentstring\1\0\1\venable\2\14highlight\1\0\2\venable\2\21use_languagetree\2\vindent\1\0\1\venable\2\fautotag\1\0\1\venable\2\21ensure_installed\1\0\0\1\f\0\0\15javascript\15typescript\tjson\fgraphql\btsx\thtml\njsdoc\trust\bcss\tbash\blua\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: crates.nvim
time([[Config for crates.nvim]], true)
try_loadstring("\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vcrates\frequire\0", "config", "crates.nvim")
time([[Config for crates.nvim]], false)
-- Config for: formatter.nvim
time([[Config for formatter.nvim]], true)
try_loadstring("\27LJ\2\nÄ\1\0\0\5\0\6\1\n5\0\0\0005\1\1\0006\2\2\0009\2\3\0029\2\4\2)\4\0\0B\2\2\0?\2\0\0=\1\5\0L\0\2\0\targs\22nvim_buf_get_name\bapi\bvim\1\2\0\0\21--stdin-filepath\1\0\2\nstdin\2\bexe\rprettier\5ÄÄ¿ô\4(\0\0\1\0\1\0\0025\0\0\0L\0\2\0\1\0\2\nstdin\2\bexe\15lua-formatÊ\4\1\0\b\0\25\00086\0\0\0'\2\1\0B\0\2\0023\1\2\0006\2\3\0009\2\4\0029\2\5\2'\4\6\0+\5\2\0B\2\3\0019\2\a\0005\4\b\0005\5\t\0004\6\3\0>\1\1\6=\6\n\0054\6\3\0>\1\1\6=\6\v\0054\6\3\0>\1\1\6=\6\f\0054\6\3\0>\1\1\6=\6\r\0054\6\3\0>\1\1\6=\6\14\0054\6\3\0>\1\1\6=\6\15\0054\6\3\0>\1\1\6=\6\16\0054\6\3\0>\1\1\6=\6\17\0054\6\3\0>\1\1\6=\6\18\0054\6\3\0>\1\1\6=\6\19\0054\6\3\0>\1\1\6=\6\20\0054\6\3\0>\1\1\6=\6\21\0054\6\3\0003\a\22\0>\a\1\6=\6\23\5=\5\24\4B\2\2\1K\0\1\0\rfiletype\blua\0\rmarkdown\tyaml\tscss\tjson\bvue\bcss\vsvelte\thtml\15javascript\15typescript\20typescriptreact\20javascriptreact\1\0\0\1\0\1\flogging\1\nsetupÿ\1        augroup FormatAutogroup\n          autocmd!\n          autocmd BufWritePost *.js,*.mjs,*.ts,*.lua,*.jsx,*.tsx,*.md,*.mdx,*.yml,*.json,*.css,*.scss,*.html,*.vue,*.svelte FormatWrite\n        augroup END\n    \14nvim_exec\bapi\bvim\0\14formatter\frequire\0", "config", "formatter.nvim")
time([[Config for formatter.nvim]], false)
-- Config for: nvim-transparent
time([[Config for nvim-transparent]], true)
try_loadstring("\27LJ\2\nm\0\0\4\0\6\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0024\3\0\0=\3\5\2B\0\2\1K\0\1\0\fexclude\17extra_groups\1\0\1\venable\2\nsetup\16transparent\frequire\0", "config", "nvim-transparent")
time([[Config for nvim-transparent]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\nÉ\1\0\0\4\0\5\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0B\0\3\1K\0\1\0\1\0\b\vrgb_fn\2\rRRGGBBAA\2\nnames\1\vRRGGBB\2\bRGB\2\bcss\2\vcss_fn\2\vhsl_fn\2\1\2\0\0\6*\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: vim-svelte
time([[Config for vim-svelte]], true)
try_loadstring("\27LJ\2\nA\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\15typescript\25svelte_preprocessors\6g\bvim\0", "config", "vim-svelte")
time([[Config for vim-svelte]], false)
-- Config for: nvim-web-devicons
time([[Config for nvim-web-devicons]], true)
try_loadstring("\27LJ\2\nô\5\0\0\5\0\30\0!6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\28\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\0035\4\14\0=\4\15\0035\4\16\0=\4\17\0035\4\18\0=\4\19\0035\4\20\0=\4\21\0035\4\22\0=\4\23\0035\4\24\0=\4\25\0035\4\26\0=\4\27\3=\3\29\2B\0\2\1K\0\1\0\roverride\1\0\0\tlock\1\0\3\ncolor\f#5c6370\ticon\bÔ†Ω\tname\tlock\bmp4\1\0\3\ncolor\f#5c6370\ticon\bÔÖÑ\tname\bmp4\bmp3\1\0\3\ncolor\f#566370\ticon\bÔ¢Ö\tname\bmp3\btxt\1\0\3\ncolor\f#61afef\ticon\bÔÖú\tname\ttext\bmap\1\0\3\ncolor\f#566370\ticon\bÓòî\tname\btxt\taxml\1\0\3\ncolor\f#f76c7c\ticon\bÔú≠\tname\taxml\ttxml\1\0\3\ncolor\f#f76c7c\ticon\bÔú≠\tname\ttxml\bxml\1\0\3\ncolor\f#f76c7c\ticon\bÔú≠\tname\bxml\tacss\1\0\3\ncolor\f#61afef\ticon\bÓùâ\tname\bcss\ttcss\1\0\3\ncolor\f#61afef\ticon\bÓùâ\tname\bcss\bcss\1\0\3\ncolor\f#61afef\ticon\bÓùâ\tname\bcss\thtml\1\0\0\1\0\3\ncolor\f#f76c7c\ticon\bÔÑª\tname\thtml\nsetup\22nvim-web-devicons\frequire\0", "config", "nvim-web-devicons")
time([[Config for nvim-web-devicons]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
