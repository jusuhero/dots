# Ju's Dotfiles

### These are the configuration files for my Arch + Hyprland setup
![setup](resources/dotfiles-3.png)

![setup2](resources/dotfiles-1.png)


## Installation

Only use my dotfiles if you know what you are doing. It is customized to my liking, and some things may be messy, missing and don't work correctly, especially with filepaths. It is mostly meant for reference/inspiration, not to be used by anyone else, but go ahead if you like :) 

Install the needed packages using an AUR Helper of your choice
```bash
paru -S hyprland waybar bat swww-git gtk3 copyq python-pywal blueman rofi cava wl-clipboard hyprshade wf-recorder swappy grimshot kitty pavucontrol thunar hyprpicker-git swaync-git nm-connection-editor nwg-look python-pynvim pinentry kwindowsystem kguiaddons git make
```

These are the themes and font I use
```bash
paru -S gtk-theme-material-black ttf-material-design-icons-extended se98-icon-theme-git bibata-cursor-theme ttf-jetbrains-mono-nerd dracula-icons-git
```

Some additional apps that I use for various purposes and dependencies you'll need
```bash
sudo pacman -S feh vifm firefox vlc neovim tmux zathura playerctl objdump brightnessctl hyprlock fastfetch poppler highlight python-pywalfox python python-pip npm node nodejs yarn cargo ripgrep
```

Alternatively there is a file `packs` in the root folder which you can install 
`yay -S - < packs`

## Keybinds

### Terminals

<kbd>CTRL</kbd> + <kbd>ALT</kbd> + <kbd>T</kbd> = Small floating kitty Terminal

<kbd>CTRL</kbd> + <kbd>ALT</kbd> + <kbd>RETURN</kbd> = Fullscreen terminal with big font size

<kbd>ALT</kbd> + <kbd>RETURN</kbd> = Tiled kitty Terminal

### Basic Stuff
<kbd>MOD</kbd> + <kbd>q</kbd> = kill Window

<kbd>MOD</kbd> + <kbd>e</kbd> = Thunar (File Explorer)

<kbd>MOD</kbd> + <kbd>s</kbd> = toggle floating

<kbd>MOD</kbd> + <kbd>d</kbd> = Discord

<kbd>MOD</kbd> + <kbd>f</kbd> = Firefox

<kbd>MOD</kbd> + <kbd>r</kbd> = Ranger

<kbd>MOD</kbd> + <kbd>b</kbd> = Launch Waybar

<kbd>MOD</kbd> + <kbd>SHIFT</kbd> + <kbd>b</kbd> = Launch Bottom Waybar

<kbd>MOD</kbd> + <kbd>l</kbd> = Lock screen

### Move
<kbd>ALT</kbd> + left,right,up,down = move focus between windows

<kbd>MOD</kbd> + <kbd>1</kbd> - <kbd>9</kbd> = Switch to workspace 

<kbd>ALT</kbd> + <kbd>1</kbd> - <kbd>9</kbd> = Move focused window to workspace 

<kbd>MOD</kbd> + <kbd>Shift</kbd> + <kbd>Up</kbd> = make window big toggle

<kbd>MOD</kbd> + <kbd>Shift</kbd> + <kbd>Down</kbd> = make window fullscreen toggle

### Exit

<kbd>MOD</kbd> + <kbd>Shift</kbd> + <kbd>Q</kbd> = Kill Hyprland session

For more keybinds please look directly into `dots/.config/hypr/keybinds.conf` because I just outlined the most important for me 

## Programs

### waybar
There are two bars available. Press <kbd>MOD</kbd> + <kbd>B</kbd> for the main bar at the top, press <kbd>MOD</kbd> + <kbd>SHIFT</kbd> + <kbd>B</kbd> for the bottom bar (showing mostly hardware information and helper stuff )
The top waybar is launched on start on Hyprland (see startup script)

### Rofi 
Application Launcher. Press <kbd>MOD</kbd> + <kbd>SPACE</kbd> to select your applications to launch. 
<kbd>MOD</kbd> + <kbd>W</kbd> launches the wallpaper selector. You can select any wallpaper in ~/.wallpapers/ 

### Feh 
This is a simple image viewer. `feh .` can be used to display images in the current folder in feh. It is integrated as default app for images in Thunar and vifm.  

### Pywal
This is what I use for theming/colors. There is only one theme in `~/.config/wal/colorschemes/` which I use, but it is possible to change various colors 
using `wal -i image.png`. The default theme is loaded upon startup.

### Firefox 
I use the ShyFox Theme. (https://github.com/Naezr/ShyFox) Clone the repo, install as described and also install the addons Sideberry, Userchrome Toggle Extended & Pywalfox.

Pywalfox is used for styling firefox in pywal colors, which needs to be installed first `paru -S python-pywalfox` and then also downloaded as firefox addon - search Pywalfox in Mozilla Store. 

### Tmux 
Allows splitting panes and much more. Install Tmux Plugin Manager (tpm) first: 
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
Then copy contents of `dots/.config/tmux` into `~/.config/tmux/` 

### Neovim 
I use LunarVim, and have added configuration for different LSPs, and installed some additional cool plugins. 
See (https://www.lunarvim.org/de/docs/installation) for installation guidance and after that copy 'dots/.config/lvim/*' into '~/.config/lvim/'
I would recommend setting an alias in zsh or bashrc like this: `alias vim='~/.local/bin/lvim'`
Probably my favourite plugin is MarkdownPreview which allows previewing Markdown Files in the Browser, neatly formatted and auto-updating.

### vifm 
Terminal file explorer. I like it very much. It is configured to show a preview of the file contents at the right side.
It also works with image previews. Upon pressing  <kbd>Right arrow</kbd> the image is then opened in feh in fullscreen, allowing cycling through the images.

### Swaync (Notification Client)
This is the notification client. The daemon gets initialized in the hyprland startup script. The notification GUI can be opened by clicking on the bell icon in the bottom waybar or by using <kbd>MOD</kbd> + <kbd>N</kbd>

### Hyprshade 
Allows you to apply color filters. They can be activated by clicking buttons in swaync-client. I sometimes use the blue-light filter but the other ones are just for show off.

### Hyprlock 
Locks the screen when pressing <kbd>MOD</kbd> + <kbd>L</kbd>

### Hyprpicker 
This allows you to select a color on the screen and copy the hex code into the clipboard. It can be selected via <kbd>MOD</kbd> + <kbd>X</kbd> keybind or via clicking the pipette icon in the bottom waybar 

### Screenshot
Screenshot/Screencapture works using wf-recorder, grimshot, grim and slurp. 
<kbd>MOD</kbd> + <kbd>v</kbd> will create a screencapture with audio. Specify the video folder it should upload to inside the script in Hyprland/script folder.

<kbd>MOD</kbd> + <kbd>SHIFT</kbd> + <kbd>v</kbd> will end the recording and kill wf-recorder.

<kbd>Print</kbd> will save a screenshot of your active monitor to the clipboard 

<kbd>MOD</kbd> + <kbd>p</kbd> Will allow you to select an area and copy a screenshot of this to the clipboard.

<kbd>MOD</kbd> + <kbd>SHIFT</kbd> + <kbd>p</kbd> Will allow you to select and area and copy a screenshot of this to a file.

<kbd>MOD</kbd> + <kbd>SHIFT</kbd> + <kbd>s</kbd> Swappy: A windows like snipping tool that lets you annotate screenshots before you save them to file or clipboard. 

### SWWW (Wallpaper switcher)
The wallpapers are in ~/.wallpapers. They can be switched by using the rofi menu <kbd>MOD</kbd> + <kbd>W</kbd> or by clicking the Switch Icon in the bottom waybar.