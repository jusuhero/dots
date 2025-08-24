function hyprpicker_rgb
    # Check if hyprpicker is installed
    if not type -q hyprpicker
        echo "hyprpicker is not installed. Exiting..."
        exit 1
    end

    # Execute hyprpicker and save the output to a variable
    set color (hyprpicker -a -n -f rgb)

    # Check if wl-paste is available, otherwise exit
    if not type -q wl-paste
        echo "wl-paste is not installed. Exiting..."
        exit 1
    end

    # Split the color output into three variables
    set r (echo $color | cut -d',' -f1)
    set g (echo $color | cut -d',' -f2)
    set b (echo $color | cut -d',' -f3)

    # Create a temporary 64x64 PNG file with the color in /tmp using convert
    convert -size 64x64 xc:"rgb($r,$g,$b)" /tmp/color.png

    # Send a notification with the color picked
    notify-send "Color picked" "$color" -i /tmp/color.png

    # Remove the temporary file
    rm /tmp/color.png

    # Exit gracefully
    exit 0
end
