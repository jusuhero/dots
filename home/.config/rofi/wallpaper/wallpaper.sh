#!/bin/bash

# find image size to display (very slow)
#echo $(identify -format '%[fx:w]x%[fx:h]\' ~/Pictures/$A 2>/dev/null)

build_theme() {
    rows=$1
    cols=$2
    icon_size=$3

    echo "element{orientation:vertical;}element-text{horizontal-align:0.5;}element-icon{size:$icon_size.0000em;}listview{lines:$rows;columns:$cols;}"
}

theme="$HOME/.config/rofi/wallpaper/style.rasi"

ROFI_CMD="rofi -dmenu -i -show-icons -window-title walls -theme-str $(build_theme 3 5 6) -theme ${theme}"

choice=$(\
    ls --escape "$WALLPAPER_DIR" | \
        while read A; do echo -en "$A\x00icon\x1f$WALLPAPER_DIR/$A\n"; done | \
        $ROFI_CMD -p "󰸉  Wallpaper" \
)

wallpaper="$WALLPAPER_DIR/$choice"

if [ "$XDG_CURRENT_DESKTOP" = "KDE" ]; then
    echo "$wallpaper"
    qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "var allDesktops = desktops();print (allDesktops);for (i=0;i<allDesktops.length;i++) {d = allDesktops[i];d.wallpaperPlugin = \"org.kde.image\";d.currentConfigGroup = Array(\"Wallpaper\", \"org.kde.image\", \"General\");d.writeConfig(\"Image\", \"file:$wallpaper\")}"

    qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "var allDesktops = desktops();print (allDesktops);for (i=0;i<allDesktops.length;i++) {d = allDesktops[i];d.wallpaperPlugin = \"org.kde.image\";d.currentConfigGroup = Array(\"Wallpaper\", \"org.kde.image\", \"General\");d.writeConfig(\"Image\", \"file:$wallpaper\")}"

    exit 0
elif [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
    gsettings set org.gnome.desktop.background picture-uri "file://$wallpaper"
    gsettings set org.gnome.desktop.background picture-uri-dark "file://$wallpaper"

    exit 0
elif [ "$XDG_CURRENT_DESKTOP" = "sway" ]; then
    swaymsg output "*" bg "$wallpaper" "stretch"

    exit 0
else
    echo $wallpaper
	fish -c "switch_wall '${wallpaper}'"
    ln -sf "$wallpaper" "$WALLPAPER_DIR"/current.wall
fi

exit 1

