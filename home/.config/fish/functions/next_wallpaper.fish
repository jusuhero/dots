function next_wallpaper
    set -l TMP "/tmp/current_wall"
    set -l WALLPAPERS (ls -1 ~/.wallpapers/* | sort)

    if not test -f $TMP
        echo 0 > $TMP
    end

    set -l i (cat $TMP)
    set -l count (count $WALLPAPERS)

    set i (math "$i + 1")
    if test $i -ge $count
        set i 0
    end

    echo $i > $TMP

    # Fish arrays are 1-based, so we add 1 to the index
    set -l index (math "$i + 1")
    set -l next_wallpaper $WALLPAPERS[$index]
    switch_wall "$next_wallpaper"
end
