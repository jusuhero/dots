function next_wallpaper
    set -l TMP /tmp/current_wall
    set -l DIR (realpath ~/.wallpapers)

    # Build a sorted list of absolute paths
    set -l WALLPAPERS (printf '%s\n' $DIR/* | sort -V)

    if not test -f $TMP
        echo 0 >$TMP
    end

    set -l i (cat $TMP)
    set -l count (count $WALLPAPERS)

    set i (math "$i + 1")
    if test $i -ge $count
        set i 0
    end
    echo $i >$TMP

    set -l index (math "$i + 1")
    set -l next_wallpaper $WALLPAPERS[$index]

    echo "Switching to: $next_wallpaper"

    switch_wall "$next_wallpaper"
end
