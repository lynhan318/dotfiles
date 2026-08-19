-- TypeScript 7 language server.
--
-- TS 7 is the Go compiler, and the binary it ships is also the language server:
-- `tsc --lsp --stdio`. Nothing else is involved -- no typescript-language-server,
-- no Node tsserver, no @typescript/native-preview.
--
-- Resolution order, per project root:
--   1. node_modules/typescript >= 7
--   2. tsc on $PATH, if it is >= 7
--
-- Projects pinned to TypeScript 5 or 6 still have a `tsc` in node_modules, but
-- that one is the old JS compiler and does not understand --lsp, so the local
-- candidate is version-gated and those projects fall through to the global
-- binary.
--
-- Where the platform package is visible we run its executable directly
-- (@typescript/typescript-<os>-<arch>/lib/tsc) rather than the `bin/tsc` Node
-- shim, which saves a Node startup per server launch.

local M = {}

local uv = vim.uv

-- node-style platform-arch pair, as used to name the @typescript/* packages
local function platform()
    local sys = uv.os_uname()
    local os_name = ({ Linux = "linux", Darwin = "darwin", Windows_NT = "win32" })[sys.sysname]
        or sys.sysname:lower()
    local arch = ({ x86_64 = "x64", aarch64 = "arm64", arm64 = "arm64" })[sys.machine] or sys.machine
    return os_name .. "-" .. arch
end

local function read_json(path)
    if vim.fn.filereadable(path) ~= 1 then
        return nil
    end
    local ok, decoded = pcall(vim.json.decode, table.concat(vim.fn.readfile(path), "\n"))
    return ok and decoded or nil
end

local function major(version)
    return tonumber(tostring(version or ""):match "^(%d+)") or 0
end

--- Command for an installed `typescript` package, or nil if it predates TS 7.
--- @param pkg_dir string path of the `typescript` package
local function cmd_for(pkg_dir)
    local pkg = read_json(vim.fs.joinpath(pkg_dir, "package.json"))
    if not pkg or major(pkg.version) < 7 then
        return nil
    end
    local native = vim.fs.normalize(
        vim.fs.joinpath(pkg_dir, "..", "@typescript", "typescript-" .. platform(), "lib", "tsc")
    )
    local exe = vim.fn.executable(native) == 1 and native or vim.fs.joinpath(pkg_dir, "bin", "tsc")
    return { exe, "--lsp", "--stdio" }
end

-- nil = not probed yet, false = nothing usable on $PATH
local global_cmd = nil

local function resolve_global()
    if global_cmd == nil then
        global_cmd = false
        local tsc = vim.fn.exepath "tsc"
        if tsc ~= "" then
            -- Follow the shim: <prefix>/node_modules/typescript/bin/tsc
            local real = uv.fs_realpath(tsc) or tsc
            local pkg_dir = vim.fs.dirname(vim.fs.dirname(real))
            if vim.fn.filereadable(vim.fs.joinpath(pkg_dir, "package.json")) == 1 then
                global_cmd = cmd_for(pkg_dir) or false
            else
                -- Unrecognised layout (version manager shim, distro package): ask it.
                local out = vim.system({ tsc, "-v" }, { text = true }):wait(2000)
                if out.code == 0 and major((out.stdout or ""):match "%d[%d%.]*") >= 7 then
                    global_cmd = { tsc, "--lsp", "--stdio" }
                end
            end
        end
    end
    return global_cmd or nil
end

local by_root = {}

--- Command that serves `root`, or nil when no TypeScript 7 binary is reachable.
--- @param root string|nil
--- @return string[]|nil
function M.resolve(root)
    if root == nil then
        return resolve_global()
    end
    if by_root[root] == nil then
        by_root[root] = cmd_for(vim.fs.joinpath(root, "node_modules", "typescript")) or resolve_global() or false
    end
    return by_root[root] or nil
end

local warned = false

--- Said once per session, when nothing on the box can serve TypeScript.
function M.warn_missing()
    if warned then
        return
    end
    warned = true
    vim.notify(
        "No TypeScript 7 language server found. Install one with `bun add -g typescript@latest`.",
        vim.log.levels.WARN
    )
end

--- @type fun(dispatchers: vim.lsp.rpc.Dispatchers, config: vim.lsp.ClientConfig): vim.lsp.rpc.PublicClient
function M.cmd(dispatchers, config)
    local argv = assert(M.resolve((config or {}).root_dir), "no TypeScript 7 language server on this system")
    return vim.lsp.rpc.start(argv, dispatchers)
end

--- One server per package-manager root: TS 7 handles monorepos itself, picking
--- the right tsconfig per file, so splitting per workspace only wastes memory.
--- Buffers whose root has no reachable server are left unattached.
function M.root_dir(bufnr, on_dir)
    local dir = vim.fs.root(bufnr, {
        { "package-lock.json", "bun.lock", "bun.lockb", "pnpm-lock.yaml", "yarn.lock" },
        { "tsconfig.json", "jsconfig.json", "package.json" },
        { ".git" },
    })
    if not dir then
        return
    end
    if M.resolve(dir) then
        on_dir(dir)
    else
        M.warn_missing()
    end
end

return M
