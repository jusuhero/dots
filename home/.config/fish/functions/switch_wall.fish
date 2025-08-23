function switch_wall --argument-names input_path
    set -l WALLPAPER_DIR (realpath ~/.wallpapers)

    # Expand ~ if present in the argument
    set -l p $input_path
    if string match -q '~*' -- $p
        set p (string replace -r '^~' $HOME -- $p)
    end

    # If it's not absolute, try relative to WALLPAPER_DIR, then CWD
    if not string match -q '/*' -- $p
        if test -f "$WALLPAPER_DIR/$p"
            set p "$WALLPAPER_DIR/$p"
        else if test -f "$p"
            set p (realpath "$p")
        end
    end

    # Final absolute resolution
    if test -f "$p"
        set -l abs (realpath "$p")
        # hyprpaper: set all monitors at once with reload + empty monitor spec
        hyprctl hyprpaper reload ,"$abs"
        notify-send "Wallpaper switched" "$abs"
    else
        echo "Invalid wallpaper path: $input_path"
    end
end
