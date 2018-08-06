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

function installFonts() {
    #overpass
    echo "Getting and setting up overpass fonts"
    if [[ $noop -eq 0 ]]; then
        wget -L 'https://github.com/RedHatBrand/Overpass/releases/download/3.0.2/overpass-desktop-fonts.zip' -O /tmp/overpass.zip
        7z x /tmp/overpass.zip
        mv overpass overpass-mono ~/.local/share/fonts/
    fi

    #ubuntu fonts
    echo "Getting and setting up ubuntu fonts"
    if [[ $noop -eq 0 ]]; then
        wget 'https://www.dropbox.com/s/dbgpjjt13hurczq/fonts.tgz?dl=0' -O /tmp/fonts.tgz
        tar -xvf /tmp/fonts.tgz -C ${prefix}/.local/share
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
        sudo apt-get update && sudo apt install google-chrome-stable
    fi

    #firefox relies on the chrome installations .desktop file
    echo "Getting and setting up firefox quantum"
    if [[ $noop -eq 0 ]]; then
        wget -L 'https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US' -O /tmp/firefox.tar.bz2
        pushd /tmp
        tar -xvf firefox.tar.bz2
        sudo mv firefox /opt/firefox
        popd
        cp /usr/share/applications/google-chrome.desktop /tmp/firefox-quantum.desktop
        sed -i -e 's/Google.*/Firefox Quantum/' -e 's#/usr/bin/google.*#/opt/firefox/firebox %U#' -e 's/Icon=google.*/Icon=firefox/' /tmp/firefox-quantum.desktop
        sudo mv /tmp/firefox-quantum.desktop /usr/share/applications/
    fi

    #vscode
    echo "Getting and setting up vscode"
    if [[ $noop -eq 0 ]]; then
        wget -L 'https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US' -O /tmp/firefox.tar.bz2
        wget -L 'https://go.microsoft.com/fwlink/?LinkID=760868' -O /tmp/code.deb
        sudo dpkg -i /tmp/code.deb
        sudo apt-get -f install
    fi

    #bumblebee status
    echo "Getting and setting up bumblebee-status"
    if [[ $noop -eq 0 ]]; then
        wget -L 'https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US' -O /tmp/firefox.tar.bz2
        git clone git://github.com/tobi-wan-kenobi/bumblebee-status ${prefix}/.bumblebee
        sudo apt-get install python-pip
        sudo pip install psutil netifaces requests power i3ipc
        sudo pip install dbus
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
    echo "Will install git p7zip-full zsh curl axel i3 rofi vim vim-nox emacs libclang1 libclang-dev build-essential clojure sbcl ghc"
    [[ $noop -eq 0 ]] && sudo apt-get update && sudo apt-get install git p7zip-full zsh curl axel i3 rofi vim vim-nox emacs libclang1 libclang-dev build-essential clojure sbcl ghc|| { echo "could not install deps"; exit 1; }
}

function installZsh() {
    echo "Will clone and install oh-my-zsh"
    [[ $noop -eq 0 ]] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

function installVim() {
    echo "Will clone and install vim plug"
    [[ $noop -eq 0 ]] && curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

function clonePrograms() {
    echo "Cloning programs into ~"
    [[ $noop -eq 0 ]] && git clone https://github.com/smjn/programs ~/programs
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
    echo "Will make if needed ${prefix}/.emacs.d ${prefix}/.config/{i3,xfce4/terminal}"
    if [[ $noop -eq 0 ]]; then
        mkdir -p ${prefix}/.emacs.d
        mkdir -p ${prefix}/.config/{i3,xfce4/terminal}
    fi
}

function setupRcs() {
    for i in $(ls -a)
    do
        case "$i" in
            .emacs.d)
                echo "${prefix}/.emacs.d/init.el -> ${repo}/.emacs.d/init.el"
                echo "${prefix}/.emacs.d/init -> ${repo}/.emacs.d/init"
                if [[ $noop -eq 0 ]]; then
                    ln -sf ${repo}/.emacs.d/init.el ${prefix}/.emacs.d/init.el
                    ln -sf ${repo}/.emacs.d/init ${prefix}/.emacs.d/init
                fi
                ;;
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
                echo "${prefix}/.config/i3/config ${repo}/.config/i3/config"
                if [[ $noop -eq 0 ]]; then
                    ln -sf ${repo}/.config/xfce4/terminal/terminalrc ${prefix}/.config/xfce4/terminal/terminalrc
                    ln -sf ${repo}/.config/i3/config ${prefix}/.config/i3/config
                fi
                ;;
            vimrc.local)
                echo "/etc/vim/vimrc.local -> ${repo}/vimrc.local"
                [[ $noop -eq 0 ]] && sudo ln -sf ${repo}/vimrc.local /etc/vim/vimrc.local
                ;;
            ".zshrc" | ".bashrc" | ".vimrc" | "wall.png" | ".i3status.conf")
                echo "${prefix}/$i -> ${repo}/$i"
                [[ $noop -eq 0 ]] && ln -sf ${repo}/$i ${prefix}/$i
                ;;
            *)
                echo "Ignoring $i"
                ;;
        esac
    done
}

if [[ $noop -eq 0 ]]; then
    installAptStuff
    installZsh
    installVim
    installFonts
    installDownloads
    clonePrograms
    moveOlder
    makeDirs
    setupRcs
    dictionary
fi

