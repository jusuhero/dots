-- Set up monitors here. Use `hyprctl monitors` to get available modes and dimensions.

hl.monitor({
    output   = "desc:Eizo Nanao Corporation L365 37733081",
    mode     = "1024x768@60",
    position = "0x0",
    scale    = 1,
})

hl.monitor({
    output   = "desc:Dell Inc. DELL S2722DGM ",
    mode     = "1920x1080@120",
    position = "1024x0",
    scale    = 1,
})

hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080",
    position = "2980x0",
    scale    = 1.2,
})

-- Internal monitor (WS 1-3)
hl.workspace_rule({
    workspace = "name:\u{e617} HOME",
    monitor   = "eDP-1",
    default   = true,
})

hl.workspace_rule({
    workspace   = "name:\u{eac4} CODE",
    monitor     = "eDP-1",
    decorate    = false,
    gaps_in     = 0,
    gaps_out    = 0,
    no_rounding = true,
    border_size = 1,
})

hl.workspace_rule({
    workspace   = 3,
    monitor     = "eDP-1",
    border_size = 2,
    gaps_in     = 5,
    gaps_out    = 10,
})

-- External monitor (WS 4-12)
