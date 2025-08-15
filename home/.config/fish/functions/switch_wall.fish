function switch_wall
    set -l input_path $argv[1]
    set -l wallpaper_path (realpath "$input_path" 2>/dev/null)

    if test -f "$wallpaper_path"
        hyprctl hyprpaper reload ,"$wallpaper_path"
        notify-send "Wallpaper switched" "$wallpaper_path"
    else
        echo "Invalid wallpaper path: $input_path"
    end
end
