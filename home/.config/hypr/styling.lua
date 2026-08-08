hl.config({
    general = {
        gaps_in  = 0,
        gaps_out = 0,
        border_size = 1,
        col = {
            active_border   = "0xfff99d53",
            inactive_border = "rgba(ffba5b94)",
        },
    },
})

hl.config({
    decoration = {
        rounding         = 0,
        active_opacity   = 1,
        inactive_opacity = 0.99,
        blur = {
            enabled           = true,
            size              = 5,
            passes            = 3,
            new_optimizations = true,
            ignore_opacity    = true,
            noise             = 0,
            brightness        = 1.2,
            popups            = true,
        },
        shadow = {
            enabled = true,
            range   = 100,
            scale   = 0.9,
            offset  = { 0, 0 },
            color   = "0xff9a3800",
        },
    },
})

hl.config({
    animations = {
        enabled = true,
    },
})

hl.curve("overshot",   { type = "bezier", points = { { 0.05, 0.9 },  { 0.1, 1.05 } } })
hl.curve("smoothOut",  { type = "bezier", points = { { 0.36, 0 },   { 0.66, -0.56 } } })
hl.curve("smoothIn",   { type = "bezier", points = { { 0.25, 1 },   { 0.5, 1 } } })

hl.animation({ leaf = "windows",     enabled = true, speed = 5,  bezier = "overshot",  style = "slide" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 4,  bezier = "smoothOut", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4,  bezier = "default" })
hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 10, bezier = "smoothIn" })
hl.animation({ leaf = "fadeDim",     enabled = true, speed = 10, bezier = "smoothIn" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 6,  bezier = "default" })
