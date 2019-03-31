#! /bin/bash
noop=0
prefix=""
ui=0
repo=$(pwd)
usage="usage ./install.sh [-t|--test] -p|--prefix /prefix/path -[u|--both-de]"
[[ $# -eq 0 ]] && { echo "$usage"; exit 1; }

while [[ $# -gt 0 ]]
do
    key=$1
    case $key in
        -t|--test)
            noop=1
            ;;
        -p|--prefix)
            prefix="$2"
            shift
            ;;
        -u|--both-de)
            ui=1
            ;;
        *)
            echo "$usage"
            exit 1
            ;;
    esac
    shift
done

[[ $noop -eq 1 ]] && echo "Not performing any operation"

function installYayStuff() {
    echo "installing vscode"
    [[ $noop -eq 0 ]] && yay -Sy code || { echo "error installing vscode"; exit 1; }
}

function installFonts() {
    echo "Getting and setting up otf-overpass ttf-ubuntu-font-family awesome-terminal-fonts otf-font-awesome ttf-font-awesome powerline-fonts"
    [[ $noop -eq 0 ]] && sudo pacman -Sy otf-overpass ttf-ubuntu-font-family awesome-terminal-fonts {otf,ttf}-font-awesome powerline-fonts || { echo "could not install fonts"; exit 1; }
    echo "refreshing font cache"
    [[ $noop -eq 0 ]] && fc-cache -fv
}

function moveOlder() {
    echo "Aggressively moving exiting rcs, if they exist"
    cmd="echo"
    [[ $noop -eq 0 ]] && cmd="mv"

    $cmd ${prefix}/.zshrc{,.bak}
    $cmd ${prefix}/.bashrc{,.bak}
    $cmd ${prefix}/.vimrc{,.bak}
}

function prepareMirrors(){
    sudo mv /etc/pacman.d/mirrorlist{,.orig}
    cat >/tmp/mirrorlist <<-EOF
Server = http://mirrors.evowise.com/archlinux/\$repo/os/\$arch
Server = http://mirror.rise.ph/archlinux/\$repo/os/\$arch
Server = http://mirror-hk.koddos.net/archlinux/\$repo/os/\$arch
Server = http://mirrors.kernel.org/archlinux/\$repo/os/\$arch
Server = http://mirror.0x.sg/archlinux/\$repo/os/\$arch
Server = http://mirror.cse.iitk.ac.in/archlinux/\$repo/os/\$arch
EOF
    sudo mv /tmp/mirrorlist /etc/pacman.d/
}

function installCommon(){
    echo "Will install git zsh curl wget axel lua vim arc-gtk-theme xfce4-terminal chromium firefox chrome-gnome-shell xorg-server yay geany networkmanager network-manager-applet redshift openssh"
    [[ $noop -eq 0 ]] && sudo pacman -Sy git zsh curl wget axel lua vim arc-gtk-theme xfce4-terminal chromium firefox chrome-gnome-shell xorg-server yay network-manager network-manager-applet || { echo "could not install common packages"; exit 1; }
}

function installI3Based() {
    echo "Will install i3-gaps i3lock i3status lxappearance"
    [[ $noop -eq 0 ]] && sudo pacman -Sy i3-gaps i3lock i3status lxappearance || { echo "could not install i3 packages"; exit 1; }
}


function installGnomeshell() {
    echo "Will install gnome-shell gnome-session gnome-search-tool gnome-backgrounds gnome-control-center gnome-tweak-tool"
    [[ $noop -eq 0 ]] && sudo pacman -Sy gnome-shell gnome-session gnome-search-tool gnome-backgrounds || { echo "could not install gnome packages"; exit 1; }
}

function installLoginMgr(){
    [[ $1 -eq 1 ]] && lm="gdm" || lm="lightdm lightdm-gtk-greeter"
    echo "installing $lm"
    [[ $noop -eq 0 ]] && sudo pacman -Sy "$lm" || { echo "unable to install login mgr"; exit 1; }
}

function installZsh() {
    [[ -e "$prefix/.oh-my-zsh" ]] && { echo "oh-my-zsh exists"; return; }
    echo "Will clone and install oh-my-zsh"
    [[ $noop -eq 0 ]] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

function installVim() {
    [[ -e '~/.vim/autoload/plug.vim' ]] && { echo "plug.vim exists"; return; }
    echo "Will clone and install vim plug"
    [[ $noop -eq 0 ]] && curl -fLo ~/.vim/autoload/plug.vim --create-dirs 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
}

function clonePrograms() {
    [[ -e "$prefix/programs" ]] && { echo "programs exists"; return; }
    echo "Cloning programs into ~"
    [[ $noop -eq 0 ]] && git clone https://github.com/smjn/programs "$prefix/programs"
}

function dictionary() {
    #dictionary
    echo "Downloading and setting up stardict"
    if [[ $noop -eq 0 ]]; then
        wget 'https://www.dropbox.com/s/f293v4w310inrut/stardict.tgz?dl=0' -O /tmp/stardict.tgz
        tar -xvf /tmp/stardict.tgz -C ${prefix}
    fi
}

function makeDirs() {
    echo "Will make if needed ${prefix}/.config/{i3,xfce4/terminal}"
    if [[ $noop -eq 0 ]]; then
        mkdir -p ${prefix}/.config/{i3,xfce4/terminal}
    fi
}

function setupMiscLinks() {
    echo "setting up misc links"
    # sudo ln -sf /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh
}

function setupRcs() {
    for i in $(ls -a)
    do
        case "$i" in
            .oh-my-zsh)
                for theme in `ls "$i"`
                do
                    echo "${prefix}/.oh-my-zsh/themes/$theme -> ${repo}/.oh-my-zsh/themes/$theme"
                    if [[ $noop -eq 0 ]]; then
                        ln -sf "${repo}/.oh-my-zsh/themes/$theme" "${prefix}/.oh-my-zsh/themes/$theme"
                    fi
                done
                ;;
            .config)
                echo "${prefix}/.config/xfce4/terminal/terminalrc -> ${repo}/.config/xfce4/terminal/terminalrc"
                echo "${prefix}/.config/redshift.conf -> ${repo}/.config/redshift.conf"
                echo "${prefix}/.config/i3/config ${repo}/.config/i3/config"
                if [[ $noop -eq 0 ]]; then
                    ln -sf ${repo}/.config/xfce4/terminal/terminalrc ${prefix}/.config/xfce4/terminal/terminalrc
                    ln -sf ${repo}/.config/i3/config ${prefix}/.config/i3/config
                    ln -sf ${repo}/.config/redshift.conf ${prefix}/.config/redshift.conf
                fi
                ;;
            vimrc.local)
                echo "${prefix}/vimrc.local -> ${repo}/vimrc.local"
                [[ $noop -eq 0 ]] && ln -sf ${repo}/vimrc.local ${prefix}/vimrc.local
                ;;
            ".zshrc" | ".bashrc" | ".vimrc" | ".i3status.conf" | ".dircolors")
                echo "${prefix}/$i -> ${repo}/$i"
                [[ $noop -eq 0 ]] && ln -sf ${repo}/$i ${prefix}/$i
                ;;
            "wall.png")
                [[ -e ${prefix}/$i ]] && { echo "wallpaper link exists"; return; }
                echo "${prefix}/$i -> ${repo}/$i \n ${prefix}/Pictures/$i -> ${repo}/$i"
                ln -sf ${repo}/$i ${prefix}/$i
                [[ -d ${prefix}/Pictures ]] && ln -sf ${repo}/$i ${prefix}/Pictures/$i
                ;;
            *)
                echo "Ignoring $i"
                ;;
        esac
    done
}

function setupSysdServices() {
    sudo systemctl enable NetworkManager sshd
    [[ $1 -eq 0 ]] && sudo systemctl enable lightdm || sudo systemctl enable gdm
    sudo systemctl disable netctl netctl-auto
}

if [[ $noop -eq 0 ]]; then
    installCommon
    installI3Based
    [[ $ui -eq 1 ]] && installGnomeshell
    installLoginMgr $ui
    installZsh
    installVim
    installFonts
    clonePrograms
    moveOlder
    makeDirs
    setupMiscLinks
    setupRcs
    dictionary
    setupSysdServices $ui
fi

