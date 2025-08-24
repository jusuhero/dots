function hyprland_startup
    set -l CNFG $HOME/.config

    # Hyprpaper (Wallpaper switcher)
    hyprpaper &

    # Notification client
    swaync &

    # Clipboard Manager
    wl-paste --type text --watch cliphist store &
    wl-paste --type image --watch cliphist store &
    wl-clip-persist --clipboard regular &

    # Bluetooth Tray Icon
    blueman-applet &

    # Network Manager Tray Icon
    nm-applet &

    # Load theme
    # wal -f "$CNFG/wal/colorschemes/ju.json" 

    # Start Waybar
    waybar -c $CNFG/waybar/config.jsonc -s $CNFG/waybar/style.css &
    waybar -c $CNFG/waybar/config-bottom.jsonc -s $CNFG/waybar/style.css &

    # Launch terminal apps
    kitty --single-instance --title kitty_welcome htop &
    kitty --single-instance --title tty_clock tty-clock -C6 &

    # Start authentication agent
    /usr/lib/polkit-kde-authentication-agent-1 &

    dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &
    systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &

    # oddly enough, this is needed for me or no sound on launch
    systemctl --user restart pipewire &
end
