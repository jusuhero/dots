# ~/.config/fish/functions/screenrecord_area.fish

function screenrecord_area
    # Try to stop wf-recorder if running
    if not pkill -INT -P (pgrep -xo record-screen) wf-recorder ^/dev/null
        # Let user select screen area
        set geometry (slurp -d)

        if test -n "$geometry"
            pkill -USR1 -x record-screend
            mkdir -p ~/Videos/Recordings

            # Get default output (system audio) monitor
            set system_audio (wpctl inspect @DEFAULT_AUDIO_SINK@ | \
                string match -r '"monitor_name": "(.*)"' | \
                string replace -r '.*: "' '' | string replace -a '"' '')

            # Get default input (microphone)
            set mic_input (wpctl inspect @DEFAULT_AUDIO_SOURCE@ | \
                string match -r '"name": "(.*)"' | \
                string replace -r '.*: "' '' | string replace -a '"' '')

            # Start recording with both inputs
            wf-recorder \
                -a=$system_audio \
                -a=$mic_input \
                --codec libx264 \
                -f ~/Videos/Recordings/screen-record-(date +%Y-%m-%d-%H-%M-%S).mp4 \
                -g "$geometry"

            pkill -USR2 -x record-screend
        end
    end
end
