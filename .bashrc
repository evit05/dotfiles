#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias snvim='sudo -E nvim'
alias hypsnvim='sudo -E nvim ~/.config/hypr/hyprland.lua'
alias archup='sudo pacman -Syu'
alias snbash='sudo -E nvim ~/.bashrc' 

alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1="\[\033[1;38;5;118m\][\u@\h \W]-< \[\033[0;38;5;154m\]"
PS2="\[\033[0;38;5;154m\]> "
export LS_COLORS=$LS_COLORS:'di=01;32:'
trap 'echo -ne "\033[0m"' DEBUG

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    echo "------------------------------"
    echo "      SELECT ENVIRONMENT:     "
    echo "------------------------------"
    echo "1) Hyprland (Tiling)"
    echo "2) KDE Plasma (Wayland)"
    echo "3) Stay in TTY (Shell)"
    echo "----------------------------"
    read -p "Your choice: " choice

    case $choice in
        1)
            exec start-hyprland
            ;;
        2) 
	    exec dbus-run-session startplasma-wayland
            ;;
        3)
	    echo "Welcome to the shell. Have fun :)"
            ;;
        *)
            echo "Invalid choice. Staying in TTY :("
            ;;
    esac
fi

# Horizon stable banner
pkgs=$(pacman -Qq | wc -l)
user_name=$USER
shell_name=${SHELL##*/}

banner_text="
  ██╗  ██╗ ██████╗ ██████╗ ██╗███████╗ ██████╗ ███╗   ██╗
  ██║  ██║██╔═══██╗██╔══██╗██║╚══███╔╝██╔═══██╗████╗  ██║
  ███████║██║   ██║██████╔╝██║  ███╔╝ ██║   ██║██╔██╗ ██║
  ██╔══██║██║   ██║██╔══██╗██║ ███╔╝  ██║   ██║██║╚██╗██║
  ██║  ██║╚██████╔╝██║  ██║██║███████╗╚██████╔╝██║ ╚████║
  ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═══╝

  User: $user_name          OS: Arch Linux      WM: Hyprland
  Pkgs: $pkgs           Term: Kitty         Shell: $shell_name
"

echo "$banner_text" #| nms -f green -a

# === СЕКЦИЯ ЦИТАТ ===
if [ -f ~/.config/quotes.txt ]; then
    quote=$(shuf -n 1 ~/.config/quotes.txt)
    
    echo "  $quote" #| nms -f green -a 
    echo ""
fi


eval "$(fnm env --use-on-cd)"


# Load Angular CLI autocompletion.
#source <(ng completion script)
