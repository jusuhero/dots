function screenshot_selection
    grim -g (slurp) - | wl-copy
    and notify-send "Screenshot of selection copied to clipboard"
end
