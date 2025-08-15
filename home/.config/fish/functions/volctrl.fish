# Volume Control Script
# Usage 'volctrl up|down|mute'
function volctrl
set MSGID 3938556

# Handle argument: up, down, mute
switch $argv[1]
    case "up"
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0
    case "down"
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1- -l 1.0
    case "mute"
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
end

# Get current volume and mute status
set volume (pamixer --get-volume)
set mute (pamixer --get-mute)

# Notify based on mute/volume state
if test "$volume" -eq 0 -o "$mute" = "true"
    notify-send -a "changeVolume" -u low -i audio-volume-muted -r $MSGID -t 500 "Volume muted!"
else
    notify-send -a "changeVolume" -u low -i audio-volume-high \
        -h string:x-canonical-private-synchronous:script \
        -h int:value:$volume "Volume: $volume%"
end
end
