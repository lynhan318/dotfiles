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
local package_path_str = "/home/tiny/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/tiny/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/tiny/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/tiny/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/tiny/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
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
  ["defx-git"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/defx-git",
    url = "https://github.com/kristijanhusak/defx-git"
  },
  ["defx-icons"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/defx-icons",
    url = "https://github.com/kristijanhusak/defx-icons"
  },
  ["defx.nvim"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/defx.nvim",
    url = "https://github.com/Shougo/defx.nvim"
  },
  ["formatter.nvim"] = {
    config = { "\27LJ\1\2Ä\1\0\0\4\0\6\1\n3\0\0\0003\1\1\0004\2\2\0007\2\3\0027\2\4\2'\3\0\0>\2\2\0<\2\0\0:\1\5\0H\0\2\0\targs\22nvim_buf_get_name\bapi\bvim\1\2\0\0\21--stdin-filepath\1\0\2\nstdin\2\bexe\rprettier\5ÄÄ¿ô\4D\0\0\2\0\3\0\0043\0\0\0003\1\1\0:\1\2\0H\0\2\0\targs\1\2\0\0\18--emit=stdout\1\0\2\nstdin\2\bexe\frustfmt(\0\0\1\0\1\0\0023\0\0\0H\0\2\0\1\0\2\bexe\15lua-format\nstdin\2œ\4\1\0\a\0\25\00064\0\0\0%\1\1\0>\0\2\0021\1\2\0004\2\3\0007\2\4\0027\2\5\2%\3\6\0)\4\2\0>\2\3\0017\2\a\0003\3\b\0003\4\t\0002\5\3\0;\1\1\5:\5\n\0042\5\3\0;\1\1\5:\5\v\0042\5\3\0;\1\1\5:\5\f\0042\5\3\0;\1\1\5:\5\r\0042\5\3\0;\1\1\5:\5\14\0042\5\3\0;\1\1\5:\5\15\0042\5\3\0;\1\1\5:\5\16\0042\5\3\0;\1\1\5:\5\17\0042\5\3\0;\1\1\5:\5\18\0042\5\3\0;\1\1\5:\5\19\0042\5\3\0001\6\20\0;\6\1\5:\5\21\0042\5\3\0001\6\22\0;\6\1\5:\5\23\4:\4\24\3>\2\2\1G\0\1\0\rfiletype\blua\0\trust\0\rmarkdown\tyaml\tscss\tjson\bcss\thtml\15javascript\15typescript\20typescriptreact\20javascriptreact\1\0\0\1\0\1\flogging\1\nsetupŒ\1        augroup FormatAutogroup\n          autocmd!\n          autocmd BufWritePost *.js,*.mjs,*.ts,*.rs,*.lua,*.jsx,*.tsx,*.md,*.mdx,*.yml,*.json,*.css,*.scss,*.html FormatWrite\n        augroup END\n    \14nvim_exec\bapi\bvim\0\14formatter\frequire\0" },
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/formatter.nvim",
    url = "https://github.com/mhartington/formatter.nvim"
  },
  fzf = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/fzf",
    url = "https://github.com/junegunn/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/fzf.vim",
    url = "https://github.com/junegunn/fzf.vim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/lsp-status.nvim",
    url = "https://github.com/nvim-lua/lsp-status.nvim"
  },
  ["lsp_extensions.nvim"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/lsp_extensions.nvim",
    url = "https://github.com/nvim-lua/lsp_extensions.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/lspsaga.nvim",
    url = "https://github.com/rinx/lspsaga.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\1\2÷\1\0\0\4\0\f\0\0154\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\n\0003\2\3\0003\3\4\0:\3\5\0023\3\6\0:\3\a\0023\3\b\0:\3\t\2:\2\v\1>\0\2\1G\0\1\0\foptions\1\0\0\23disabled_filetypes\1\2\0\0\tdefx\25component_separators\1\0\2\tleft\5\nright\5\23section_separators\1\0\2\tleft\5\nright\5\1\0\1\ntheme\tnord\nsetup\flualine\frequire\0" },
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["nord-vim"] = {
    config = { "\27LJ\1\2å\1\0\0\3\0\6\0\0154\0\0\0007\0\1\0\16\1\0\0%\2\2\0>\1\2\1\16\1\0\0%\2\3\0>\1\2\1\16\1\0\0%\2\4\0>\1\2\1\16\1\0\0%\2\5\0>\1\2\1G\0\1\0\21colorscheme nord\24set background=dark\22set termguicolors\14syntax on\bcmd\bvim\0" },
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/nord-vim",
    url = "https://github.com/arcticicestudio/nord-vim"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\1\2É\1\0\0\3\0\5\0\b4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0003\2\4\0>\0\3\1G\0\1\0\1\0\b\vhsl_fn\2\vrgb_fn\2\rRRGGBBAA\2\nnames\1\bcss\2\bRGB\2\vcss_fn\2\vRRGGBB\2\1\2\0\0\6*\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-compe"] = {
    config = { "\27LJ\1\2«\2\0\0\3\0\6\0\t4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0003\2\4\0:\2\5\1>\0\2\1G\0\1\0\vsource\1\0\n\14ultisnips\2\rnvim_lsp\2\ttags\1\nvsnip\2\tpath\1\18snippets_nvim\2\rnvim_lua\2\nspell\1\vbuffer\2\tcalc\2\1\0\v\17autocomplete\2\19source_timeout\3»\1\fenabled\2\ndebug\1\14preselect\venable\19max_abbr_width\3d\21incomplete_delay\3ê\3\19max_menu_width\3d\19max_kind_width\3d\15min_length\3\1\18throttle_time\3P\nsetup\ncompe\frequire\0" },
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/nvim-compe",
    url = "https://github.com/hrsh7th/nvim-compe"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\1\2∫\4\0\2\5\0\6\0\v7\2\0\0007\2\1\2\15\0\2\0T\3\6Ä4\2\2\0007\2\3\0027\2\4\2%\3\5\0)\4\1\0>\2\3\1G\0\1\0œ\3          hi LspReferenceRead cterm=bold ctermbg=red guibg=#34495e\n          hi LspReferenceText cterm=bold ctermbg=red guibg=#34495e\n          hi LspReferenceWrite cterm=bold ctermbg=red guibg=#34495e\n          augroup lsp_document_highlight\n            autocmd! * <buffer>\n            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()\n            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()\n          augroup END\n        \14nvim_exec\bapi\bvim\23document_highlight\26resolved_capabilities~\0\0\3\0\6\0\t4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0003\2\4\0:\2\5\1>\0\2\1G\0\1\0\17handler_opts\1\0\1\vborder\vsingle\1\0\2\14doc_lines\3\2\tbind\2\14on_attach\18lsp_signature\frequireÏ\1\0\2\6\0\r\0\0307\2\0\1\15\0\2\0T\3\26Ä3\2\6\0003\3\1\0004\4\2\0007\4\3\0047\4\4\0047\5\0\0018\5\1\5>\4\2\2:\4\5\3:\3\a\0023\3\b\0004\4\2\0007\4\3\0047\4\4\0047\5\0\0018\5\2\5>\4\2\2:\4\5\3:\3\t\0024\3\n\0%\4\v\0>\3\2\0027\3\f\3\16\4\0\0\16\5\2\0@\3\3\0G\0\1\0\rin_range\20lsp-status/util\frequire\bend\1\0\1\14character\3\0\nstart\1\0\0\tline\14byte2line\afn\bvim\1\0\1\14character\3\0\15valueRangeã\1\1\1\4\1\a\0\r+\1\0\0007\1\0\0013\2\1\0004\3\2\0:\3\3\0021\3\4\0:\3\5\2>\1\2\1+\1\0\0007\1\6\1\16\2\0\0>\1\2\1G\0\1\0\0¿\14on_attach\18select_symbol\0\16kind_labels\17kind_symbols\1\0\1\21current_function\1\vconfigß\6\0\0\2\0\r\0-4\0\0\0007\0\1\0%\1\2\0>\0\2\0014\0\0\0007\0\1\0%\1\3\0>\0\2\0014\0\0\0007\0\1\0%\1\4\0>\0\2\0014\0\0\0007\0\1\0%\1\5\0>\0\2\0014\0\0\0007\0\1\0%\1\6\0>\0\2\0014\0\0\0007\0\1\0%\1\a\0>\0\2\0014\0\0\0007\0\1\0%\1\b\0>\0\2\0014\0\0\0007\0\1\0%\1\t\0>\0\2\0014\0\0\0007\0\1\0%\1\n\0>\0\2\0014\0\0\0007\0\1\0%\1\v\0>\0\2\0014\0\0\0007\0\1\0%\1\f\0>\0\2\1G\0\1\0Tcommand! -nargs=0 LspVirtualTextToggle lua require(\"lsp/virtual_text\").toggle();nnoremap <silent> g] :Lspsaga diagnostic_jump_next<CR>>nnoremap <silent> g[ :Lspsaga show_cursor_diagnostics<CR>1nnoremap <silent> gh :Lspsaga lsp_finder<CR>5nnoremap <silent> gs :Lspsaga signature_help<CR>2nnoremap <silent> ca :Lspsaga code_action<CR>/nnoremap <silent> K :Lspsaga hover_doc<CR>;nnoremap <silent> rn <cmd>lua vim.lsp.buf.rename()<CR>Cnnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>?nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>?nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>\bcmd\bvim?\0\2\5\4\0\0\f+\2\0\0\16\3\0\0\16\4\1\0>\2\3\1+\2\1\0\16\3\0\0>\2\2\1+\2\2\0>\2\1\1+\2\3\0>\2\1\1G\0\1\0\4¿\6¿\5¿\a¿´\14\1\0\21\0>\0w4\0\0\0%\1\1\0>\0\2\0024\1\0\0%\2\2\0>\1\2\0024\2\0\0%\3\3\0>\2\2\0024\3\0\0%\4\4\0>\3\2\0023\4\6\0:\4\5\0014\4\a\0007\4\b\0047\4\t\4%\5\n\0003\6\v\0>\4\3\0014\4\a\0007\4\b\0047\4\t\4%\5\f\0003\6\r\0>\4\3\0014\4\a\0007\4\b\0047\4\t\4%\5\14\0003\6\15\0>\4\3\0014\4\a\0007\4\b\0047\4\t\4%\5\16\0003\6\17\0>\4\3\0017\4\18\0>\4\1\0017\4\19\0033\5\20\0>\4\2\0014\4\a\0007\4\21\0047\4\22\0044\5\a\0007\5\21\0057\5\24\0054\6\a\0007\6\21\0067\6\25\0067\6\26\0063\a\27\0>\5\3\2:\5\23\0041\4\28\0001\5\29\0001\6\30\0001\a\31\0001\b \0003\t$\0003\n\"\0003\v!\0:\v#\n:\n%\t3\n'\0003\v&\0:\v#\n:\n(\t3\n*\0003\v)\0:\v#\n:\n+\t2\n\0\0:\n,\t2\n\0\0:\n-\t2\n\0\0:\n.\t3\n4\0003\v2\0003\f0\0003\r/\0:\r1\f:\f3\v:\v5\n4\v6\0\16\f\t\0>\v\2\4D\14\24Ä4\0167\0\16\17\15\0>\16\2\2\a\0168\0T\16\3Ä\16\16\15\0>\16\1\2\16\15\16\0:\b9\0154\16\a\0007\16;\16%\17<\0007\18:\15\14\0\18\0T\19\1Ä2\18\0\0007\19:\0\16\20\n\0>\16\5\2:\16:\0156\16\14\0027\16=\16\16\17\15\0>\16\2\1B\14\3\3N\14Ê0\0\0ÄG\0\1\0\nsetup\tkeep\20tbl_deep_extend\17capabilities\14on_attach\rfunction\ttype\npairs\17textDocument\1\0\1\15codeAction\2\15completion\1\0\0\19completionItem\1\0\0\1\0\1\19snippetSupport\2\nvimls\rtsserver\18rust_analyzer\vjsonls\1\0\0\1\3\0\0\31vscode-json-languageserver\f--stdio\thtml\1\0\0\1\3\0\0\24html-languageserver\f--stdio\ncssls\1\0\0\bcmd\1\0\0\1\3\0\0\23css-languageserver\f--stdio\0\0\0\0\0\1\0\4\14underline\2\nsigns\2\17virtual_text\1\21update_in_insert\1\27on_publish_diagnostics\15diagnostic\twith$textDocument/publishDiagnostics\rhandlers\blsp\1\0\1\29use_saga_diagnostic_sign\1\18init_lsp_saga\22register_progress\1\0\3\ttext\bÔÅö\vtexthl\"LspDiagnosticsSignInformation\nnumhl\14WhiteSign\"LspDiagnosticsSignInformation\1\0\3\ttext\bÔÅ™\vtexthl\27LspDiagnosticsSignHint\nnumhl\rBlueSign\27LspDiagnosticsSignHint\1\0\3\ttext\bÔÅ±\vtexthl\30LspDiagnosticsSignWarning\nnumhl\15YellowSign\30LspDiagnosticsSignWarning\1\0\3\ttext\bÔÅó\vtexthl\28LspDiagnosticsSignError\nnumhl\fRedSign\28LspDiagnosticsSignError\16sign_define\afn\bvim\1\26\0\0\18 Ôíû  (Text) \19 Ôö¶  (Method)\21 Ôûî  (Function)\24 Ôê•  (Constructor)\18 Ô¥≤  (Field)\21[Óúñ] (Variable)\18 Ô†ñ  (Class)\22 Ô∞Æ  (Interface)\19 Ôô®  (Module)\20 Ô™∂ (Property)\17 Ôëµ  (Unit)\18 Ô¢ü  (Value)\16 Ô©ó (Enum)\20 Ô†ä  (Keyword)\20 ÔÉÑ  (Snippet)\18 Ô£ó  (Color)\17 Ôúì  (File)\22 Ôúú  (Reference)\19 Ôùä  (Folder)\23 ÔÖù  (EnumMember)\21 Ô≤Ä  (Constant)\19 Ô≥§  (Struct)\18 ÔÉß  (Event)\21 Ôó´  (Operator)\26 ÔûÉ  (TypeParameter)\23CompletionItemKind\flspsaga\14lspconfig\21vim.lsp.protocol\15lsp-status\frequire\0" },
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-lspfuzzy"] = {
    config = { "\27LJ\1\2À\1\0\0\3\0\b\0\v4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0003\2\4\0:\2\5\0013\2\6\0:\2\a\1>\0\2\1G\0\1\0\15fzf_action\1\0\3\vctrl-t\ftabedit\vctrl-x\nsplit\vctrl-v\vvsplit\16fzf_preview\1\2\0\0\18right:+{2}-/2\1\0\3\17fzf_modifier\t:~:.\rfzf_trim\2\fmethods\ball\nsetup\rlspfuzzy\frequire\0" },
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/nvim-lspfuzzy",
    url = "https://github.com/ojroques/nvim-lspfuzzy"
  },
  ["nvim-lspinstall"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/nvim-lspinstall",
    url = "https://github.com/kabouzeid/nvim-lspinstall"
  },
  ["nvim-transparent"] = {
    config = { "\27LJ\1\2m\0\0\3\0\6\0\v4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0002\2\0\0:\2\4\0012\2\0\0:\2\5\1>\0\2\1G\0\1\0\fexclude\17extra_groups\1\0\1\venable\2\nsetup\16transparent\frequire\0" },
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/nvim-transparent",
    url = "https://github.com/xiyaowong/nvim-transparent"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\1\2Ü\3\0\0\4\0\17\0\0214\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\4\0003\2\3\0:\2\5\0013\2\6\0:\2\a\0013\2\b\0:\2\t\0013\2\n\0:\2\v\0013\2\f\0:\2\r\0013\2\14\0002\3\0\0:\3\15\2:\2\16\1>\0\2\1G\0\1\0\15playground\fdisable\1\0\3\15updatetime\3\25\20persist_queries\1\venable\2\26context_commentstring\1\0\1\venable\2\14highlight\1\0\2\21use_languagetree\2\venable\2\vindent\1\0\1\venable\2\fautotag\1\0\1\venable\2\21ensure_installed\1\0\0\1\f\0\0\15javascript\15typescript\tjson\fgraphql\btsx\thtml\njsdoc\trust\bcss\tbash\blua\nsetup\28nvim-treesitter.configs\frequire\0" },
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
    config = { "\27LJ\1\2ô\5\0\0\4\0\30\0!4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\28\0003\2\4\0003\3\3\0:\3\5\0023\3\6\0:\3\a\0023\3\b\0:\3\t\0023\3\n\0:\3\v\0023\3\f\0:\3\r\0023\3\14\0:\3\15\0023\3\16\0:\3\17\0023\3\18\0:\3\19\0023\3\20\0:\3\21\0023\3\22\0:\3\23\0023\3\24\0:\3\25\0023\3\26\0:\3\27\2:\2\29\1>\0\2\1G\0\1\0\roverride\1\0\0\tlock\1\0\3\ncolor\f#5c6370\ticon\bÔ†Ω\tname\tlock\bmp4\1\0\3\ncolor\f#5c6370\ticon\bÔÖÑ\tname\bmp4\bmp3\1\0\3\ncolor\f#566370\ticon\bÔ¢Ö\tname\bmp3\btxt\1\0\3\ncolor\f#61afef\ticon\bÔÖú\tname\ttext\bmap\1\0\3\ncolor\f#566370\ticon\bÓòî\tname\btxt\taxml\1\0\3\ncolor\f#f76c7c\ticon\bÔú≠\tname\taxml\ttxml\1\0\3\ncolor\f#f76c7c\ticon\bÔú≠\tname\ttxml\bxml\1\0\3\ncolor\f#f76c7c\ticon\bÔú≠\tname\bxml\tacss\1\0\3\ncolor\f#61afef\ticon\bÓùâ\tname\bcss\ttcss\1\0\3\ncolor\f#61afef\ticon\bÓùâ\tname\bcss\bcss\1\0\3\ncolor\f#61afef\ticon\bÓùâ\tname\bcss\thtml\1\0\0\1\0\3\ncolor\f#f76c7c\ticon\bÔÑª\tname\thtml\nsetup\22nvim-web-devicons\frequire\0" },
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
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
  ["rust.vim"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/rust.vim",
    url = "https://github.com/rust-lang/rust.vim"
  },
  tagbar = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/tagbar",
    url = "https://github.com/majutsushi/tagbar"
  },
  ultisnips = {
    config = { "\27LJ\1\2J\0\0\3\0\5\0\a4\0\0\0007\0\1\0004\1\0\0007\1\2\1%\2\4\0:\2\3\1G\0\1\0\n<C-e>\27UltiSnipsExpandTrigger\6g\bcmd\bvim\0" },
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
  ["vim-toml"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/vim-toml",
    url = "https://github.com/cespare/vim-toml"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: formatter.nvim
time([[Config for formatter.nvim]], true)
try_loadstring("\27LJ\1\2Ä\1\0\0\4\0\6\1\n3\0\0\0003\1\1\0004\2\2\0007\2\3\0027\2\4\2'\3\0\0>\2\2\0<\2\0\0:\1\5\0H\0\2\0\targs\22nvim_buf_get_name\bapi\bvim\1\2\0\0\21--stdin-filepath\1\0\2\nstdin\2\bexe\rprettier\5ÄÄ¿ô\4D\0\0\2\0\3\0\0043\0\0\0003\1\1\0:\1\2\0H\0\2\0\targs\1\2\0\0\18--emit=stdout\1\0\2\nstdin\2\bexe\frustfmt(\0\0\1\0\1\0\0023\0\0\0H\0\2\0\1\0\2\bexe\15lua-format\nstdin\2œ\4\1\0\a\0\25\00064\0\0\0%\1\1\0>\0\2\0021\1\2\0004\2\3\0007\2\4\0027\2\5\2%\3\6\0)\4\2\0>\2\3\0017\2\a\0003\3\b\0003\4\t\0002\5\3\0;\1\1\5:\5\n\0042\5\3\0;\1\1\5:\5\v\0042\5\3\0;\1\1\5:\5\f\0042\5\3\0;\1\1\5:\5\r\0042\5\3\0;\1\1\5:\5\14\0042\5\3\0;\1\1\5:\5\15\0042\5\3\0;\1\1\5:\5\16\0042\5\3\0;\1\1\5:\5\17\0042\5\3\0;\1\1\5:\5\18\0042\5\3\0;\1\1\5:\5\19\0042\5\3\0001\6\20\0;\6\1\5:\5\21\0042\5\3\0001\6\22\0;\6\1\5:\5\23\4:\4\24\3>\2\2\1G\0\1\0\rfiletype\blua\0\trust\0\rmarkdown\tyaml\tscss\tjson\bcss\thtml\15javascript\15typescript\20typescriptreact\20javascriptreact\1\0\0\1\0\1\flogging\1\nsetupŒ\1        augroup FormatAutogroup\n          autocmd!\n          autocmd BufWritePost *.js,*.mjs,*.ts,*.rs,*.lua,*.jsx,*.tsx,*.md,*.mdx,*.yml,*.json,*.css,*.scss,*.html FormatWrite\n        augroup END\n    \14nvim_exec\bapi\bvim\0\14formatter\frequire\0", "config", "formatter.nvim")
time([[Config for formatter.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\1\2Ü\3\0\0\4\0\17\0\0214\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\4\0003\2\3\0:\2\5\0013\2\6\0:\2\a\0013\2\b\0:\2\t\0013\2\n\0:\2\v\0013\2\f\0:\2\r\0013\2\14\0002\3\0\0:\3\15\2:\2\16\1>\0\2\1G\0\1\0\15playground\fdisable\1\0\3\15updatetime\3\25\20persist_queries\1\venable\2\26context_commentstring\1\0\1\venable\2\14highlight\1\0\2\21use_languagetree\2\venable\2\vindent\1\0\1\venable\2\fautotag\1\0\1\venable\2\21ensure_installed\1\0\0\1\f\0\0\15javascript\15typescript\tjson\fgraphql\btsx\thtml\njsdoc\trust\bcss\tbash\blua\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: nvim-lspfuzzy
time([[Config for nvim-lspfuzzy]], true)
try_loadstring("\27LJ\1\2À\1\0\0\3\0\b\0\v4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0003\2\4\0:\2\5\0013\2\6\0:\2\a\1>\0\2\1G\0\1\0\15fzf_action\1\0\3\vctrl-t\ftabedit\vctrl-x\nsplit\vctrl-v\vvsplit\16fzf_preview\1\2\0\0\18right:+{2}-/2\1\0\3\17fzf_modifier\t:~:.\rfzf_trim\2\fmethods\ball\nsetup\rlspfuzzy\frequire\0", "config", "nvim-lspfuzzy")
time([[Config for nvim-lspfuzzy]], false)
-- Config for: nvim-web-devicons
time([[Config for nvim-web-devicons]], true)
try_loadstring("\27LJ\1\2ô\5\0\0\4\0\30\0!4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\28\0003\2\4\0003\3\3\0:\3\5\0023\3\6\0:\3\a\0023\3\b\0:\3\t\0023\3\n\0:\3\v\0023\3\f\0:\3\r\0023\3\14\0:\3\15\0023\3\16\0:\3\17\0023\3\18\0:\3\19\0023\3\20\0:\3\21\0023\3\22\0:\3\23\0023\3\24\0:\3\25\0023\3\26\0:\3\27\2:\2\29\1>\0\2\1G\0\1\0\roverride\1\0\0\tlock\1\0\3\ncolor\f#5c6370\ticon\bÔ†Ω\tname\tlock\bmp4\1\0\3\ncolor\f#5c6370\ticon\bÔÖÑ\tname\bmp4\bmp3\1\0\3\ncolor\f#566370\ticon\bÔ¢Ö\tname\bmp3\btxt\1\0\3\ncolor\f#61afef\ticon\bÔÖú\tname\ttext\bmap\1\0\3\ncolor\f#566370\ticon\bÓòî\tname\btxt\taxml\1\0\3\ncolor\f#f76c7c\ticon\bÔú≠\tname\taxml\ttxml\1\0\3\ncolor\f#f76c7c\ticon\bÔú≠\tname\ttxml\bxml\1\0\3\ncolor\f#f76c7c\ticon\bÔú≠\tname\bxml\tacss\1\0\3\ncolor\f#61afef\ticon\bÓùâ\tname\bcss\ttcss\1\0\3\ncolor\f#61afef\ticon\bÓùâ\tname\bcss\bcss\1\0\3\ncolor\f#61afef\ticon\bÓùâ\tname\bcss\thtml\1\0\0\1\0\3\ncolor\f#f76c7c\ticon\bÔÑª\tname\thtml\nsetup\22nvim-web-devicons\frequire\0", "config", "nvim-web-devicons")
time([[Config for nvim-web-devicons]], false)
-- Config for: nvim-compe
time([[Config for nvim-compe]], true)
try_loadstring("\27LJ\1\2«\2\0\0\3\0\6\0\t4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0003\2\4\0:\2\5\1>\0\2\1G\0\1\0\vsource\1\0\n\14ultisnips\2\rnvim_lsp\2\ttags\1\nvsnip\2\tpath\1\18snippets_nvim\2\rnvim_lua\2\nspell\1\vbuffer\2\tcalc\2\1\0\v\17autocomplete\2\19source_timeout\3»\1\fenabled\2\ndebug\1\14preselect\venable\19max_abbr_width\3d\21incomplete_delay\3ê\3\19max_menu_width\3d\19max_kind_width\3d\15min_length\3\1\18throttle_time\3P\nsetup\ncompe\frequire\0", "config", "nvim-compe")
time([[Config for nvim-compe]], false)
-- Config for: nvim-transparent
time([[Config for nvim-transparent]], true)
try_loadstring("\27LJ\1\2m\0\0\3\0\6\0\v4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0002\2\0\0:\2\4\0012\2\0\0:\2\5\1>\0\2\1G\0\1\0\fexclude\17extra_groups\1\0\1\venable\2\nsetup\16transparent\frequire\0", "config", "nvim-transparent")
time([[Config for nvim-transparent]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\1\2÷\1\0\0\4\0\f\0\0154\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\n\0003\2\3\0003\3\4\0:\3\5\0023\3\6\0:\3\a\0023\3\b\0:\3\t\2:\2\v\1>\0\2\1G\0\1\0\foptions\1\0\0\23disabled_filetypes\1\2\0\0\tdefx\25component_separators\1\0\2\tleft\5\nright\5\23section_separators\1\0\2\tleft\5\nright\5\1\0\1\ntheme\tnord\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\1\2∫\4\0\2\5\0\6\0\v7\2\0\0007\2\1\2\15\0\2\0T\3\6Ä4\2\2\0007\2\3\0027\2\4\2%\3\5\0)\4\1\0>\2\3\1G\0\1\0œ\3          hi LspReferenceRead cterm=bold ctermbg=red guibg=#34495e\n          hi LspReferenceText cterm=bold ctermbg=red guibg=#34495e\n          hi LspReferenceWrite cterm=bold ctermbg=red guibg=#34495e\n          augroup lsp_document_highlight\n            autocmd! * <buffer>\n            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()\n            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()\n          augroup END\n        \14nvim_exec\bapi\bvim\23document_highlight\26resolved_capabilities~\0\0\3\0\6\0\t4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0003\2\4\0:\2\5\1>\0\2\1G\0\1\0\17handler_opts\1\0\1\vborder\vsingle\1\0\2\14doc_lines\3\2\tbind\2\14on_attach\18lsp_signature\frequireÏ\1\0\2\6\0\r\0\0307\2\0\1\15\0\2\0T\3\26Ä3\2\6\0003\3\1\0004\4\2\0007\4\3\0047\4\4\0047\5\0\0018\5\1\5>\4\2\2:\4\5\3:\3\a\0023\3\b\0004\4\2\0007\4\3\0047\4\4\0047\5\0\0018\5\2\5>\4\2\2:\4\5\3:\3\t\0024\3\n\0%\4\v\0>\3\2\0027\3\f\3\16\4\0\0\16\5\2\0@\3\3\0G\0\1\0\rin_range\20lsp-status/util\frequire\bend\1\0\1\14character\3\0\nstart\1\0\0\tline\14byte2line\afn\bvim\1\0\1\14character\3\0\15valueRangeã\1\1\1\4\1\a\0\r+\1\0\0007\1\0\0013\2\1\0004\3\2\0:\3\3\0021\3\4\0:\3\5\2>\1\2\1+\1\0\0007\1\6\1\16\2\0\0>\1\2\1G\0\1\0\0¿\14on_attach\18select_symbol\0\16kind_labels\17kind_symbols\1\0\1\21current_function\1\vconfigß\6\0\0\2\0\r\0-4\0\0\0007\0\1\0%\1\2\0>\0\2\0014\0\0\0007\0\1\0%\1\3\0>\0\2\0014\0\0\0007\0\1\0%\1\4\0>\0\2\0014\0\0\0007\0\1\0%\1\5\0>\0\2\0014\0\0\0007\0\1\0%\1\6\0>\0\2\0014\0\0\0007\0\1\0%\1\a\0>\0\2\0014\0\0\0007\0\1\0%\1\b\0>\0\2\0014\0\0\0007\0\1\0%\1\t\0>\0\2\0014\0\0\0007\0\1\0%\1\n\0>\0\2\0014\0\0\0007\0\1\0%\1\v\0>\0\2\0014\0\0\0007\0\1\0%\1\f\0>\0\2\1G\0\1\0Tcommand! -nargs=0 LspVirtualTextToggle lua require(\"lsp/virtual_text\").toggle();nnoremap <silent> g] :Lspsaga diagnostic_jump_next<CR>>nnoremap <silent> g[ :Lspsaga show_cursor_diagnostics<CR>1nnoremap <silent> gh :Lspsaga lsp_finder<CR>5nnoremap <silent> gs :Lspsaga signature_help<CR>2nnoremap <silent> ca :Lspsaga code_action<CR>/nnoremap <silent> K :Lspsaga hover_doc<CR>;nnoremap <silent> rn <cmd>lua vim.lsp.buf.rename()<CR>Cnnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>?nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>?nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>\bcmd\bvim?\0\2\5\4\0\0\f+\2\0\0\16\3\0\0\16\4\1\0>\2\3\1+\2\1\0\16\3\0\0>\2\2\1+\2\2\0>\2\1\1+\2\3\0>\2\1\1G\0\1\0\4¿\6¿\5¿\a¿´\14\1\0\21\0>\0w4\0\0\0%\1\1\0>\0\2\0024\1\0\0%\2\2\0>\1\2\0024\2\0\0%\3\3\0>\2\2\0024\3\0\0%\4\4\0>\3\2\0023\4\6\0:\4\5\0014\4\a\0007\4\b\0047\4\t\4%\5\n\0003\6\v\0>\4\3\0014\4\a\0007\4\b\0047\4\t\4%\5\f\0003\6\r\0>\4\3\0014\4\a\0007\4\b\0047\4\t\4%\5\14\0003\6\15\0>\4\3\0014\4\a\0007\4\b\0047\4\t\4%\5\16\0003\6\17\0>\4\3\0017\4\18\0>\4\1\0017\4\19\0033\5\20\0>\4\2\0014\4\a\0007\4\21\0047\4\22\0044\5\a\0007\5\21\0057\5\24\0054\6\a\0007\6\21\0067\6\25\0067\6\26\0063\a\27\0>\5\3\2:\5\23\0041\4\28\0001\5\29\0001\6\30\0001\a\31\0001\b \0003\t$\0003\n\"\0003\v!\0:\v#\n:\n%\t3\n'\0003\v&\0:\v#\n:\n(\t3\n*\0003\v)\0:\v#\n:\n+\t2\n\0\0:\n,\t2\n\0\0:\n-\t2\n\0\0:\n.\t3\n4\0003\v2\0003\f0\0003\r/\0:\r1\f:\f3\v:\v5\n4\v6\0\16\f\t\0>\v\2\4D\14\24Ä4\0167\0\16\17\15\0>\16\2\2\a\0168\0T\16\3Ä\16\16\15\0>\16\1\2\16\15\16\0:\b9\0154\16\a\0007\16;\16%\17<\0007\18:\15\14\0\18\0T\19\1Ä2\18\0\0007\19:\0\16\20\n\0>\16\5\2:\16:\0156\16\14\0027\16=\16\16\17\15\0>\16\2\1B\14\3\3N\14Ê0\0\0ÄG\0\1\0\nsetup\tkeep\20tbl_deep_extend\17capabilities\14on_attach\rfunction\ttype\npairs\17textDocument\1\0\1\15codeAction\2\15completion\1\0\0\19completionItem\1\0\0\1\0\1\19snippetSupport\2\nvimls\rtsserver\18rust_analyzer\vjsonls\1\0\0\1\3\0\0\31vscode-json-languageserver\f--stdio\thtml\1\0\0\1\3\0\0\24html-languageserver\f--stdio\ncssls\1\0\0\bcmd\1\0\0\1\3\0\0\23css-languageserver\f--stdio\0\0\0\0\0\1\0\4\14underline\2\nsigns\2\17virtual_text\1\21update_in_insert\1\27on_publish_diagnostics\15diagnostic\twith$textDocument/publishDiagnostics\rhandlers\blsp\1\0\1\29use_saga_diagnostic_sign\1\18init_lsp_saga\22register_progress\1\0\3\ttext\bÔÅö\vtexthl\"LspDiagnosticsSignInformation\nnumhl\14WhiteSign\"LspDiagnosticsSignInformation\1\0\3\ttext\bÔÅ™\vtexthl\27LspDiagnosticsSignHint\nnumhl\rBlueSign\27LspDiagnosticsSignHint\1\0\3\ttext\bÔÅ±\vtexthl\30LspDiagnosticsSignWarning\nnumhl\15YellowSign\30LspDiagnosticsSignWarning\1\0\3\ttext\bÔÅó\vtexthl\28LspDiagnosticsSignError\nnumhl\fRedSign\28LspDiagnosticsSignError\16sign_define\afn\bvim\1\26\0\0\18 Ôíû  (Text) \19 Ôö¶  (Method)\21 Ôûî  (Function)\24 Ôê•  (Constructor)\18 Ô¥≤  (Field)\21[Óúñ] (Variable)\18 Ô†ñ  (Class)\22 Ô∞Æ  (Interface)\19 Ôô®  (Module)\20 Ô™∂ (Property)\17 Ôëµ  (Unit)\18 Ô¢ü  (Value)\16 Ô©ó (Enum)\20 Ô†ä  (Keyword)\20 ÔÉÑ  (Snippet)\18 Ô£ó  (Color)\17 Ôúì  (File)\22 Ôúú  (Reference)\19 Ôùä  (Folder)\23 ÔÖù  (EnumMember)\21 Ô≤Ä  (Constant)\19 Ô≥§  (Struct)\18 ÔÉß  (Event)\21 Ôó´  (Operator)\26 ÔûÉ  (TypeParameter)\23CompletionItemKind\flspsaga\14lspconfig\21vim.lsp.protocol\15lsp-status\frequire\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\1\2É\1\0\0\3\0\5\0\b4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0003\2\4\0>\0\3\1G\0\1\0\1\0\b\vhsl_fn\2\vrgb_fn\2\rRRGGBBAA\2\nnames\1\bcss\2\bRGB\2\vcss_fn\2\vRRGGBB\2\1\2\0\0\6*\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: ultisnips
time([[Config for ultisnips]], true)
try_loadstring("\27LJ\1\2J\0\0\3\0\5\0\a4\0\0\0007\0\1\0004\1\0\0007\1\2\1%\2\4\0:\2\3\1G\0\1\0\n<C-e>\27UltiSnipsExpandTrigger\6g\bcmd\bvim\0", "config", "ultisnips")
time([[Config for ultisnips]], false)
-- Config for: nord-vim
time([[Config for nord-vim]], true)
try_loadstring("\27LJ\1\2å\1\0\0\3\0\6\0\0154\0\0\0007\0\1\0\16\1\0\0%\2\2\0>\1\2\1\16\1\0\0%\2\3\0>\1\2\1\16\1\0\0%\2\4\0>\1\2\1\16\1\0\0%\2\5\0>\1\2\1G\0\1\0\21colorscheme nord\24set background=dark\22set termguicolors\14syntax on\bcmd\bvim\0", "config", "nord-vim")
time([[Config for nord-vim]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
