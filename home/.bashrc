#
# ~/.bashrc
#
export EDITOR="lvim"
# Add dir .local/bin to path
export PATH="$HOME/.local/bin:$PATH"
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias grep='grep --color=auto'
alias cat='bat'
alias ls='ls --color=auto --hyperlink=auto'
alias lsa='ls -la'
alias huso='sudo'
alias keepassxc='QT_QPA_PLATFORM=wayland keepassxc'
alias vim='nvim'
alias icat='kitty +kitten icat'
alias r2='radare2'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias lsblk='lsblk -o name,mountpoint,label,size,uuid'
alias fastfetch='fastfetch --logo ~/.config/fastfetch/asuka.png --logo-type kitty-direct --logo-width 30 --logo-height 15'
alias nvim='lvim'
export NNN_BMS="d:$HOME/webiste;u:/home/ju/notes/Notes/ ;D:$HOME/Downloads/"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

zipedit(){
    echo "Usage: zipedit archive.zip folder/file.txt"
    curdir=$(pwd)
    unzip "$1" "$2" -d /tmp 
    cd /tmp
    nvim "$2" && zip --update "$curdir/$1"  "$2" 
    # remove this line to just keep overwriting files in /tmp
    rm -f "$2" # or remove -f if you want to confirm
    cd "$curdir"
}

#export PS1="\[\033[38;5;178m\]\u@\h\[$(tput sgr0)\] : [\[$(tput sgr0)\]\[\033[38;5;69m\]\w\[$(tput sgr0)\]] > \[$(tput sgr0)\]"

RED='\[\e[0;31m\]'
WHITE='\[\e[0;37m\]'
CYAN='\[\e[0;36m\]'
RESET='\[\e[0m\]'
BOLD='\[\e[1m\]'

# Example prompt
PS1="${RED}${BOLD}\u@[\H] ${WHITE}[\w] ${CYAN}➜ ${RESET} "
