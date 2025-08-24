function hyprpicker_hex
    # Check if hyprpicker is installed
    if not type -q hyprpicker
        echo "hyprpicker is not installed. Exiting..."
        exit 1
    end

    # Execute hyprpicker and save the output to a variable
    set color (hyprpicker -a -n -f hex)

    # Check if wl-paste is available, otherwise exit
    if not type -q wl-paste
        echo "wl-paste is not installed. Exiting..."
        exit 1
    end

    # Create a temporary 64x64 PNG file with the color from wl-paste using convert
    convert -size 64x64 xc:"(wl-paste)" /tmp/color.png

    # Send a notification with the color picked
    notify-send "Color picked" "$color" -i /tmp/color.png

    # Remove the temporary file
    rm /tmp/color.png

    # Exit gracefully
    exit 0
end
