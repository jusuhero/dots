
#!/bin/bash

# Path to the PID file
pid_file="/tmp/waybar.pid"

# Check if Waybar is already running
if [ -e "$pid_file" ]; then
    # Kill the Waybar process using the stored PID
    pid=$(cat "$pid_file")
    if [ -n "$pid" ]; then
        kill "$pid"
        rm "$pid_file"
        echo "Waybar stopped."
    else
        echo "Error: Unable to retrieve Waybar PID."
    fi
else
    # Start Waybar with the specified arguments
    waybar -s "$HOME/.config/waybar/style.css" -c "$HOME/.config/waybar/config.jsonc" &
    echo $! > "$pid_file"
    echo "Waybar started with PID $!"
fi