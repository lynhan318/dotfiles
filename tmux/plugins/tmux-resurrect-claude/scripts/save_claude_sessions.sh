#!/usr/bin/env bash
#
# Post-save hook: map each tmux pane running claude to its session ID.
# Writes a sidecar file (claude_sessions.txt) next to the resurrect save.

set -euo pipefail

get_tmux_option() {
	local option="$1"
	local default_value="$2"
	local option_value
	option_value=$(tmux show-option -gqv "$option")
	if [ -z "$option_value" ]; then
		echo "$default_value"
	else
		echo "$option_value"
	fi
}

get_resurrect_dir() {
	if [ -d "$HOME/.tmux/resurrect" ]; then
		local default_dir="$HOME/.tmux/resurrect"
	else
		local default_dir="${XDG_DATA_HOME:-$HOME/.local/share}/tmux/resurrect"
	fi
	local path
	path="$(get_tmux_option "@resurrect-dir" "$default_dir")"
	echo "$path" | sed "s,\$HOME,$HOME,g; s,\$HOSTNAME,$(hostname),g; s,\~,$HOME,g"
}

RESURRECT_DIR="$(get_resurrect_dir)"
LAST_LINK="$RESURRECT_DIR/last"
SESSIONS_DIR="$HOME/.claude/sessions"
SIDECAR="$RESURRECT_DIR/claude_sessions.txt"

# Ensure the last symlink exists
if [ ! -L "$LAST_LINK" ]; then
	exit 0
fi

SAVE_FILE="$(readlink -f "$LAST_LINK")"
if [ ! -f "$SAVE_FILE" ]; then
	exit 0
fi

# Build sidecar: pane_id<TAB>session_id<TAB>original_command
> "$SIDECAR"

d=$'\t'

# Iterate over all tmux panes
while IFS= read -r line; do
	pane_target="${line%% *}"
	pane_pid="${line##* }"

	# Find child claude process
	claude_pid="$(pgrep -P "$pane_pid" -x claude 2>/dev/null | head -1)" || true
	if [ -z "$claude_pid" ]; then
		continue
	fi

	# Get the full command line for this claude process
	original_cmd="$(ps -p "$claude_pid" -o args= 2>/dev/null)" || true

	# Look up session file by PID
	session_id=""
	if [ -d "$SESSIONS_DIR" ]; then
		for session_file in "$SESSIONS_DIR"/*.json; do
			[ -f "$session_file" ] || continue
			file_pid="$(grep -o '"pid":[0-9]*' "$session_file" | head -1 | cut -d: -f2)"
			if [ "$file_pid" = "$claude_pid" ]; then
				session_id="$(grep -o '"sessionId":"[^"]*"' "$session_file" | head -1 | cut -d'"' -f4)"
				break
			fi
		done

		# Fallback: match by CWD, pick most recent by startedAt
		if [ -z "$session_id" ]; then
			pane_cwd="$(tmux display-message -p -t "$pane_target" '#{pane_current_path}' 2>/dev/null)" || true
			if [ -n "$pane_cwd" ]; then
				best_started=0
				for session_file in "$SESSIONS_DIR"/*.json; do
					[ -f "$session_file" ] || continue
					file_cwd="$(grep -o '"cwd":"[^"]*"' "$session_file" | head -1 | cut -d'"' -f4)"
					if [ "$file_cwd" = "$pane_cwd" ]; then
						started="$(grep -o '"startedAt":[0-9]*' "$session_file" | head -1 | cut -d: -f2)"
						if [ "${started:-0}" -gt "$best_started" ]; then
							best_started="$started"
							session_id="$(grep -o '"sessionId":"[^"]*"' "$session_file" | head -1 | cut -d'"' -f4)"
						fi
					fi
				done
			fi
		fi
	fi

	if [ -n "$session_id" ]; then
		echo "${pane_target}${d}${session_id}${d}${original_cmd}" >> "$SIDECAR"
	fi
done < <(tmux list-panes -a -F "#{session_name}:#{window_index}.#{pane_index} #{pane_pid}")
