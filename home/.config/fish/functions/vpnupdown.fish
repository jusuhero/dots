function vpnupdown
    set msgid 2391293
    set STATUS (systemctl is-active openvpn-officeVPN.service)


    if test "$STATUS" = inactive
        if test (count $argv) -gt 0; and test "$argv[1]" = toggle
            systemctl start openvpn-officeVPN.service
            
            # Wait for the interface to get an IP, otherwise ADDR will be unset
            set start_time (date +%s)
            while not ip link show dev tun1 &> /dev/null
                set current_time (date +%s)
                set elapsed_time (math $current_time - $start_time)
                
                if test "$elapsed_time" -ge 5
                    break
                end
                sleep 0.1
            end
            
            set ADDR (ip -br addr show dev tun1 | awk '{ print $3 }')
            dunstify -a changeNetwork -u low -i network-vpn -r $msgid -t 2000 "VPN Activated $ADDR"
        end
        set text '{"text":"󰌙","tooltip":"VPN not active"}'
    else
        if test (count $argv) -gt 0; and test "$argv[1]" = toggle
            systemctl stop openvpn-officeVPN.service
            dunstify -a changeNetwork -u low -i network-vpn -r $msgid -t 2000 "VPN Deactivated"
        end
        set ADDR (ip -br addr show dev tun0 | awk '{ print $3 }')
        set text '{"text":"󱊪","class":"enabled","tooltip":"'$ADDR'"}'
    end

    echo $text
end
