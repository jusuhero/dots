function screenrecord_area
    if not pkill -INT -P (pgrep -xo record-screen) wf-recorder ^/dev/null

        set geometry (slurp -d)

        if test -n "$geometry"
            mkdir -p ~/Videos/Recordings

            # Find sink actually used by audio streams
            set system_audio (pw-dump | \
                jq -r '
                .[] |
                select(.type=="PipeWire:Interface:Node") |
                select(.info.props["media.class"]=="Audio/Sink") |
                select(.info.props["node.name"] | test("bluez")) |
                .info.props["node.name"]
                ' | head -n1).monitor

            wf-recorder \
                -a "$system_audio" \
                --codec libx264 \
                -f ~/Videos/Recordings/screen-record-(date +%Y-%m-%d-%H-%M-%S).mp4 \
                -g "$geometry"
        end
    end
end
