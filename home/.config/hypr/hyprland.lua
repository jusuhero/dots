-- Ju's Hyprland Config (Lua / Hyprland 0.55+)
-- Split across modules; old .conf files are kept as reference.

require("env")
require("display")
require("styling")
require("input")
require("keybinds")
require("windowrules")

-- Autostart
hl.on("hyprland.start", function()
    hl.exec_cmd("fish -c 'hyprland_startup'")
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 24")
end)

hl.config({
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        mouse_move_enables_dpms = true,
        enable_swallow = true,
        swallow_regex = "^(kitty)$", -- GUI apps opened in Kitty stay inside the terminal
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

hl.config({
    dwindle = {
        preserve_split = true,
        smart_resizing = true,
    },
})
