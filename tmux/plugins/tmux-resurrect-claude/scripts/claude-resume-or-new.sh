#!/usr/bin/env bash
# Try to resume a claude session; if it fails (expired/missing), start fresh.
session_id="$1"
shift
# Try resume, fall back to fresh session
claude --resume "$session_id" --enable-auto-mode "$@" 2>/dev/null || claude --enable-auto-mode "$@"
