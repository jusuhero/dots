function screenshot_to_file
    # Make sure the directory exists
    mkdir -p "$SCREENSHOT_DIR"

    # Find the next available screenshot number
    set screenshot_num 1
    while test -e "$SCREENSHOT_DIR/screenshot$screenshot_num.png"
        set screenshot_num (math $screenshot_num + 1)
    end

    # Temporary file path
    set temp_file "/tmp/screenshot_temp.png"

    # Capture selected area and save to temp file
    grim -g (slurp) "$temp_file"

    # Final screenshot name
    set screenshot_name "screenshot$screenshot_num.png"
    mv "$temp_file" "$SCREENSHOT_DIR/$screenshot_name"

    # Notify the user
    notify-send "Screenshot Captured" "Saved as $screenshot_name in $SCREENSHOT_DIR"
end
