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
  everforest = {
    config = { "\27LJ\1\2ø\1\0\0\3\0\t\0\0194\0\0\0007\0\1\0\16\1\0\0%\2\2\0>\1\2\0014\1\0\0007\1\3\1%\2\5\0:\2\4\1\16\1\0\0%\2\6\0>\1\2\1\16\1\0\0%\2\a\0>\1\2\1\16\1\0\0%\2\b\0>\1\2\1G\0\1\0\22set termguicolors\27colorscheme everforest\24set background=dark\tsoft\26everforest_background\6g\14syntax on\bcmd\bvim\0" },
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/everforest",
    url = "https://github.com/sainnhe/everforest"
  },
  ["formatter.nvim"] = {
    config = { "\27LJ\1\2Ä\1\0\0\4\0\6\1\n3\0\0\0003\1\1\0004\2\2\0007\2\3\0027\2\4\2'\3\0\0>\2\2\0<\2\0\0:\1\5\0H\0\2\0\targs\22nvim_buf_get_name\bapi\bvim\1\2\0\0\21--stdin-filepath\1\0\2\nstdin\2\bexe\rprettier\5ÄÄ¿ô\4D\0\0\2\0\3\0\0043\0\0\0003\1\1\0:\1\2\0H\0\2\0\targs\1\2\0\0\18--emit=stdout\1\0\2\nstdin\2\bexe\frustfmt(\0\0\1\0\1\0\0023\0\0\0H\0\2\0\1\0\2\bexe\15lua-format\nstdin\2œ\4\1\0\a\0\25\00064\0\0\0%\1\1\0>\0\2\0021\1\2\0004\2\3\0007\2\4\0027\2\5\2%\3\6\0)\4\2\0>\2\3\0017\2\a\0003\3\b\0003\4\t\0002\5\3\0;\1\1\5:\5\n\0042\5\3\0;\1\1\5:\5\v\0042\5\3\0;\1\1\5:\5\f\0042\5\3\0;\1\1\5:\5\r\0042\5\3\0;\1\1\5:\5\14\0042\5\3\0;\1\1\5:\5\15\0042\5\3\0;\1\1\5:\5\16\0042\5\3\0;\1\1\5:\5\17\0042\5\3\0;\1\1\5:\5\18\0042\5\3\0;\1\1\5:\5\19\0042\5\3\0001\6\20\0;\6\1\5:\5\21\0042\5\3\0001\6\22\0;\6\1\5:\5\23\4:\4\24\3>\2\2\1G\0\1\0\rfiletype\blua\0\trust\0\rmarkdown\tyaml\tscss\tjson\bcss\thtml\15javascript\15typescript\20typescriptreact\20javascriptreact\1\0\0\1\0\1\flogging\1\nsetupŒ\1        augroup FormatAutogroup\n          autocmd!\n          autocmd BufWritePost *.js,*.mjs,*.ts,*.rs,*.lua,*.jsx,*.tsx,*.md,*.mdx,*.yml,*.json,*.css,*.scss,*.html FormatWrite\n        augroup END\n    \14nvim_exec\bapi\bvim\0\14formatter\frequire\0" },
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/formatter.nvim",
    url = "https://github.com/mhartington/formatter.nvim"
  },
  ["lsp_extensions.nvim"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/lsp_extensions.nvim",
    url = "https://github.com/nvim-lua/lsp_extensions.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\1\2‹\1\0\0\4\0\f\0\0154\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\n\0003\2\3\0003\3\4\0:\3\5\0023\3\6\0:\3\a\0023\3\b\0:\3\t\2:\2\v\1>\0\2\1G\0\1\0\foptions\1\0\0\23disabled_filetypes\1\2\0\0\tdefx\25component_separators\1\0\2\tleft\5\nright\5\23section_separators\1\0\2\tleft\5\nright\5\1\0\1\ntheme\15everforest\nsetup\flualine\frequire\0" },
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\1\2:\0\1\3\0\4\0\0064\1\0\0007\1\1\0017\1\2\0017\2\3\0>\1\2\1G\0\1\0\tbody\19UltiSnips#Anon\afn\bvim}\0\2\4\1\5\0\n+\2\0\0007\3\0\0016\2\3\2:\2\0\0013\2\2\0007\3\3\0007\3\4\0036\2\3\2:\2\1\1H\1\2\0\1¿\tname\vsource\1\0\3\14ultisnips\14[Snippet]\rnvim_lsp\n[LSP]\vbuffer\r[Buffer]\tmenu\tkind¡\a\1\0\a\0\27\0*4\0\0\0%\1\1\0>\0\2\0023\1\2\0007\2\3\0003\3\b\0002\4\5\0003\5\4\0;\5\1\0043\5\5\0;\5\2\0043\5\6\0;\5\3\0043\5\a\0;\5\4\4:\4\t\0033\4\v\0001\5\n\0:\5\f\4:\4\r\0033\4\17\0007\5\14\0007\5\15\0053\6\16\0>\5\2\2:\5\18\0047\5\14\0007\5\19\5>\5\1\2:\5\20\0047\5\14\0007\5\21\5>\5\1\2:\5\22\4:\4\14\0033\4\24\0001\5\23\0:\5\25\4:\4\26\3>\2\2\0010\0\0ÄG\0\1\0\15formatting\vformat\1\0\0\0\n<tab>\21select_next_item\f<s-tab>\21select_prev_item\t<cr>\1\0\0\1\0\1\vselect\2\fconfirm\fmapping\fsnippet\vexpand\1\0\0\0\fsources\1\0\0\1\0\1\tname\14ultisnips\1\0\1\tname\vbuffer\1\0\1\tname\tpath\1\0\1\tname\rnvim_lsp\nsetup\1\0\24\tText\18 Ôíû  (Text) \rFunction\21 Ôûî  (Function)\rOperator\21 Ôó´  (Operator)\nColor\18 Ô£ó  (Color)\nClass\18 Ô†ñ  (Class)\vModule\19 Ôô®  (Module)\rConstant\21 Ô≤Ä  (Constant)\rProperty\20 Ô™∂ (Property)\vMethod\19 Ôö¶  (Method)\15EnumMember\23 ÔÖù  (EnumMember)\tUnit\17 Ôëµ  (Unit)\14Interface\22 Ô∞Æ  (Interface)\vStruct\19 Ô≥§  (Struct)\rVariable\21[Óúñ] (Variable)\nEvent\18 ÔÉß  (Event)\vFolder\19 Ôùä  (Folder)\nField\18 Ô¥≤  (Field)\18TypeParameter\26 ÔûÉ  (TypeParameter)\tFile\17 Ôúì  (File)\nValue\18 Ô¢ü  (Value)\16Constructor\24 Ôê•  (Constructor)\tEnum\16 Ô©ó (Enum)\fKeyword\20 Ô†ä  (Keyword)\14Reference\22 Ôúú  (Reference)\bcmp\frequire\0" },
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\1\2É\1\0\0\3\0\5\0\b4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0003\2\4\0>\0\3\1G\0\1\0\1\0\b\vhsl_fn\2\vrgb_fn\2\rRRGGBBAA\2\nnames\1\bcss\2\bRGB\2\vcss_fn\2\vRRGGBB\2\1\2\0\0\6*\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\1\2´\5\0\2\5\0\t\0\0197\2\0\0007\2\1\2\15\0\2\0T\3\6Ä4\2\2\0007\2\3\0027\2\4\2%\3\5\0)\4\1\0>\2\3\0017\2\0\0007\2\6\2\15\0\2\0T\3\4Ä4\2\2\0007\2\a\2%\3\b\0>\2\2\1G\0\1\0Bautocmd CursorHoldI <buffer> lua vim.lsp.buf.signature_help()\bcmd\19signature_helpœ\3          hi LspReferenceRead cterm=bold ctermbg=red guibg=#34495e\n          hi LspReferenceText cterm=bold ctermbg=red guibg=#34495e\n          hi LspReferenceWrite cterm=bold ctermbg=red guibg=#34495e\n          augroup lsp_document_highlight\n            autocmd! * <buffer>\n            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()\n            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()\n          augroup END\n        \14nvim_exec\bapi\bvim\23document_highlight\26resolved_capabilities‡\6\0\0\2\0\r\0-4\0\0\0007\0\1\0%\1\2\0>\0\2\0014\0\0\0007\0\1\0%\1\3\0>\0\2\0014\0\0\0007\0\1\0%\1\4\0>\0\2\0014\0\0\0007\0\1\0%\1\5\0>\0\2\0014\0\0\0007\0\1\0%\1\6\0>\0\2\0014\0\0\0007\0\1\0%\1\a\0>\0\2\0014\0\0\0007\0\1\0%\1\b\0>\0\2\0014\0\0\0007\0\1\0%\1\t\0>\0\2\0014\0\0\0007\0\1\0%\1\n\0>\0\2\0014\0\0\0007\0\1\0%\1\v\0>\0\2\0014\0\0\0007\0\1\0%\1\f\0>\0\2\1G\0\1\0Tcommand! -nargs=0 LspVirtualTextToggle lua require(\"lsp/virtual_text\").toggle()Annoremap <silent> g] <cmd>lua vim.diagnostic.goto_next()<CR>Annoremap <silent> g[ <cmd>lua vim.diagnostic.goto_prev()<CR>Bnnoremap <silent> gD <cmd>lua vim.diagnostic.open_float()<CR>@nnoremap <silent> ca <cmd>lua vim.lsp.buf.code_action()<CR>@nnoremap <silent> gi <cmd>Telescope lsp_implementations<CR>;nnoremap <silent> gr <cmd>Telescope lsp_references<CR>9nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>Cnnoremap <silent> gs <cmd>lua vim.lsp.buf.signature_help()<CR>;nnoremap <silent> rn <cmd>lua vim.lsp.buf.rename()<CR>?nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>\bcmd\bvim'\0\2\5\2\0\0\a+\2\0\0\16\3\0\0\16\4\1\0>\2\3\1+\2\1\0>\2\1\1G\0\1\0\5¿\6¿‚\n\1\0\17\0=\0v4\0\0\0%\1\1\0>\0\2\0024\1\0\0%\2\2\0>\1\2\0024\2\3\0007\2\4\0023\3\5\0003\4\6\0004\5\3\0007\5\a\0057\5\b\5%\6\t\0003\a\n\0>\5\3\0014\5\3\0007\5\a\0057\5\b\5%\6\v\0003\a\f\0>\5\3\0014\5\3\0007\5\a\0057\5\b\5%\6\r\0003\a\14\0>\5\3\0014\5\3\0007\5\a\0057\5\b\5%\6\15\0003\a\16\0>\5\3\0017\5\17\0027\6\19\0027\a\17\0027\a\20\a\16\b\4\0>\6\3\2:\6\18\0057\5\17\0027\6\19\0027\a\17\0027\a\22\a\16\b\4\0>\6\3\2:\6\21\0057\5\17\0027\6\19\0024\a\3\0007\a\4\a7\a\24\a7\a\25\a3\b\26\0>\6\3\2:\6\23\0051\5\27\0001\6\28\0001\a\29\0003\b!\0003\t\31\0003\n\30\0:\n \t:\t\"\b3\t$\0003\n#\0:\n \t:\t%\b3\t'\0003\n&\0:\n \t:\t(\b3\t.\0003\n,\0003\v*\0003\f)\0:\f+\v:\v-\n:\n/\t:\t0\b2\t\0\0:\t1\b2\t\0\0:\t2\b4\t3\0\16\n\b\0>\t\2\4D\f\25Ä4\0144\0\16\15\r\0>\14\2\2\a\0145\0T\14\3Ä\16\14\r\0>\14\1\2\16\r\14\0:\a6\r4\14\3\0007\14\4\0147\0147\0147\0148\14>\14\1\0024\15\0\0%\16:\0>\15\2\0027\15;\15\16\16\14\0>\15\2\2:\0159\r6\15\f\0017\15<\15\16\16\r\0>\15\2\1B\f\3\3N\fÂ0\0\0ÄG\0\1\0\nsetup\24update_capabilities\17cmp_nvim_lsp\17capabilities\29make_client_capabilities\rprotocol\14on_attach\rfunction\ttype\npairs\nvimls\rtsserver\18rust_analyzer\rsettings\1\0\0\18rust-analyzer\1\0\0\16checkOnSave\1\0\0\1\0\1\fcommand\vclippy\vjsonls\1\0\0\1\3\0\0\31vscode-json-languageserver\f--stdio\thtml\1\0\0\1\3\0\0\24html-languageserver\f--stdio\ncssls\1\0\0\bcmd\1\0\0\1\3\0\0\23css-languageserver\f--stdio\0\0\0\1\0\4\14underline\2\nsigns\2\17virtual_text\1\21update_in_insert\1\27on_publish_diagnostics\15diagnostic$textDocument/publishDiagnostics\nhover\23textDocument/hover\19signature_help\twith\31textDocument/signatureHelp\rhandlers\1\0\2\ttext\bÔ†¥\vtexthl\23DiagnosticSignHint\23DiagnosticSignHint\1\0\2\ttext\bÔÑ©\vtexthl\23DiagnosticSignInfo\30DiagnosticSignInformation\1\0\2\ttext\6!\vtexthl\23DiagnosticSignWarn\23DiagnosticSignWarn\1\0\2\ttext\b‚úó\vtexthl\24DiagnosticSignError\24DiagnosticSignError\16sign_define\afn\1\0\3\14focusable\1\nscope\tline\vborder\frounded\1\0\2\fnoremap\2\vsilent\2\blsp\bvim\14lspconfig\21vim.lsp.protocol\frequire\0" },
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
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
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\1\2¢\a\0\0\n\0,\0F4\0\0\0%\1\1\0>\0\2\0024\1\0\0%\2\2\0>\1\2\0024\2\0\0%\3\3\0>\2\2\0024\3\4\0007\3\5\3%\4\6\0>\3\2\0014\3\4\0007\3\5\3%\4\a\0>\3\2\0014\3\0\0%\4\b\0>\3\2\0027\3\t\0033\4\15\0003\5\v\0003\6\n\0:\6\f\0053\6\r\0:\6\14\5:\5\16\0043\5\17\0002\6\0\0:\6\18\0053\6\29\0003\a\20\0007\b\19\0:\b\21\a7\b\22\0:\b\23\a7\b\24\0:\b\25\a7\b\26\0007\t\22\0\30\b\t\b:\b\27\a7\b\26\0007\t\24\0\30\b\t\b:\b\28\a:\a\30\0063\a\31\0007\b\19\0:\b\21\a:\a \6:\6!\0053\6\"\0:\6#\5:\5$\0043\5&\0003\6%\0:\6'\0053\6(\0:\6)\5:\5*\4>\3\2\0014\3\0\0%\4\b\0>\3\2\0027\3+\3%\4'\0>\3\2\1G\0\1\0\19load_extension\15extensions\17file_browser\1\0\1\vhidden\2\bfzf\1\0\0\1\0\4\28override_generic_sorter\2\14case_mode\15smart_case\25override_file_sorter\2\nfuzzy\2\rdefaults\22vimgrep_arguments\1\t\0\0\arg\18--color=never\17--no-heading\20--with-filename\18--line-number\r--column\17--smart-case\r--hidden\rmappings\6n\1\0\0\6i\1\0\0\f<s-tab>\n<tab>\21toggle_selection\n<C-k>\28move_selection_previous\n<C-j>\24move_selection_next\n<esc>\1\0\0\nclose\18layout_config\1\0\0\fpickers\1\0\0\14live_grep\1\0\1\ntheme\bivy\15find_files\1\0\0\1\0\1\ntheme\bivy\nsetup\14telescope4nnoremap <Leader>l <cmd>Telescope live_grep<CR>5nnoremap <Leader>p <cmd>Telescope find_files<CR>\bcmd\bvim\20telescope.utils\28telescope.actions.state\22telescope.actions\frequire\0" },
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ultisnips = {
    config = { "\27LJ\1\2>\0\0\2\0\4\0\0054\0\0\0007\0\1\0%\1\3\0:\1\2\0G\0\1\0\n<C-o>\27UltiSnipsExpandTrigger\6g\bvim\0" },
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
  },
  ["vista.vim"] = {
    loaded = true,
    path = "/home/tiny/.local/share/nvim/site/pack/packer/start/vista.vim",
    url = "https://github.com/liuchengxu/vista.vim"
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
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\1\2:\0\1\3\0\4\0\0064\1\0\0007\1\1\0017\1\2\0017\2\3\0>\1\2\1G\0\1\0\tbody\19UltiSnips#Anon\afn\bvim}\0\2\4\1\5\0\n+\2\0\0007\3\0\0016\2\3\2:\2\0\0013\2\2\0007\3\3\0007\3\4\0036\2\3\2:\2\1\1H\1\2\0\1¿\tname\vsource\1\0\3\14ultisnips\14[Snippet]\rnvim_lsp\n[LSP]\vbuffer\r[Buffer]\tmenu\tkind¡\a\1\0\a\0\27\0*4\0\0\0%\1\1\0>\0\2\0023\1\2\0007\2\3\0003\3\b\0002\4\5\0003\5\4\0;\5\1\0043\5\5\0;\5\2\0043\5\6\0;\5\3\0043\5\a\0;\5\4\4:\4\t\0033\4\v\0001\5\n\0:\5\f\4:\4\r\0033\4\17\0007\5\14\0007\5\15\0053\6\16\0>\5\2\2:\5\18\0047\5\14\0007\5\19\5>\5\1\2:\5\20\0047\5\14\0007\5\21\5>\5\1\2:\5\22\4:\4\14\0033\4\24\0001\5\23\0:\5\25\4:\4\26\3>\2\2\0010\0\0ÄG\0\1\0\15formatting\vformat\1\0\0\0\n<tab>\21select_next_item\f<s-tab>\21select_prev_item\t<cr>\1\0\0\1\0\1\vselect\2\fconfirm\fmapping\fsnippet\vexpand\1\0\0\0\fsources\1\0\0\1\0\1\tname\14ultisnips\1\0\1\tname\vbuffer\1\0\1\tname\tpath\1\0\1\tname\rnvim_lsp\nsetup\1\0\24\tText\18 Ôíû  (Text) \rFunction\21 Ôûî  (Function)\rOperator\21 Ôó´  (Operator)\nColor\18 Ô£ó  (Color)\nClass\18 Ô†ñ  (Class)\vModule\19 Ôô®  (Module)\rConstant\21 Ô≤Ä  (Constant)\rProperty\20 Ô™∂ (Property)\vMethod\19 Ôö¶  (Method)\15EnumMember\23 ÔÖù  (EnumMember)\tUnit\17 Ôëµ  (Unit)\14Interface\22 Ô∞Æ  (Interface)\vStruct\19 Ô≥§  (Struct)\rVariable\21[Óúñ] (Variable)\nEvent\18 ÔÉß  (Event)\vFolder\19 Ôùä  (Folder)\nField\18 Ô¥≤  (Field)\18TypeParameter\26 ÔûÉ  (TypeParameter)\tFile\17 Ôúì  (File)\nValue\18 Ô¢ü  (Value)\16Constructor\24 Ôê•  (Constructor)\tEnum\16 Ô©ó (Enum)\fKeyword\20 Ô†ä  (Keyword)\14Reference\22 Ôúú  (Reference)\bcmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: nvim-web-devicons
time([[Config for nvim-web-devicons]], true)
try_loadstring("\27LJ\1\2ô\5\0\0\4\0\30\0!4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\28\0003\2\4\0003\3\3\0:\3\5\0023\3\6\0:\3\a\0023\3\b\0:\3\t\0023\3\n\0:\3\v\0023\3\f\0:\3\r\0023\3\14\0:\3\15\0023\3\16\0:\3\17\0023\3\18\0:\3\19\0023\3\20\0:\3\21\0023\3\22\0:\3\23\0023\3\24\0:\3\25\0023\3\26\0:\3\27\2:\2\29\1>\0\2\1G\0\1\0\roverride\1\0\0\tlock\1\0\3\ncolor\f#5c6370\ticon\bÔ†Ω\tname\tlock\bmp4\1\0\3\ncolor\f#5c6370\ticon\bÔÖÑ\tname\bmp4\bmp3\1\0\3\ncolor\f#566370\ticon\bÔ¢Ö\tname\bmp3\btxt\1\0\3\ncolor\f#61afef\ticon\bÔÖú\tname\ttext\bmap\1\0\3\ncolor\f#566370\ticon\bÓòî\tname\btxt\taxml\1\0\3\ncolor\f#f76c7c\ticon\bÔú≠\tname\taxml\ttxml\1\0\3\ncolor\f#f76c7c\ticon\bÔú≠\tname\ttxml\bxml\1\0\3\ncolor\f#f76c7c\ticon\bÔú≠\tname\bxml\tacss\1\0\3\ncolor\f#61afef\ticon\bÓùâ\tname\bcss\ttcss\1\0\3\ncolor\f#61afef\ticon\bÓùâ\tname\bcss\bcss\1\0\3\ncolor\f#61afef\ticon\bÓùâ\tname\bcss\thtml\1\0\0\1\0\3\ncolor\f#f76c7c\ticon\bÔÑª\tname\thtml\nsetup\22nvim-web-devicons\frequire\0", "config", "nvim-web-devicons")
time([[Config for nvim-web-devicons]], false)
-- Config for: nvim-transparent
time([[Config for nvim-transparent]], true)
try_loadstring("\27LJ\1\2m\0\0\3\0\6\0\v4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0002\2\0\0:\2\4\0012\2\0\0:\2\5\1>\0\2\1G\0\1\0\fexclude\17extra_groups\1\0\1\venable\2\nsetup\16transparent\frequire\0", "config", "nvim-transparent")
time([[Config for nvim-transparent]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\1\2‹\1\0\0\4\0\f\0\0154\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\n\0003\2\3\0003\3\4\0:\3\5\0023\3\6\0:\3\a\0023\3\b\0:\3\t\2:\2\v\1>\0\2\1G\0\1\0\foptions\1\0\0\23disabled_filetypes\1\2\0\0\tdefx\25component_separators\1\0\2\tleft\5\nright\5\23section_separators\1\0\2\tleft\5\nright\5\1\0\1\ntheme\15everforest\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\1\2´\5\0\2\5\0\t\0\0197\2\0\0007\2\1\2\15\0\2\0T\3\6Ä4\2\2\0007\2\3\0027\2\4\2%\3\5\0)\4\1\0>\2\3\0017\2\0\0007\2\6\2\15\0\2\0T\3\4Ä4\2\2\0007\2\a\2%\3\b\0>\2\2\1G\0\1\0Bautocmd CursorHoldI <buffer> lua vim.lsp.buf.signature_help()\bcmd\19signature_helpœ\3          hi LspReferenceRead cterm=bold ctermbg=red guibg=#34495e\n          hi LspReferenceText cterm=bold ctermbg=red guibg=#34495e\n          hi LspReferenceWrite cterm=bold ctermbg=red guibg=#34495e\n          augroup lsp_document_highlight\n            autocmd! * <buffer>\n            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()\n            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()\n          augroup END\n        \14nvim_exec\bapi\bvim\23document_highlight\26resolved_capabilities‡\6\0\0\2\0\r\0-4\0\0\0007\0\1\0%\1\2\0>\0\2\0014\0\0\0007\0\1\0%\1\3\0>\0\2\0014\0\0\0007\0\1\0%\1\4\0>\0\2\0014\0\0\0007\0\1\0%\1\5\0>\0\2\0014\0\0\0007\0\1\0%\1\6\0>\0\2\0014\0\0\0007\0\1\0%\1\a\0>\0\2\0014\0\0\0007\0\1\0%\1\b\0>\0\2\0014\0\0\0007\0\1\0%\1\t\0>\0\2\0014\0\0\0007\0\1\0%\1\n\0>\0\2\0014\0\0\0007\0\1\0%\1\v\0>\0\2\0014\0\0\0007\0\1\0%\1\f\0>\0\2\1G\0\1\0Tcommand! -nargs=0 LspVirtualTextToggle lua require(\"lsp/virtual_text\").toggle()Annoremap <silent> g] <cmd>lua vim.diagnostic.goto_next()<CR>Annoremap <silent> g[ <cmd>lua vim.diagnostic.goto_prev()<CR>Bnnoremap <silent> gD <cmd>lua vim.diagnostic.open_float()<CR>@nnoremap <silent> ca <cmd>lua vim.lsp.buf.code_action()<CR>@nnoremap <silent> gi <cmd>Telescope lsp_implementations<CR>;nnoremap <silent> gr <cmd>Telescope lsp_references<CR>9nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>Cnnoremap <silent> gs <cmd>lua vim.lsp.buf.signature_help()<CR>;nnoremap <silent> rn <cmd>lua vim.lsp.buf.rename()<CR>?nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>\bcmd\bvim'\0\2\5\2\0\0\a+\2\0\0\16\3\0\0\16\4\1\0>\2\3\1+\2\1\0>\2\1\1G\0\1\0\5¿\6¿‚\n\1\0\17\0=\0v4\0\0\0%\1\1\0>\0\2\0024\1\0\0%\2\2\0>\1\2\0024\2\3\0007\2\4\0023\3\5\0003\4\6\0004\5\3\0007\5\a\0057\5\b\5%\6\t\0003\a\n\0>\5\3\0014\5\3\0007\5\a\0057\5\b\5%\6\v\0003\a\f\0>\5\3\0014\5\3\0007\5\a\0057\5\b\5%\6\r\0003\a\14\0>\5\3\0014\5\3\0007\5\a\0057\5\b\5%\6\15\0003\a\16\0>\5\3\0017\5\17\0027\6\19\0027\a\17\0027\a\20\a\16\b\4\0>\6\3\2:\6\18\0057\5\17\0027\6\19\0027\a\17\0027\a\22\a\16\b\4\0>\6\3\2:\6\21\0057\5\17\0027\6\19\0024\a\3\0007\a\4\a7\a\24\a7\a\25\a3\b\26\0>\6\3\2:\6\23\0051\5\27\0001\6\28\0001\a\29\0003\b!\0003\t\31\0003\n\30\0:\n \t:\t\"\b3\t$\0003\n#\0:\n \t:\t%\b3\t'\0003\n&\0:\n \t:\t(\b3\t.\0003\n,\0003\v*\0003\f)\0:\f+\v:\v-\n:\n/\t:\t0\b2\t\0\0:\t1\b2\t\0\0:\t2\b4\t3\0\16\n\b\0>\t\2\4D\f\25Ä4\0144\0\16\15\r\0>\14\2\2\a\0145\0T\14\3Ä\16\14\r\0>\14\1\2\16\r\14\0:\a6\r4\14\3\0007\14\4\0147\0147\0147\0148\14>\14\1\0024\15\0\0%\16:\0>\15\2\0027\15;\15\16\16\14\0>\15\2\2:\0159\r6\15\f\0017\15<\15\16\16\r\0>\15\2\1B\f\3\3N\fÂ0\0\0ÄG\0\1\0\nsetup\24update_capabilities\17cmp_nvim_lsp\17capabilities\29make_client_capabilities\rprotocol\14on_attach\rfunction\ttype\npairs\nvimls\rtsserver\18rust_analyzer\rsettings\1\0\0\18rust-analyzer\1\0\0\16checkOnSave\1\0\0\1\0\1\fcommand\vclippy\vjsonls\1\0\0\1\3\0\0\31vscode-json-languageserver\f--stdio\thtml\1\0\0\1\3\0\0\24html-languageserver\f--stdio\ncssls\1\0\0\bcmd\1\0\0\1\3\0\0\23css-languageserver\f--stdio\0\0\0\1\0\4\14underline\2\nsigns\2\17virtual_text\1\21update_in_insert\1\27on_publish_diagnostics\15diagnostic$textDocument/publishDiagnostics\nhover\23textDocument/hover\19signature_help\twith\31textDocument/signatureHelp\rhandlers\1\0\2\ttext\bÔ†¥\vtexthl\23DiagnosticSignHint\23DiagnosticSignHint\1\0\2\ttext\bÔÑ©\vtexthl\23DiagnosticSignInfo\30DiagnosticSignInformation\1\0\2\ttext\6!\vtexthl\23DiagnosticSignWarn\23DiagnosticSignWarn\1\0\2\ttext\b‚úó\vtexthl\24DiagnosticSignError\24DiagnosticSignError\16sign_define\afn\1\0\3\14focusable\1\nscope\tline\vborder\frounded\1\0\2\fnoremap\2\vsilent\2\blsp\bvim\14lspconfig\21vim.lsp.protocol\frequire\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: everforest
time([[Config for everforest]], true)
try_loadstring("\27LJ\1\2ø\1\0\0\3\0\t\0\0194\0\0\0007\0\1\0\16\1\0\0%\2\2\0>\1\2\0014\1\0\0007\1\3\1%\2\5\0:\2\4\1\16\1\0\0%\2\6\0>\1\2\1\16\1\0\0%\2\a\0>\1\2\1\16\1\0\0%\2\b\0>\1\2\1G\0\1\0\22set termguicolors\27colorscheme everforest\24set background=dark\tsoft\26everforest_background\6g\14syntax on\bcmd\bvim\0", "config", "everforest")
time([[Config for everforest]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\1\2¢\a\0\0\n\0,\0F4\0\0\0%\1\1\0>\0\2\0024\1\0\0%\2\2\0>\1\2\0024\2\0\0%\3\3\0>\2\2\0024\3\4\0007\3\5\3%\4\6\0>\3\2\0014\3\4\0007\3\5\3%\4\a\0>\3\2\0014\3\0\0%\4\b\0>\3\2\0027\3\t\0033\4\15\0003\5\v\0003\6\n\0:\6\f\0053\6\r\0:\6\14\5:\5\16\0043\5\17\0002\6\0\0:\6\18\0053\6\29\0003\a\20\0007\b\19\0:\b\21\a7\b\22\0:\b\23\a7\b\24\0:\b\25\a7\b\26\0007\t\22\0\30\b\t\b:\b\27\a7\b\26\0007\t\24\0\30\b\t\b:\b\28\a:\a\30\0063\a\31\0007\b\19\0:\b\21\a:\a \6:\6!\0053\6\"\0:\6#\5:\5$\0043\5&\0003\6%\0:\6'\0053\6(\0:\6)\5:\5*\4>\3\2\0014\3\0\0%\4\b\0>\3\2\0027\3+\3%\4'\0>\3\2\1G\0\1\0\19load_extension\15extensions\17file_browser\1\0\1\vhidden\2\bfzf\1\0\0\1\0\4\28override_generic_sorter\2\14case_mode\15smart_case\25override_file_sorter\2\nfuzzy\2\rdefaults\22vimgrep_arguments\1\t\0\0\arg\18--color=never\17--no-heading\20--with-filename\18--line-number\r--column\17--smart-case\r--hidden\rmappings\6n\1\0\0\6i\1\0\0\f<s-tab>\n<tab>\21toggle_selection\n<C-k>\28move_selection_previous\n<C-j>\24move_selection_next\n<esc>\1\0\0\nclose\18layout_config\1\0\0\fpickers\1\0\0\14live_grep\1\0\1\ntheme\bivy\15find_files\1\0\0\1\0\1\ntheme\bivy\nsetup\14telescope4nnoremap <Leader>l <cmd>Telescope live_grep<CR>5nnoremap <Leader>p <cmd>Telescope find_files<CR>\bcmd\bvim\20telescope.utils\28telescope.actions.state\22telescope.actions\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: ultisnips
time([[Config for ultisnips]], true)
try_loadstring("\27LJ\1\2>\0\0\2\0\4\0\0054\0\0\0007\0\1\0%\1\3\0:\1\2\0G\0\1\0\n<C-o>\27UltiSnipsExpandTrigger\6g\bvim\0", "config", "ultisnips")
time([[Config for ultisnips]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\1\2É\1\0\0\3\0\5\0\b4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0003\2\4\0>\0\3\1G\0\1\0\1\0\b\vhsl_fn\2\vrgb_fn\2\rRRGGBBAA\2\nnames\1\bcss\2\bRGB\2\vcss_fn\2\vRRGGBB\2\1\2\0\0\6*\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
