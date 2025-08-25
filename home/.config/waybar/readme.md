# Waybar Setup
Waybar should be working out of the box except these two modules:
## Icinga Waybar Module
Install python and requests
`sudo pacman -S python python-requests`

Set the following environment variables for example in ~/.config/fish/config.fish
```
set -x ICINGA2_API_URL "https://my.icinga.com"
set -x ICINGA2_API_USER "icinga2_api_user"
set -x ICINGA2_API_PASSWORD "icinga2_api_password"
```

Restart the waybar. The icinga module should now show alerts.

## VPN Toggle Button
Download an OpenVPN Config from your VPN provider. Move it to
/etc/openvpn/client/. In my case I named the file protonch.conf.

If your VPN is user/password protected, create an auth user file in the same folder
```
cd /etc/openvpn/client
sudo nvim protonvpn.auth
```
write your username to line 1 and password to line 2 in this file and save

Add auth-user-pass to vpn config and point to the file
```bash
auth-user-pass /etc/oepnvpn/client/protonvpn.auth
```

secure auth file
```bash
sudo chown openvpn:network protonvpn.auth
sudo chmod 600 /etc/openvpn/client/protonvpn.auth
```

you should now be able to do `sudo systemctl start openvpn-client@protonch.service` (or however you called the config)

If you have changed the name of the file you need to change the name aswell in `~/.config/fish/functions/vpnupdown.fish`

Now let's give the user rights to activate the openvpn systemd units (Will grant rights to start/stop all OVPN systemd units system wide)

`sudo nano /etc/polkit-1/rules.d/50-openvpn.rules`

Add this to the file and save:
```
polkit.addRule(function(action, subject) {
    if (action.id == "org.freedesktop.systemd1.manage-units" &&
        action.lookup("unit").match(/^openvpn-client@.*\.service$/) &&
        subject.isInGroup("network")) {
        return polkit.Result.YES;
    }
});
```

Now add your user to the network group, if not already

`sudo usermod -aG network $USER`

Relog and you should now be able to use the command `vpnupdown toggle` without needing authorization and also be able to use the button in the bottom waybar.


