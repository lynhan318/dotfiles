-- Tailwind CSS language server.
--
-- The server indexes every Tailwind config and CSS entry point it can find under
-- its root, so the root it gets handed decides what it costs. nvim-lspconfig
-- falls back to `.git` for Tailwind v4 projects (which need no tailwind.config),
-- and in a monorepo that points the server at the whole repository: one .ts
-- buffer in an unrelated package was enough to have it scanning every template
-- app in canvize and settle at a few hundred MB.
--
-- So: no `.git` fallback. A directory has to show evidence of Tailwind -- a
-- config file, or a package.json that depends on tailwindcss -- and the nearest
-- such directory wins. Buffers with no Tailwind anywhere above them get no
-- server at all.

local M = {}

local CONFIG_FILES = {
    "tailwind.config.js",
    "tailwind.config.cjs",
    "tailwind.config.mjs",
    "tailwind.config.ts",
    "postcss.config.js",
    "postcss.config.cjs",
    "postcss.config.mjs",
    "postcss.config.ts",
}

local DEPENDENCY_FIELDS = { "dependencies", "devDependencies", "peerDependencies", "optionalDependencies" }

-- Build output the server would otherwise index as if it were source. Most of it
-- is generated copies of files it already reads (.svelte-kit alone is ~90% of the
-- file count in a SvelteKit app), so excluding it cuts scanning and watching.
M.settings = {
    tailwindCSS = {
        files = {
            exclude = {
                "**/.git/**",
                "**/node_modules/**",
                "**/.hg/**",
                "**/.svn/**",
                "**/.svelte-kit/**",
                "**/.next/**",
                "**/.nuxt/**",
                "**/.output/**",
                "**/.turbo/**",
                "**/.vercel/**",
                "**/dist/**",
                "**/build/**",
                "**/out/**",
                "**/coverage/**",
                "**/target/**",
                "**/vendor/**",
            },
        },
    },
}

-- Class strings do turn up in plain .ts/.js (tailwind-variants, cva), but not
-- often enough to hand the server every TypeScript buffer in a Tailwind package.
local SKIP_FILETYPES = { typescript = true, javascript = true }

--- Upstream's filetype list minus the ones that are not markup.
--- @param defaults string[]|nil nvim-lspconfig's list, read before it is overridden
function M.filetypes(defaults)
    return vim.tbl_filter(function(ft)
        return not SKIP_FILETYPES[ft]
    end, defaults or {})
end

local function has_tailwind_dependency(package_json)
    local ok, contents = pcall(vim.fn.readfile, package_json)
    if not ok then
        return false
    end
    local decoded_ok, pkg = pcall(vim.json.decode, table.concat(contents, "\n"))
    if not decoded_ok or type(pkg) ~= "table" then
        return false
    end
    for _, field in ipairs(DEPENDENCY_FIELDS) do
        if type(pkg[field]) == "table" and pkg[field].tailwindcss then
            return true
        end
    end
    return false
end

local by_dir = {}

local function is_tailwind_root(dir)
    if by_dir[dir] == nil then
        local found = false
        for _, name in ipairs(CONFIG_FILES) do
            if vim.fn.filereadable(vim.fs.joinpath(dir, name)) == 1 then
                found = true
                break
            end
        end
        if not found then
            local package_json = vim.fs.joinpath(dir, "package.json")
            found = vim.fn.filereadable(package_json) == 1 and has_tailwind_dependency(package_json)
        end
        by_dir[dir] = found
    end
    return by_dir[dir]
end

--- Nearest directory above the buffer that actually uses Tailwind.
function M.root_dir(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    if fname == "" then
        return
    end
    for dir in vim.fs.parents(fname) do
        if is_tailwind_root(dir) then
            return on_dir(dir)
        end
    end
end

return M
