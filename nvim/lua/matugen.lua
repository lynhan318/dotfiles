 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#fffbef',
    base01 = '#f2efdb',
    base02 = '#ede8cc',
    base03 = '#8c9586',
    base04 = '#5c6a72',
    base05 = '#5c6a72',
    base06 = '#5c6a72',
    base07 = '#5c6a72',
    base08 = '#f85552',
    base09 = '#f57d26',
    base0A = '#3a94c5',
    base0B = '#8da101',
    base0C = '#924107',
    base0D = '#859801',
    base0E = '#1b5b7e',
    base0F = '#f4bebd',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#5c6a72',          bg = '#fffbef' })
  hi('TelescopeBorder',         { fg = '#8c9586',             bg = '#fffbef' })
  hi('TelescopePromptNormal',   { fg = '#5c6a72',          bg = '#fffbef' })
  hi('TelescopePromptBorder',   { fg = '#8c9586',             bg = '#fffbef' })
  hi('TelescopePromptPrefix',   { fg = '#8da101',             bg = '#fffbef' })
  hi('TelescopePromptCounter',  { fg = '#5c6a72',  bg = '#fffbef' })
  hi('TelescopePromptTitle',    { fg = '#fffbef',             bg = '#8da101' })
  hi('TelescopePreviewTitle',   { fg = '#fffbef',             bg = '#3a94c5' })
  hi('TelescopeResultsTitle',   { fg = '#fffbef',             bg = '#f57d26' })
  hi('TelescopeSelection',      { fg = '#5c6a72',          bg = '#ede8cc' })
  hi('TelescopeSelectionCaret', { fg = '#8da101',             bg = '#ede8cc' })
  hi('TelescopeMatching',       { fg = '#8da101',             bold = true })
end

 -- Register a signal handler for SIGUSR1 (matugen updates)
 local signal = vim.uv.new_signal()
 signal:start(
   'sigusr1',
   vim.schedule_wrap(function()
     package.loaded['matugen'] = nil
     require('matugen').setup()
   end)
 )

 return M
