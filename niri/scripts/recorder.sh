
#!/bin/env bash

# Cấu hình
SAVE_DIR="$HOME/Videos/Recordings"
mkdir -p "$SAVE_DIR"
PID_FILE="/tmp/niri_recorder.pid"

stop_recording() {
    PID=$(cat "$PID_FILE")
    kill -INT "$PID"
    rm "$PID_FILE"
    notify-send "Niri Shell" "✅ Video đã lưu vào thư mục Recordings" -i video-x-generic
    exit 0
}

# Nếu đang quay -> Dừng
if [ -f "$PID_FILE" ]; then
    stop_recording
fi

# Chọn vùng (Slurp) — drag a region; do NOT use -p (that selects a single point)
GEOMETRY=$(slurp -b "#282828bb" -c "#8ec07c")
[ -z "$GEOMETRY" ] && exit 1

FILE_PATH="$SAVE_DIR/rec_$(date +'%y%m%d_%H%M%S').mp4"

# Chạy wf-recorder ngầm
wf-recorder -g "$GEOMETRY" -f "$FILE_PATH" --codec=libx264 & 
echo $! > "$PID_FILE"

notify-send "Niri Shell" "🔴 Đang quay màn hình..." -t 2000
