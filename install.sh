#! /bin/bash
noop=0
prefix=""
repo=$(pwd)
[[ $# -eq 0 ]] && { echo "usage ./install.sh [-t|--test] -p|--prefix /prefix/path"; exit 1; }

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
        *)
            echo "usage ./install.sh [-t|--test] -p /prefix/path.."
            exit 1
            ;;
    esac
    shift
done

[[ $noop -eq 1 ]] && echo "Not performing any operation"

function installGolang() {
    [[ -e /opt/go ]] && { echo "go already installed"; return 0; }
    echo "Getting and setting golang from $(wget -q -O - https://golang.org/dl | grep -i 'download downloadBox'|grep -i 'linux'|egrep -o 'https://.*gz')"
    if [[ $noop -eq 0 ]]; then
        wget $(wget -q -O - https://golang.org/dl | grep -i 'download downloadBox'|grep -i 'linux'|egrep -o 'https://.*gz') -O /tmp/go.tgz
        sudo tar -xvf /tmp/go.tgz -C /opt/
    fi
    cat <<EOF |sudo tee >/dev/null /etc/profile.d/setgo.sh
#!/usr/bin/env bash
#get set go
export GOPATH="$prefix/programs/gocode"
export GOBIN="$prefix/programs/gocode/bin"
export GOROOT="/opt/go"
export PATH="$PATH:$GOROOT/bin:$GOBIN"
EOF
}

function installFonts() {
    #ubuntu fonts
    echo "Getting and setting up ubuntu fonts"
    if [[ $noop -eq 0 ]]; then
        wget 'https://www.dropbox.com/s/dbgpjjt13hurczq/fonts.tgz?dl=0' -O /tmp/fonts.tgz
        tar -xvf /tmp/fonts.tgz -C ${prefix}/.local/share
    fi

    #overpass
    echo "Getting and setting up overpass fonts"
    if [[ $noop -eq 0 ]]; then
        wget -L 'https://github.com/RedHatBrand/Overpass/releases/download/3.0.2/overpass-desktop-fonts.zip' -O /tmp/overpass.zip
        7z x /tmp/overpass.zip
        mv overpass overpass-mono ~/.local/share/fonts/
    fi

    #font awesome
    echo "Getting and setting up fontawesome fonts"
    if [[ $noop -eq 0 ]]; then
        wget -L https://fontawesome.com/v4.7.0/assets/font-awesome-4.7.0.zip -O /tmp/awesome.zip
        unzip /tmp/awesome.zip -d ~/.local/share/fonts/
    fi

    #powerline for terminal symbols
    echo "Getting and setting up powerline fonts"
    if [[ $noop -eq 0 ]]; then
        git clone https://github.com/powerline/fonts /tmp/fonts
        bash /tmp/fonts/install.sh
    fi

    [[ $noop -eq 0 ]] && fc-cache -fv
}

function installDownloads() {
    #chrome
    echo "Getting and setting up google chrome"
    if [[ $noop -eq 0 ]]; then
        wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
        sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
        sudo apt -y update && sudo apt -y install google-chrome-stable
        sudo rm -f /etc/apt/sources.list.d/google.list
    fi

    echo "Getting and setting up firefox quantum"
    if [[ $noop -eq 0 ]]; then
        wget -L 'https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US' -O /tmp/firefox.tar.bz2
        pushd /tmp
        tar -xvf firefox.tar.bz2
        sudo mv firefox /opt/firefox
        popd
        cat <<EOF|sudo tee >/dev/null /usr/share/applications/firefox-quantum.desktop
[Desktop Entry]
Version=1.0
Name=Firefox Quantum
GenericName=Web Browser
Comment=Access the Internet
Exec=/opt/firefox/firefox %U
Terminal=false
Icon=firefox
Type=Application
Categories=Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml_xml;image/webp;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;
Actions=new-window;new-private-window;

[Desktop Action new-private-window]
Name=New Incognito Window
Exec=/opt/firefox/firefox %U
EOF
        [[ -e /usr/bin/firefox ]] && sudo mv /usr/bin/firefox{,.bak}
        [[ -e /usr/bin/firefox-esr ]] && sudo mv /usr/bin/firefox-esr{,.bak}
        [[ -e /usr/local/bin/firefox ]] && sudo mv /usr/local/bin/firefox{,.bak}
        sudo ln -sf /opt/firefox/firefox /usr/local/bin/firefox
    fi

    #vscode
    echo "Getting and setting up vscode"
    if [[ $noop -eq 0 ]]; then
        wget -L 'https://go.microsoft.com/fwlink/?LinkID=760868' -O /tmp/code.deb
        sudo dpkg -i /tmp/code.deb
        sudo apt -f install
    fi

    #bumblebee status
    echo "Getting and setting up bumblebee-status"
    if [[ $noop -eq 0 ]]; then
        git clone git://github.com/tobi-wan-kenobi/bumblebee-status ${prefix}/.bumblebee
        sudo apt -y install python-pip
        sudo pip install psutil netifaces requests power i3ipc
    fi
}

function moveOlder() {
    echo "Aggressively moving exiting rcs, if they exist"
    cmd="echo"
    [[ $noop -eq 0 ]] && cmd="mv"

    $cmd ${prefix}/.zshrc{,.bak}
    $cmd ${prefix}/.bashrc{,.bak}
    $cmd ${prefix}/.vimrc{,.bak}
    $cmd ${prefix}/.emacs{,.bak}
    $cmd ${prefix}/.emacs.d{,.bak}
}

function installAptStuff() {
    echo "Will install git p7zip-full zsh curl axel i3 rofi vim vim-nox emacs libclang1 libclang-dev build-essential clojure sbcl ghc arc-theme lxappearance software-properties-common xfce4-terminal and optional tilix redshift"
    [[ $noop -eq 0 ]] && sudo apt -y update && sudo apt -y install tilix redshift-gtk
    [[ $noop -eq 0 ]] && sudo apt -y update && sudo apt -y install git p7zip-full zsh curl axel i3 rofi vim vim-nox emacs libclang1 libclang-dev build-essential clojure sbcl ghc arc-theme lxappearance software-properties-common xfce4-terminal||{ echo "could not install deps"; exit 1; }
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

function installSpacemacs() {
    [[ -e "$prefix/.spacemacs" ]] && { echo "spacemacs exists"; return; }
    echo "Will clone spaceemacs repo"
    [[ $noop -eq 0 ]] && git clone https://github.com/syl20bnr/spacemacs ${prefix}/.emacs.d
}

function clonePrograms() {
    [[ -e "$prefix/programs" ]] && { echo "programs exists"; return; }
    echo "Cloning programs into ~"
    [[ $noop -eq 0 ]] && git clone https://github.com/smjn/programs "$prefix/programs"
}

function addPPAs() {
    declare -A ppas
    ppas[ppa:snwh/ppa]=bionic
    ppas[ppa:numix/ppa]=bionic
    ppas[ppa:noobslab/icons]=bionic
    ppas[ppa:noobslab/themes]=bionic

    for k in "${!ppas[@]}"; do
        echo "Adding ppa $k ${ppas[$k]}"
        [[ $noop -eq 0 ]] && . ~/programs/bash/addppa.sh $k ${ppas[$k]}
    done

    [[ $noop -eq 0 ]] && sudo apt -y update && sudo apt -y install paper-icon-theme numix-icon-theme
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
    sudo ln -sf /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh
}

function setupRcs() {
    for i in $(ls -a)
    do
        case "$i" in
            .oh-my-zsh)
                echo "${prefix}/.oh-my-zsh/themes/sushant.zsh-theme -> ${repo}/.oh-my-zsh/themes/sushant.zsh-theme"
                echo "${prefix}/.oh-my-zsh/themes/maran2.zsh-theme -> ${repo}/.oh-my-zsh/themes/maran2.zsh-theme"
                if [[ $noop -eq 0 ]]; then
                    ln -sf ${repo}/.oh-my-zsh/themes/sushant.zsh-theme ${prefix}/.oh-my-zsh/themes/sushant.zsh-theme
                    ln -sf ${repo}/.oh-my-zsh/themes/maran2.zsh-theme ${prefix}/.oh-my-zsh/themes/maran2.zsh-theme
                fi
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
            .spacemacs)
                echo "${prefix}/.spacemacs -> ${repo}/.spacemacs"
                [[ $noop -eq 0 ]] && ln -sf ${repo}/.spacemacs ${prefix}/.spacemacs
                ;;
            vimrc.local)
                echo "/etc/vim/vimrc.local -> ${repo}/vimrc.local"
                [[ $noop -eq 0 ]] && sudo ln -sf ${repo}/vimrc.local /etc/vim/vimrc.local
                ;;
            ".zshrc" | ".bashrc" | ".vimrc" | ".i3status.conf")
                echo "${prefix}/$i -> ${repo}/$i"
                [[ $noop -eq 0 ]] && ln -sf ${repo}/$i ${prefix}/$i                
                ;;
            "wall.png")
                [[ -e ${prefix}/$i ]] && { echo "wallpaper link exists"; return; }
                echo "${prefix}/$i -> ${repo}/$i \n ${prefix}/Pictures/$i -> ${repo}/$i"
                ln -sf ${repo}/$i ${prefix}/$i
                ln -sf ${repo}/$i ${prefix}/Pictures/$i
                ;;
            *)
                echo "Ignoring $i"
                ;;
        esac
    done
}

if [[ $noop -eq 0 ]]; then
    installAptStuff
    installGolang
    installZsh
    installVim
    installFonts
    installDownloads
    clonePrograms
    addPPAs
    moveOlder
    installSpacemacs
    makeDirs
    setupMiscLinks
    setupRcs
    dictionary
fi

