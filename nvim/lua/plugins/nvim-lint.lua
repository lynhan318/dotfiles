return {
    "mfussenegger/nvim-lint",
    event = {"BufReadPre", "BufNewFile"},
    config = function()
        vim.api.nvim_create_autocmd({"BufWritePost"}, {
            callback = function()
                -- try_lint without arguments runs the linters defined in `linters_by_ft`
                -- for the current filetype
                require("lint").linters_by_ft = {
                    javascript = {"biomejs"},
                    typescript = {"biomejs"},
                    typescriptreact = {"biomejs"},
                    javascriptreact = {"biomejs"},
                    css = {"biomejs"},
                    json = {"biomejs"}
                }
                require("lint").try_lint()
            end
        })
    end

    -- config = function(_, opts)
    --     local M = {}

    --     local lint = require("lint")
    --     lint.linters_by_ft = opts.linters_by_ft

    --     function M.debounce(ms, fn)
    --         local timer = vim.loop.new_timer()
    --         return function(...)
    --             local argv = {...}
    --             timer:start(ms, 0, function()
    --                 timer:stop()
    --                 vim.schedule_wrap(fn)(unpack(argv))
    --             end)
    --         end
    --     end

    --     -- As a rule of thumb, we want to use a bundle-specific version of Standard
    --     local standardrb = lint.linters.standardrb
    --     standardrb.cmd = "bin/standardrb"
    --     standardrb.args = {"--stdin", "%:p", "--format", "json", "--force-exclusion"}

    --     function M.lint()
    --         -- Use nvim-lint's logic first:
    --         -- * checks if linters exist for the full filetype first
    --         -- * otherwise will split filetype by "." and add all those linters
    --         -- * this differs from conform.nvim which only uses the first filetype that has a formatter
    --         local names = lint._resolve_linter_by_ft(vim.bo.filetype)

    --         -- Add fallback linters.
    --         if #names == 0 then
    --             vim.list_extend(names, lint.linters_by_ft["_"] or {})
    --         end

    --         -- Add global linters.
    --         vim.list_extend(names, lint.linters_by_ft["*"] or {})

    --         -- Filter out linters that don't exist or don't match the condition.
    --         local ctx = {
    --             filename = vim.api.nvim_buf_get_name(0)
    --         }
    --         ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
    --         names = vim.tbl_filter(function(name)
    --             local linter = lint.linters[name]
    --             return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
    --         end, names)

    --         -- Run linters.
    --         if #names > 0 then
    --             lint.try_lint(names)
    --         end
    --     end

    --     vim.api.nvim_create_autocmd(opts.events, {
    --         group = vim.api.nvim_create_augroup("nvim-lint", {
    --             clear = true
    --         }),
    --         callback = M.debounce(100, M.lint)
    --     })
    -- end
}
