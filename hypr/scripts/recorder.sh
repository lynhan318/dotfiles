#!/bin/env bash
# Screen recording toggle (wf-recorder + slurp)
# Press once to start recording a region, press again to stop

SAVE_DIR="$HOME/Videos/Recordings"
mkdir -p "$SAVE_DIR"
PID_FILE="/tmp/hypr_recorder.pid"

stop_recording() {
    PID=$(cat "$PID_FILE")
    kill -INT "$PID"
    rm "$PID_FILE"
    notify-send "Hyprland" "Video saved to Recordings" -i video-x-generic
    exit 0
}

# If already recording -> stop
if [ -f "$PID_FILE" ]; then
    stop_recording
fi

# Select region
GEOMETRY=$(slurp -b "#282828bb" -c "#a7c080" -p)
[ -z "$GEOMETRY" ] && exit 1

FILE_PATH="$SAVE_DIR/rec_$(date +'%y%m%d_%H%M%S').mp4"

# Start wf-recorder in background
wf-recorder -g "$GEOMETRY" -f "$FILE_PATH" --codec=libx264 &
echo $! > "$PID_FILE"

notify-send "Hyprland" "Recording screen..." -t 2000
