function screenshot_to_file
    # Directory to store the screenshots
    set screenshot_dir "$HOME/Bilder/screen"

    # Make sure the directory exists
    mkdir -p "$screenshot_dir"

    # Find the next available screenshot number
    set screenshot_num 1
    while test -e "$screenshot_dir/screenshot$screenshot_num.png"
        set screenshot_num (math $screenshot_num + 1)
    end

    # Temporary file path
    set temp_file "/tmp/screenshot_temp.png"

    # Capture selected area and save to temp file
    grim -g (slurp) "$temp_file"

    # Final screenshot name
    set screenshot_name "screenshot$screenshot_num.png"
    mv "$temp_file" "$screenshot_dir/$screenshot_name"

    # Notify the user
    notify-send "Screenshot Captured" "Saved as $screenshot_name in $screenshot_dir"
end
