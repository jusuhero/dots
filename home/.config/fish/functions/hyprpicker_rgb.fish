function hyprpicker_rgb
    # Check if hyprpicker is installed
    if not type -q hyprpicker
        echo "hyprpicker is not installed. Exiting..."
        return 1
    end

    # Check if wl-paste is available
    if not type -q wl-paste
        echo "wl-paste is not installed. Exiting..."
        return 1
    end

    # Run hyprpicker (foreground), copy result to clipboard
    hyprpicker -a -n -f rgb 2>/dev/null

    # Wait until clipboard contains a valid rgb triplet
    set color ""
    for i in (seq 1 10)
        set candidate (wl-paste)
        # Match "number number number"
        if string match -rq '^[0-9]{1,3} [0-9]{1,3} [0-9]{1,3}$' -- $candidate
            set color $candidate
            break
        end
        sleep 0.1
    end

    if test -z "$color"
        notify-send Hyprpicker "No valid RGB color detected."
        return 1
    end

    # Split into R, G, B (space-separated)
    set r (echo $color | awk '{print $1}')
    set g (echo $color | awk '{print $2}')
    set b (echo $color | awk '{print $3}')

    # Create temporary preview image
    convert -size 64x64 xc:"rgb($r,$g,$b)" /tmp/color.png

    # Send notification
    notify-send "Color picked" "$r $g $b" -i /tmp/color.png

    # Clean up
    rm /tmp/color.png
end
