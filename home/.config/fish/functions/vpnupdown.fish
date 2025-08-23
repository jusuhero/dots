function vpnupdown
    set msgid 2391293
    set UNIT openvpn-officeVPN.service

    # Bail if VPN unit doesn't exist
    if not systemctl list-unit-files | grep -q $UNIT
        echo (jq -n '{text:"󰌙", tooltip:"VPN unit missing"}')
        return 1
    end

    set STATUS (systemctl is-active $UNIT)

    if test "$STATUS" = inactive
        if test (count $argv) -gt 0; and test "$argv[1]" = toggle
            systemctl start $UNIT

            # Wait for tun1
            set start_time (date +%s)
            while not ip link show dev tun1 ^/dev/null
                set elapsed_time (math (date +%s) - $start_time)
                if test "$elapsed_time" -ge 5
                    break
                end
                sleep 0.1
            end

            set ADDR (ip -br addr show dev tun1 | awk '{ print $3 }')
            dunstify -a changeNetwork -u low -i network-vpn -r $msgid -t 2000 "VPN Activated $ADDR"
        end
        set text (jq -n --arg icon "󰌙" '{text:$icon, tooltip:"VPN not active"}')
    else
        if test (count $argv) -gt 0; and test "$argv[1]" = toggle
            systemctl stop $UNIT
            dunstify -a changeNetwork -u low -i network-vpn -r $msgid -t 2000 "VPN Deactivated"
        end
        set ADDR (ip -br addr show dev tun0 | awk '{ print $3 }')
        set text (jq -n --arg icon "󱊪" --arg addr "$ADDR" '{text:$icon, class:"enabled", tooltip:$addr}')
    end

    echo $text
end
