function screenshot_to_file
    # 1. Ensure the directory exists
    # If SCREENSHOT_DIR is empty, this defaults to ~/Pictures
    set -q SCREENSHOT_DIR; or set SCREENSHOT_DIR "$HOME/Pictures"
    mkdir -p "$SCREENSHOT_DIR"

    # 2. Get the geometry from slurp
    set geometry (slurp)

    # Check if slurp was cancelled (if $status is not 0)
    if test $status -ne 0
        return 1
    end

    # 3. Find the next available number
    set screenshot_num 1
    while test -e "$SCREENSHOT_DIR/screenshot$screenshot_num.png"
        set screenshot_num (math $screenshot_num + 1)
    end
    set screenshot_name "screenshot$screenshot_num.png"
    set final_path "$SCREENSHOT_DIR/$screenshot_name"

    # 4. Capture directly to the final path
    # (No need for a temp file unless you are doing post-processing)
    if grim -g "$geometry" "$final_path"
        # 5. Only notify if grim succeeded
        notify-send "Screenshot Captured" "Saved as $screenshot_name in $SCREENSHOT_DIR"
    else
        notify-send "Screenshot Failed" "Grim was unable to save the file"
    end
end
