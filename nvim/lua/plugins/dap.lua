return {
    -- Core Debugging Client
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            -- Fancy UI for debugging
            { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
            -- Automatic installation of debug adapters via Mason
            "williamboman/mason.nvim",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            dapui.setup()

            -- Automatically open/close DAP UI when sessions start/end
            dap.listeners.before.attach.dapui_config = function() dapui.open() end
            dap.listeners.before.launch.dapui_config = function() dapui.open() end
            dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
            dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

            vim.keymap.set('n', '<F5>', function() dap.continue() end, { desc = 'Debug: Start/Continue' })

            -- Press F10 to step over the current line of code
            vim.keymap.set('n', '<F10>', function() dap.step_over() end, { desc = 'Debug: Step Over' })

            -- Press F11 to step into a function call
            vim.keymap.set('n', '<F11>', function() dap.step_into() end, { desc = 'Debug: Step Into' })

            -- Press F12 to step out of the current function
            vim.keymap.set('n', '<F12>', function() dap.step_out() end, { desc = 'Debug: Step Out' })

            -- Press <leader>b to toggle a breakpoint on the current line
            vim.keymap.set('n', '<leader>db', function() dap.toggle_breakpoint() end,
                { desc = 'Debug: Toggle Breakpoint' })

            -- Press <leader>B to set a conditional breakpoint
            vim.keymap.set('n', '<leader>dB', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
                { desc = 'Debug: Set Breakpoint' })

            -- Press <leader>dt to open a REPL / <leader>dl to run last config
            vim.keymap.set('n', '<leader>dr', function() dap.repl.toggle() end, { desc = 'Debug: Toggle REPL' })
            vim.keymap.set('n', '<leader>dl', function() dap.run_last() end, { desc = 'Debug: Run Last' })

            local bun_cmd = vim.fn.exepath('bun')
            if bun_cmd == '' then bun_cmd = vim.fn.expand('~/.bun/bin/bun') end
            local bun_adapter = vim.fn.stdpath('config') .. '/dap/bun/adapter.ts'

            dap.adapters.bun = {
                type = 'executable',
                command = bun_cmd,
                args = { bun_adapter },
            }

            local bun_configs = {
                {
                    type = 'bun',
                    request = 'launch',
                    name = 'Bun: launch current file',
                    program = '${file}',
                    cwd = '${workspaceFolder}',
                    runtime = bun_cmd,
                    stopOnEntry = false,
                    watchMode = false,
                },
                {
                    type = 'bun',
                    request = 'attach',
                    name = 'Bun: attach (ws://localhost:6499/dap)',
                    -- Must match the URL your running process advertises, e.g. the api
                    -- `dev:debug` script: `bun --inspect=localhost:6499/dap src/app.ts`.
                    url = 'ws://localhost:6499/dap',
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                },
            }
            for _, ft in ipairs({ 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' }) do
                dap.configurations[ft] = bun_configs
            end
        end
    }
}
