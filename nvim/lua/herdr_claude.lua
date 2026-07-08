-- Send the visual selection's location (path#Lstart-end) to a Claude agent
-- running in the same herdr tab, via the herdr socket CLI.
local M = {}

local function herdr(args)
    local res = vim.system(vim.list_extend({ "herdr" }, args), { text = true }):wait()
    if res.code ~= 0 then
        local err = (res.stderr and res.stderr ~= "") and res.stderr or res.stdout
        return nil, vim.trim(err or "herdr exited with code " .. res.code)
    end
    local ok, decoded = pcall(vim.json.decode, res.stdout)
    return ok and decoded or {}
end

-- Live line range: "v"/"." track the active selection, unlike '< '> marks
-- which only update after leaving visual mode.
local function selection_range()
    if vim.fn.mode():find "^[vV\22]" then
        local a, b = vim.fn.line "v", vim.fn.line "."
        if a > b then a, b = b, a end
        return a, b
    end
    local a, b = vim.fn.line "'<", vim.fn.line "'>"
    if a == 0 or b == 0 then
        return nil
    end
    if a > b then a, b = b, a end
    return a, b
end

-- Panes can be moved between tabs, so ask the server rather than trusting
-- the HERDR_TAB_ID env var set at pane creation.
local function current_tab_id()
    local pane_id = vim.env.HERDR_PANE_ID
    if pane_id and pane_id ~= "" then
        local res = herdr { "pane", "get", pane_id }
        local tab_id = res and res.result and res.result.pane and res.result.pane.tab_id
        if tab_id then
            return tab_id
        end
    end
    return vim.env.HERDR_TAB_ID
end

local function claude_agents_in_tab(tab_id)
    local res, err = herdr { "agent", "list" }
    if not res then
        return nil, err
    end
    local agents = {}
    for _, a in ipairs(res.result and res.result.agents or {}) do
        if a.tab_id == tab_id
            and a.pane_id ~= vim.env.HERDR_PANE_ID
            and (a.agent or ""):find("claude", 1, true)
        then
            table.insert(agents, a)
        end
    end
    return agents
end

-- Prefer a path the agent can resolve from its own cwd.
local function path_for(agent)
    local abs = vim.api.nvim_buf_get_name(0)
    local cwd = agent.cwd or agent.foreground_cwd
    if cwd and cwd ~= "" then
        local rel = vim.fs.relpath(cwd, abs)
        if rel then
            return rel
        end
    end
    return vim.fn.fnamemodify(abs, ":~")
end

local function send_to_agent(agent, start_line, end_line)
    local target = agent.terminal_id or agent.pane_id
    local message = string.format("%s#L%d-%d", path_for(agent), start_line, end_line)
    local _, err = herdr { "agent", "send", target, message }
    if err then
        vim.notify("[herdr-claude] send failed: " .. err, vim.log.levels.ERROR)
        return
    end
    herdr { "agent", "focus", target }
end

function M.send_selection()
    local start_line, end_line = selection_range()
    if not start_line then
        vim.notify("[herdr-claude] no selection", vim.log.levels.WARN)
        return
    end
    if vim.api.nvim_buf_get_name(0) == "" then
        vim.notify("[herdr-claude] unnamed buffer has no location to send", vim.log.levels.WARN)
        return
    end

    local tab_id = current_tab_id()
    if not tab_id or tab_id == "" then
        vim.notify("[herdr-claude] not inside a herdr session", vim.log.levels.WARN)
        return
    end

    local agents, err = claude_agents_in_tab(tab_id)
    if not agents then
        vim.notify("[herdr-claude] " .. err, vim.log.levels.ERROR)
        return
    end
    if #agents == 0 then
        vim.notify("[herdr-claude] no Claude agent in current herdr tab", vim.log.levels.WARN)
        return
    end

    -- Range is captured; drop back to normal mode before focus moves away.
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)

    if #agents == 1 then
        send_to_agent(agents[1], start_line, end_line)
        return
    end

    vim.ui.select(agents, {
        prompt = "Send to Claude agent:",
        format_item = function(a)
            return string.format(
                "%-8s %s  [%s]",
                a.agent,
                vim.fn.fnamemodify(a.cwd or "", ":~"),
                a.agent_status or "unknown"
            )
        end,
    }, function(agent)
        if agent then
            send_to_agent(agent, start_line, end_line)
        end
    end)
end

return M
