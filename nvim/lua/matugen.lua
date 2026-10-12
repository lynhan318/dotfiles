 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#2d353b',
    base01 = '#3d484d',
    base02 = '#465358',
    base03 = '#7a8478',
    base04 = '#d3c6aa',
    base05 = '#d3c6aa',
    base06 = '#d3c6aa',
    base07 = '#d3c6aa',
    base08 = '#e67e80',
    base09 = '#e69875',
    base0A = '#7fbbb3',
    base0B = '#a7c080',
    base0C = '#ebae93',
    base0D = '#c8e996',
    base0E = '#96e9de',
    base0F = '#bef4ec',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#d3c6aa',          bg = '#2d353b' })
  hi('TelescopeBorder',         { fg = '#7a8478',             bg = '#2d353b' })
  hi('TelescopePromptNormal',   { fg = '#d3c6aa',          bg = '#2d353b' })
  hi('TelescopePromptBorder',   { fg = '#7a8478',             bg = '#2d353b' })
  hi('TelescopePromptPrefix',   { fg = '#a7c080',             bg = '#2d353b' })
  hi('TelescopePromptCounter',  { fg = '#d3c6aa',  bg = '#2d353b' })
  hi('TelescopePromptTitle',    { fg = '#2d353b',             bg = '#a7c080' })
  hi('TelescopePreviewTitle',   { fg = '#2d353b',             bg = '#7fbbb3' })
  hi('TelescopeResultsTitle',   { fg = '#2d353b',             bg = '#e69875' })
  hi('TelescopeSelection',      { fg = '#d3c6aa',          bg = '#465358' })
  hi('TelescopeSelectionCaret', { fg = '#a7c080',             bg = '#465358' })
  hi('TelescopeMatching',       { fg = '#a7c080',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#d3c6aa',          bg = '#2d353b' })
  hi('MiniPickBorder',         { fg = '#7a8478',             bg = '#2d353b' })
  hi('MiniPickPrompt',   { fg = '#d3c6aa',          bg = '#2d353b' })
  hi('MiniPickPromptPrefix',   { fg = '#a7c080',             bg = '#2d353b' })
  hi('MiniPickBorderText',    { fg = '#2d353b',             bg = '#a7c080' })
  hi('MiniPickMatchCurrent',      { fg = '#d3c6aa',          bg = '#465358' })
  hi('MiniPickPromptCaret', { fg = '#a7c080',             bg = '#465358' })
  hi('MiniPickMatchRanges',       { fg = '#a7c080',             bold = true })
end

-- Register a signal handler for SIGUSR1 (matugen updates).
-- The handler re-requires this module, which re-runs the code below, so the
-- previous handle is stopped first; otherwise handlers double on every signal.
if _G.__matugen_signal then
  _G.__matugen_signal:stop()
  _G.__matugen_signal:close()
end

local signal = vim.uv.new_signal()
_G.__matugen_signal = signal
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
)

return M
