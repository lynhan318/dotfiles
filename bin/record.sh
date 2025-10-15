#!/bin/bash

$RECORDER_PID
toggle() {
    if pgrep -x "wf-recorder" > /dev/null; then
        echo "Stopping current recording..."
        killall wf-recorder
        echo "Recording stopped and saved."
    else
        echo "Starting a new recording..."
        wf-recorder -g "$(slurp)" --file="/home/kevin/Videos/$(date +"%F %H:%M:%S").mkv" &
        echo "Recording started with PID $RECORDER_PID."
    fi
}
# Function to stop recording
stop() {
    killall wf-recorder
    echo "Recording stopped. File saved to: $OUTPUT_DIR/$FILENAME"
}

# Function to get current status
status() {
    if pgrep -x "wf-recorder" > /dev/null; then
        echo "  Stop"
    else
        echo "  Record"
    fi
}

case "$1" in
    start)
        toggle
        ;;
    stop)
        stop
        ;;
    status)
        status
        ;;
    *)
        echo "Usage: $0 {start|stop}"
        exit 1
        ;;
esac

