#!/usr/bin/env fish

function toggle-waybar
    set bar $argv[1]

    switch $bar
        case top
            set pid_file "/tmp/waybar-top.pid"
            set config "$HOME/.config/waybar/config.jsonc"
        case bottom
            set pid_file "/tmp/waybar-bottom.pid"
            set config "$HOME/.config/waybar/config-bottom.jsonc"
        case '*'
            echo "Usage: toggle-waybar.fish [top|bottom]"
            return 1
    end

    set style "$HOME/.config/waybar/style.css"

    # If PID file exists, check if process is still alive
    if test -e $pid_file
        set pid (cat $pid_file)
        if test -n "$pid" -a -d "/proc/$pid"
            kill $pid
            rm $pid_file
            echo "Waybar ($bar) stopped."
            return 0
        else
            # Stale PID file
            rm $pid_file
        end
    end

    # Detect running waybar with matching config (fallback if no pid file)
    set existing (pgrep -f "waybar.*$config")
    if test -n "$existing"
        kill $existing
        echo "Waybar ($bar) stopped (detected manually started instance)."
        return 0
    end

    # Start waybar
    waybar -s $style -c $config &
    echo $last_pid >$pid_file
    echo "Waybar ($bar) started with PID $last_pid."
end

# Call function if script is run directly
if status is-interactive
    functions -q toggle-waybar; and toggle-waybar $argv
else
    toggle-waybar $argv
end
