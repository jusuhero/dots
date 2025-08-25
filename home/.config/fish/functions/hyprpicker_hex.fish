function hyprpicker_hex
    # Check if hyprpicker is installed
    if not type -q hyprpicker
        echo "hyprpicker is not installed. Exiting..."
        return 1
    end

    # Check if wl-paste is installed
    if not type -q wl-paste
        echo "wl-paste is not installed. Exiting..."
        return 1
    end

    # Run hyprpicker (foreground), let it put result in clipboard
    hyprpicker -a -n -f hex 2>/dev/null

    set color ""
    for i in (seq 1 10) # try up to 10 times (~1s max)
        set candidate (wl-paste)
        if string match -rq '^#?[0-9a-fA-F]{6}$' -- $candidate
            set color $candidate
            break
        end
        sleep 0.1
    end

    if test -z "$color"
        notify-send Hyprpicker "No valid color detected."
        return 1
    end

    # Create temporary color preview
    convert -size 64x64 xc:"$color" /tmp/color.png

    # Send notification
    notify-send "Color picked" "$color" -i /tmp/color.png

    # Clean up
    rm /tmp/color.png
end
