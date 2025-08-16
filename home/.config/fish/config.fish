# Fish Config

# Import preset from cachyOS 
# source /usr/share/cachyos-fish-config/cachyos-config.fish

gpg-connect-agent UPDATESTARTUPTTY /bye >/dev/null # needed for gpg agent

# Aliases
alias grep='grep --color=auto'
alias conf='z ~/.config'
alias cat='bat'
alias ls='ls --color=auto --hyperlink=auto'
alias lsa='ls -la'
alias icat='kitty +kitten icat'
alias r2='radare2'
alias hx='helix'
alias cl='clear'
alias lgit='lazygit'
alias fishrc='$EDITOR ~/.config/fish/config.fish'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias lsblk='lsblk -o name,mountpoint,label,size,uuid'
alias fastfetch='fastfetch --logo ~/.config/fastfetch/asuka.png --logo-type kitty-direct --logo-width 30 --logo-height 15'

# Variables
set -gx EDITOR helix
set -gx VOLUME_STEP 5
set -gx BRIGHTNESS_STEP 5
set -gx SSH_AUTH_SOCK "$(gpgconf --list-dirs agent-ssh-socket)"
set -gx PATH $HOME/.cargo/bin $PATH
set -gx PATH $HOME/go/bin $PATH

set fish_vi_force_cursor
set fish_cursor_default block
set fish_cursor_insert line blink
set fish_cursor_visual underscore blink

starship init fish | source
zoxide init fish | source
