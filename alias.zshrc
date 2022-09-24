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
    alias UPA='sudo apt-get -y update && sudo apt-get -y upgrade'
    alias PC='sudo apt-get autoclean && sudo apt-get autoremove'
    alias IN='sudo apt-get install'
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
alias emrc='emacs -nw ~/.emacs.d/init.el'

which nvim >&/dev/null && alias vim=nvim
