#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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

# Append ~claude to @resurrect-processes (tilde = regex match)
current_processes="$(get_tmux_option "@resurrect-processes" "")"
if [[ "$current_processes" != *"~claude"* ]]; then
	tmux set-option -g @resurrect-processes "$current_processes ~claude"
fi

# Register post-save-all hook (chain with existing if present)
existing_post_save="$(get_tmux_option "@resurrect-hook-post-save-all" "")"
save_script="$CURRENT_DIR/scripts/save_claude_sessions.sh"
if [ -n "$existing_post_save" ]; then
	tmux set-option -g @resurrect-hook-post-save-all "$existing_post_save; $save_script"
else
	tmux set-option -g @resurrect-hook-post-save-all "$save_script"
fi

# Register pre-restore-pane-processes hook (chain with existing if present)
existing_pre_restore="$(get_tmux_option "@resurrect-hook-pre-restore-pane-processes" "")"
restore_script="$CURRENT_DIR/scripts/restore_claude_sessions.sh"
if [ -n "$existing_pre_restore" ]; then
	tmux set-option -g @resurrect-hook-pre-restore-pane-processes "$existing_pre_restore; $restore_script"
else
	tmux set-option -g @resurrect-hook-pre-restore-pane-processes "$restore_script"
fi
