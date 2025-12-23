function switch_wall --argument-names input_path
    set -l WALLPAPER_DIR (realpath ~/.wallpapers)

    # Expand ~
    set -l p $input_path
    if string match -q '~*' -- $p
        set p (string replace -r '^~' $HOME -- $p)
    end

    # Resolve relative paths
    if not string match -q '/*' -- $p
        if test -f "$WALLPAPER_DIR/$p"
            set p "$WALLPAPER_DIR/$p"
        else if test -f "$p"
            set p (realpath "$p")
        end
    end

    if not test -f "$p"
        echo "Invalid wallpaper path: $input_path"
        return 1
    end

    set -l abs (realpath "$p")

    switch "$XDG_CURRENT_DESKTOP"
        case Hyprland hyprland
            hyprctl hyprpaper reload ,"$abs"
            notify-send "Wallpaper switched (Hyprland)" "$abs"

        case niri
            # Noctalia shell does not need absolute monitor unless you want one
            qs -c noctalia-shell ipc call wallpaper set "$abs" all
            notify-send "Wallpaper switched (niri)" "$abs"

        case '*'
            echo "Unsupported desktop: $XDG_CURRENT_DESKTOP"
            return 2
    end
end
