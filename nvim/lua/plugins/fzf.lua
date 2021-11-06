return function()
    require('lspfuzzy').setup {
        methods = 'all', -- either 'all' or a list of LSP methods (see below)
        fzf_preview = { -- arguments to the FZF '--preview-window' option
            'right:+{2}-/2' -- preview on the right and centered on entry
        },
        fzf_action = { -- FZF actions
            ['ctrl-t'] = 'tabedit', -- go to location in a new tab
            ['ctrl-v'] = 'vsplit', -- go to location in a vertical split
            ['ctrl-x'] = 'split' -- go to location in a horizontal split
        },
        fzf_modifier = ':~:.', -- format FZF entries, see |filename-modifiers|
        fzf_trim = true
    }
end
