local term = "kitty"
local browser = "firefox"
local browser_secondary = "chromium"
local mainMod = "SUPER"

local ws_home = "name:\u{e617} HOME"
local ws_code = "name:\u{eac4} CODE"

-- Audio control
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("fish -c 'volctrl up'"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("fish -c 'volctrl down'"))
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("fish -c 'volctrl mute'"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("fish -c 'volctrl mute'"))

-- Mouse binds
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Screen recording
hl.bind(mainMod .. " + V",        hl.dsp.exec_cmd("fish -c 'screenrecord_area'"))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("killall -s SIGINT wf-recorder"))

-- Screenshots
hl.bind("Print", hl.dsp.exec_cmd(
    'grim -o "$(hyprctl monitors -j | jq -r \'.[] | select(.focused) | .name\')" - | wl-copy && notify-send "Screenshot of active screen copied to clipboard"'
))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f -'))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("fish -c screenshot_to_file"))
hl.bind(mainMod .. " + P",          hl.dsp.exec_cmd("fish -c screenshot_selection"))

-- Terminals
hl.bind("CTRL + ALT + RETURN", hl.dsp.exec_cmd("kitty --start-as=fullscreen -o 'font_size=25' --title kitty_big"))
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("kitty --single-instance --title kitty_tiled"))
hl.bind("CTRL + ALT + T",      hl.dsp.exec_cmd("kitty --single-instance --title kitty_float"))
hl.bind(mainMod .. " + T",      hl.dsp.exec_cmd("kitty --single-instance --title ju@ANGKORWAT"))

-- Waybar
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.exec_cmd("fish -c 'toggle-waybar bottom'"))
hl.bind(mainMod .. " + H",          hl.dsp.exec_cmd("fish -c 'toggle-waybar top'"))

-- Lock
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))

-- Rofi menus
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(
    '~/.config/rofi/launchers/eva.sh & sleep 0.2; hyprctl dispatch focuswindow "^(Rofi)"'
))
hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.exec_cmd(
    '~/.config/rofi/launchers/nerv.sh & sleep 0.2; hyprctl dispatch focuswindow "^(Rofi)"'
))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("~/.config/rofi/wallpaper/wallpaper.sh"))

-- Apps
hl.bind(mainMod .. " + B",        hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd(browser_secondary))
hl.bind(mainMod .. " + R",        hl.dsp.exec_cmd('kitty -e ranger --cmd "set show_hidden true"'))
hl.bind(mainMod .. " + D",        hl.dsp.exec_cmd("vesktop"))
hl.bind(mainMod .. " + E",        hl.dsp.exec_cmd("thunar"))
hl.bind(mainMod .. " + N",        hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind(mainMod .. " + X",        hl.dsp.exec_cmd("fish -c 'hyprpicker_hex'"))
hl.bind("CTRL + 1", hl.dsp.exec_cmd("kitty --title kitty_float --hold cava"))
hl.bind("CTRL + 2", hl.dsp.exec_cmd("kitty --title tty_clock --hold tty-clock -C6"))

-- Window management
hl.bind(mainMod .. " + Q",        hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exit())
hl.bind(mainMod .. " + F",        hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + S",        hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F1",       hl.dsp.window.pseudo())
hl.bind(mainMod .. " + F2",       hl.dsp.layout("togglesplit"))

hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "d" }))
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))

hl.bind(mainMod .. " + ALT + left",  hl.dsp.window.resize({ x = -20, y = 0,  relative = true }))
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.resize({ x = 20,  y = 0,  relative = true }))
hl.bind(mainMod .. " + ALT + up",    hl.dsp.window.resize({ x = 0,  y = -20, relative = true }))
hl.bind(mainMod .. " + ALT + down",  hl.dsp.window.resize({ x = 0,  y = 20,  relative = true }))

-- Groups
hl.bind(mainMod .. " + g",          hl.dsp.group.toggle())
hl.bind(mainMod .. " + SHIFT + G",  hl.dsp.window.move({ into_or_create_group = "right" }))
hl.bind(mainMod .. " + tab",        hl.dsp.group.next())

-- Workspaces
hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = ws_home }))
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = ws_code }))
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))

hl.bind(mainMod .. " + SHIFT + right", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.focus({ workspace = "e-1" }))

hl.bind("ALT + 1", hl.dsp.window.move({ workspace = ws_home }))
hl.bind("ALT + 2", hl.dsp.window.move({ workspace = ws_code }))
hl.bind("ALT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind("ALT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind("ALT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind("ALT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind("ALT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind("ALT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind("ALT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind("ALT + 0", hl.dsp.window.move({ workspace = 10 }))
