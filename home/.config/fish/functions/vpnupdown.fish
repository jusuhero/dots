function vpnupdown --description 'Waybar VPN toggle/status for OpenVPN systemd unit'
    set -l msgid 2391293
    set -l UNIT openvpn-client@protonch.service # adjust if needed
    set -l TIMEOUT 5

    # Verify unit exists (handles instantiated @ units)
    set -l loadstate (systemctl show -p LoadState --value $UNIT 2>/dev/null)
    if test "$loadstate" != loaded
        echo (jq -n '{text:"󰌙", tooltip:"VPN unit missing"}')
        return 1
    end

    set -l unit_status (systemctl is-active $UNIT 2>/dev/null)

    # Helper to find an existing tun device and its address
    function __pick_tun --no-scope-shadowing
        for cand in tun0 tun1 tun2 tun3
            if ip link show dev $cand >/dev/null 2>/dev/null
                echo $cand
                return 0
            end
        end
        return 1
    end

    if test "$unit_status" != active
        # Inactive path
        if test (count $argv) -gt 0; and test "$argv[1]" = toggle
            systemctl start $UNIT >/dev/null 2>/dev/null

            # Wait up to TIMEOUT seconds for any tunX to appear
            set -l start (date +%s)
            set -l dev ''
            while true
                set dev (__pick_tun)
                if test -n "$dev"
                    break
                end
                if test (math (date +%s) - $start) -ge $TIMEOUT
                    break
                end
                sleep 0.2
            end

            set -l addr ''
            if test -n "$dev"
                set addr (ip -br addr show dev $dev | awk '{print $3}')
            end
            notify-send -a changeNetwork -u low -i network-vpn -r $msgid -t 2000 "VPN Activated $addr"
        end

        echo (jq -n --arg icon "󰌙" '{text:$icon, tooltip:"VPN not active"}')
        return
    end

    # Active path
    if test (count $argv) -gt 0; and test "$argv[1]" = toggle
        systemctl stop $UNIT >/dev/null 2>/dev/null
        notify-send -a changeNetwork -u low -i network-vpn -r $msgid -t 2000 "VPN Deactivated"
    end

    set -l dev (__pick_tun)
    set -l addr ''
    if test -n "$dev"
        set addr (ip -br addr show dev $dev | awk '{print $3}')
    end

    echo (jq -n --arg icon "󱊪" --arg addr "$addr" '{text:$icon, class:"enabled", tooltip:$addr}')
end
