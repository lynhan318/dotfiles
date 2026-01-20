#!/bin/bash

# Function to toggle Dunst notification state
toggle_dunst() {
  if dunstctl is-paused | grep -q true; then
    dunstctl set-paused false
    echo "Dunst notifications enabled."
  else
    dunstctl set-paused true
    echo "Dunst notifications paused."
  fi
}

# Function to retrieve Dunst status
get_dunst_status() {
  if dunstctl is-paused | grep -q true; then
    echo ""
  else
    echo "󰂚"
  fi
}

# Main script to handle input arguments
case "$1" in
  toggle)
    toggle_dunst
    ;;
  status)
    get_dunst_status
    ;;
  *)
    echo "Usage: $0 {toggle|status}"
    exit 1
    ;;
esac


