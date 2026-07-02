local M = {}

local function get_visual_selection()
    local s = vim.fn.getpos "'<"
    local e = vim.fn.getpos "'>"
    local start_row, start_col = s[2], s[3]
    local end_row, end_col = e[2], e[3]
    local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)

    if #lines == 0 then
        return nil
    end

    local mode = vim.fn.visualmode()
    if mode == "v" then
        if #lines == 1 then
            lines[1] = lines[1]:sub(start_col, end_col)
        else
            lines[1] = lines[1]:sub(start_col)
            lines[#lines] = lines[#lines]:sub(1, end_col)
        end
    end
    -- "V" (linewise) and "\22" (block) take full lines as-is

    return {
        text = table.concat(lines, "\n"),
        start_line = start_row,
        end_line = end_row,
        filetype = vim.bo.filetype,
        filepath = vim.fn.expand "%:~:.",
    }
end

local function is_claude_process(cmd, pid)
    if cmd:find "claude" then
        return true
    end
    -- Claude Code installed via npm runs as "node"; check cmdline via /proc
    if cmd == "node" and pid and pid ~= "" then
        local cmdline = vim.fn.system("cat /proc/" .. pid .. "/cmdline 2>/dev/null | tr '\\0' ' '")
        if cmdline:find "claude" then
            return true
        end
    end
    return false
end

local function current_tmux_window()
    if vim.env.TMUX == nil or vim.env.TMUX == "" then
        return nil, nil
    end
    local out = vim.fn.system "tmux display-message -p '#{session_name}|#{window_index}'"
    local session, win_idx = out:match "^([^|]*)|([^|\n]*)"
    if not session or session == "" then
        return nil, nil
    end
    return session, win_idx
end

local function find_claude_panes()
    local cur_session, cur_win = current_tmux_window()
    local scope = cur_session and "" or "-a "
    local raw = vim.fn.systemlist(
        "tmux list-panes " .. scope .. "-F '#{session_name}|#{window_index}|#{pane_index}|#{pane_id}|#{pane_current_command}|#{window_name}|#{pane_title}|#{pane_pid}'"
    )

    local panes = {}
    for _, line in ipairs(raw) do
        local session, win_idx, pane_idx, pane_id, cmd, win_name, pane_title, pid =
            line:match "^([^|]*)|([^|]*)|([^|]*)|([^|]*)|([^|]*)|([^|]*)|([^|]*)|([^|]*)$"
        local in_current_window = cur_session == nil
            or (session == cur_session and win_idx == cur_win)
        if cmd and in_current_window and is_claude_process(cmd, pid) then
            -- Claude Code sets pane title to "Claude Code [session-name]"
            local cc_session = pane_title and pane_title:match "%[([^%]]+)%]$"
            local label = cc_session
                or (win_name ~= "" and win_name)
                or (session .. ":" .. win_idx .. "." .. pane_idx)
            -- Panes with a proper cc_session name sort before fallbacks
            table.insert(panes, {
                pane_id = pane_id,
                label = label,
                named = cc_session ~= nil,
                display = string.format("%-20s  (%s win:%s pane:%s)", label, session, win_idx, pane_idx),
            })
        end
    end

    table.sort(panes, function(a, b)
        if a.named ~= b.named then return a.named end
        return a.label < b.label
    end)

    return panes
end

local function send_to_pane(pane_id, content)
    local tmpfile = vim.fn.tempname()
    local f = io.open(tmpfile, "w")
    if not f then
        vim.notify("[claudecode-tmux] failed to create temp file", vim.log.levels.ERROR)
        return
    end
    f:write(content)
    f:close()

    vim.fn.system(string.format("tmux load-buffer -b _claude_ctx %s", vim.fn.shellescape(tmpfile)))
    vim.fn.system(string.format("tmux paste-buffer -b _claude_ctx -t %s", vim.fn.shellescape(pane_id)))
    vim.fn.delete(tmpfile)
    vim.fn.system(string.format("tmux switch-client -t %s", vim.fn.shellescape(pane_id)))
    vim.fn.system(string.format("tmux select-pane -t %s", vim.fn.shellescape(pane_id)))
end

local function format_message(sel)
    local path = sel.filepath ~= "" and sel.filepath or "[unnamed]"
    return string.format("%s#L%d-%d", path, sel.start_line, sel.end_line)
end

function M.send_selection()
    local sel = get_visual_selection()
    if not sel or sel.text == "" then
        vim.notify("[claudecode-tmux] no selection", vim.log.levels.WARN)
        return
    end

    local panes = find_claude_panes()
    if #panes == 0 then
        local where = (vim.env.TMUX and vim.env.TMUX ~= "") and "in current tmux window" or "in tmux"
        vim.notify("[claudecode-tmux] no Claude Code panes found " .. where, vim.log.levels.WARN)
        return
    end

    local message = format_message(sel)

    if #panes == 1 then
        send_to_pane(panes[1].pane_id, message)
        return
    end

    vim.ui.select(
        vim.tbl_map(function(p) return p.display end, panes),
        { prompt = "Send to Claude Code session:" },
        function(_, idx)
            if idx then
                send_to_pane(panes[idx].pane_id, message)
            end
        end
    )
end

return M
