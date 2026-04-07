#!/usr/bin/env bash
#
# Pre-restore hook: rewrite claude commands in the resurrect file
# to use --resume <session-id>.

set -euo pipefail

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

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
SIDECAR="$RESURRECT_DIR/claude_sessions.txt"

if [ ! -f "$SIDECAR" ]; then
	exit 0
fi

if [ ! -L "$LAST_LINK" ]; then
	exit 0
fi

SAVE_FILE="$(readlink -f "$LAST_LINK")"
if [ ! -f "$SAVE_FILE" ]; then
	exit 0
fi

d=$'\t'

# Read sidecar into an associative array: pane_target -> session_id
declare -A PANE_SESSIONS
while IFS="$d" read -r pane_target session_id original_cmd; do
	[ -n "$pane_target" ] && [ -n "$session_id" ] || continue
	PANE_SESSIONS["$pane_target"]="$session_id"
done < "$SIDECAR"

if [ ${#PANE_SESSIONS[@]} -eq 0 ]; then
	exit 0
fi

# Rewrite the resurrect file
# Resurrect file format for panes:
#   pane<TAB>session<TAB>window<TAB>window_name<TAB>window_layout<TAB>pane_index<TAB>dir<TAB>pane_active<TAB>command<TAB>full_command
# Fields: 0=pane 1=session 2=window 3=wname 4=layout 5=pane_idx 6=dir 7=active 8=command 9=full_command

tmpfile="$(mktemp "${SAVE_FILE}.XXXXXX")"

while IFS= read -r line; do
	# Only process pane lines
	if [[ "$line" != pane* ]]; then
		echo "$line" >> "$tmpfile"
		continue
	fi

	# Parse the pane line
	IFS="$d" read -r -a fields <<< "$line"

	# Build pane target from fields: session:window.pane_index
	session_name="${fields[1]}"
	window_idx="${fields[2]}"
	pane_idx="${fields[5]}"
	pane_target="${session_name}:${window_idx}.${pane_idx}"

	if [ -z "${PANE_SESSIONS[$pane_target]+_}" ]; then
		echo "$line" >> "$tmpfile"
		continue
	fi

	session_id="${PANE_SESSIONS[$pane_target]}"
	full_command="${fields[10]:-}"

	# Check if this is a claude command
	if [[ "$full_command" != *claude* ]]; then
		echo "$line" >> "$tmpfile"
		continue
	fi

	# Build new command: use wrapper script to try --resume, fall back to fresh claude
	wrapper="$CURRENT_DIR/scripts/claude-resume-or-new.sh"
	extra_flags=""
	if [[ "$full_command" == *--dangerously-skip-permissions* ]]; then
		extra_flags=" --dangerously-skip-permissions"
	fi
	new_cmd="$wrapper $session_id$extra_flags"

	# Replace fields 9 (pane_command) and 10 (full_command with : prefix)
	fields[9]="bash"
	fields[10]=":$new_cmd"

	# Rejoin with tabs
	joined=""
	for i in "${!fields[@]}"; do
		if [ "$i" -eq 0 ]; then
			joined="${fields[$i]}"
		else
			joined="${joined}${d}${fields[$i]}"
		fi
	done
	echo "$joined" >> "$tmpfile"

done < "$SAVE_FILE"

# Atomic replace
mv "$tmpfile" "$SAVE_FILE"
