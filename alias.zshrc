#!/usr/bin/env zsh
alias zsrc='source ~/.zshrc'
alias zshrc='vim ~/.zshrc'
alias vimrc='vim ~/.vimrc'
alias i3rc='vim ~/.config/i3/config'

function __checkos {
    OS=$(cat /etc/issue)
    pattern="$1"
    echo "$OS"|grep -iE "$pattern" 2>&1 >/dev/null
    return $?
}
# OS specific
if __checkos 'debian|ubuntu|pop'; then
    alias UPA='sudo apt -y update && sudo apt -y upgrade'
    alias PC='sudo apt autoclean && sudo apt autoremove'
    alias IN='sudo apt install'
    alias PC='apt-cache search'
elif __checkos 'arch|manjaro'; then
    alias UPA='sudo pacman -Syyu && yay -Syyu && sudo update-grub'
    alias PC='sudo pacman -Scc'
    alias IN='sudo pacman -Sy'
    alias YI='yay -Sy'
    alias PAS='pacman -Ss'
    alias YS='yay -Ss'
fi

alias POW='sudo poweroff'
alias REB='sudo reboot'

alias axe='axel -n10 -k -a'
alias em='emacs -nw'

which nvim >&/dev/null && alias vim=nvim
