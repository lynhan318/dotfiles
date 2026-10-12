return {
    -- Core Debugging Client
    {
        "mfussenegger/nvim-dap",
        -- Lazy-load on first debug keypress; the real keymaps are (re)defined in
        -- `config` once the plugin loads, and lazy.nvim replays the triggering key.
        keys = {
            "<F5>", "<F10>", "<F11>", "<F12>",
            "<leader>db", "<leader>dB", "<leader>dr", "<leader>dl",
        },
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

            -- Zig / native: `lldb-dap` (pacman package `lldb`) when present,
            -- otherwise codelldb installed by Mason (`:MasonInstall codelldb`),
            -- which bundles its own LLDB and needs no root.
            local lldb_dap = vim.fn.exepath('lldb-dap')
            local codelldb = vim.fn.stdpath('data') .. '/mason/bin/codelldb'
            dap.adapters.lldb = {
                type = 'executable',
                command = lldb_dap,
                name = 'lldb',
            }
            dap.adapters.codelldb = {
                type = 'server',
                port = '${port}',
                executable = { command = codelldb, args = { '--port', '${port}' } },
            }
            local zig_adapter = lldb_dap ~= '' and 'lldb' or 'codelldb'

            local function zig_root()
                return vim.fs.root(0, { 'build.zig' }) or vim.fn.getcwd()
            end

            -- `zig build` (Debug by default, so debug info is present) and then
            -- the freshly installed binary under zig-out/bin; ask when the
            -- project installs several.
            local function zig_program()
                local root = zig_root()
                local res = vim.system({ 'zig', 'build' }, { cwd = root }):wait()
                if res.code ~= 0 then
                    vim.notify('zig build failed:\n' .. (res.stderr or ''), vim.log.levels.ERROR)
                    return dap.ABORT
                end
                local bins = vim.tbl_filter(function(path)
                    return vim.fn.executable(path) == 1
                end, vim.fn.glob(root .. '/zig-out/bin/*', true, true))
                if #bins == 1 then return bins[1] end
                return vim.fn.input('Executable: ', root .. '/zig-out/bin/', 'file')
            end

            local function zig_args()
                return vim.split(vim.fn.input('Args: '), ' ', { trimempty = true })
            end

            dap.configurations.zig = {
                {
                    type = zig_adapter,
                    request = 'launch',
                    name = 'Zig: zig build, then debug zig-out/bin/<exe>',
                    program = zig_program,
                    args = zig_args,
                    cwd = zig_root,
                    stopOnEntry = false,
                },
                {
                    type = zig_adapter,
                    request = 'launch',
                    name = 'Zig: debug an existing executable',
                    program = function()
                        return vim.fn.input('Executable: ', zig_root() .. '/zig-out/bin/', 'file')
                    end,
                    args = zig_args,
                    cwd = zig_root,
                    stopOnEntry = false,
                },
            }

            -- Rust: always codelldb, even when lldb-dap exists — it bundles
            -- Rust formatters, so String/Vec render as values instead of raw
            -- (ptr, cap, len) handles.
            local function cargo_root()
                return vim.fs.root(0, { 'Cargo.toml' }) or vim.fn.getcwd()
            end

            -- `cargo build --message-format=json` names each produced binary in
            -- the `executable` field of its compiler-artifact messages (test
            -- binaries too, under --tests). Globbing target/debug/ instead
            -- would surface build scripts and stale hashes in deps/.
            local function cargo_program(build_args)
                return function()
                    local root = cargo_root()
                    local cmd = { 'cargo', 'build', '--message-format=json' }
                    vim.list_extend(cmd, build_args)
                    local res = vim.system(cmd, { cwd = root }):wait()
                    if res.code ~= 0 then
                        vim.notify('cargo build failed:\n' .. (res.stderr or ''), vim.log.levels.ERROR)
                        return dap.ABORT
                    end
                    local bins = {}
                    for line in vim.gsplit(res.stdout or '', '\n', { trimempty = true }) do
                        local ok, msg = pcall(vim.json.decode, line)
                        if ok and msg.reason == 'compiler-artifact' and type(msg.executable) == 'string' then
                            table.insert(bins, msg.executable)
                        end
                    end
                    if #bins == 0 then
                        vim.notify('cargo build produced no executable (library-only crate? try the --tests config)',
                            vim.log.levels.ERROR)
                        return dap.ABORT
                    end
                    if #bins == 1 then return bins[1] end
                    local choices = { 'Executable:' }
                    for i, bin in ipairs(bins) do
                        table.insert(choices, string.format('%d: %s', i, vim.fn.fnamemodify(bin, ':t')))
                    end
                    local idx = vim.fn.inputlist(choices)
                    if idx < 1 or idx > #bins then return dap.ABORT end
                    return bins[idx]
                end
            end

            local function rust_args()
                return vim.split(vim.fn.input('Args: '), ' ', { trimempty = true })
            end

            dap.configurations.rust = {
                {
                    type = 'codelldb',
                    request = 'launch',
                    name = 'Rust: cargo build, then debug the binary',
                    program = cargo_program {},
                    args = rust_args,
                    cwd = cargo_root,
                    stopOnEntry = false,
                },
                {
                    -- The test binary accepts a name filter as its argument, so
                    -- answering the Args prompt with e.g. `bai02` stops only in
                    -- those tests.
                    type = 'codelldb',
                    request = 'launch',
                    name = 'Rust: cargo build --tests, then debug a test binary',
                    program = cargo_program { '--tests' },
                    args = rust_args,
                    cwd = cargo_root,
                    stopOnEntry = false,
                },
            }
        end
    }
}
