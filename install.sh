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
	wget -L 'https://github.com/RedHatBrand/Overpass/releases/download/3.0.2/overpass-desktop-fonts.zip' -O /tmp/overpass.zip
	7z x /tmp/overpass.zip
	mv overpass overpass-mono ~/.local/share/fonts/

	#ubuntu fonts
	wget 'https://www.dropbox.com/s/dbgpjjt13hurczq/fonts.tgz?dl=0' -O /tmp/fonts.tgz
	tar -xvf /tmp/fonts.tgz -C ${prefix}/.local/share

    #font awesome
    wget -L https://fontawesome.com/v4.7.0/assets/font-awesome-4.7.0.zip -O /tmp/awesome.zip
    unzip /tmp/awesome.zip -d ~/.local/share/fonts/

	fc-cache -fv
}

function installDownloads() {
	#chrome
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
	sudo apt-get update && sudo apt install google-chrome-stable
	
	#firefox relies on the chrome installations .desktop file
	wget -L 'https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US' -O /tmp/firefox.tar.bz2
	pushd /tmp
	tar -xvf firefox.tar.bz2
	sudo mv firefox /opt/firefox
	popd
	cp /usr/share/applications/google-chrome.desktop /tmp/firefox-quantum.desktop
	sed -i -e 's/Google.*/Firefox Quantum/' -e 's#/usr/bin/google.*#/opt/firefox/firebox %U#' -e 's/Icon=google.*/Icon=firefox/' /tmp/firefox-quantum.desktop
	sudo mv /tmp/firefox-quantum.desktop /usr/share/applications/
	
	#vscode
	wget -L 'https://go.microsoft.com/fwlink/?LinkID=760868' -O /tmp/code.deb
	sudo dpkg -i /tmp/code.deb
	sudo apt-get -f install
	
	#bumblebee status
	git clone git://github.com/tobi-wan-kenobi/bumblebee-status ${prefix}/.bumblebee
	sudo apt-get install python-pip
	sudo pip install psutil netifaces requests power i3ipc
    sudo pip install dbus
}

for i in $(ls -a)
do
	[[ "$i" = "install.sh" || "$i" = ".gitignore" || ! -f "$i" || -e "${prefix}/$i" || "$i" == "README.md" || "$i" == "soft.sh" || "$i" == "login.sh" || "$i" == "vimrc.local" ]] && continue
	echo "${prefix}/$i -> ${repo}/$i";
	[[ $noop -eq 0 ]] && ln -sf ${repo}/$i ${prefix}/$i;
done

echo "${prefix}/.oh-my-zsh/themes/sushant.zsh-theme -> ${repo}/.oh-my-zsh/themes/sushant.zsh-theme"
echo "${prefix}/.config/xfce4/terminal/terminalrc -> ${repo}/.config/xfce4/terminal/terminalrc"

if [[ $noop -eq 0 ]]; then
	sudo apt-get update && sudo apt-get install git p7zip-full zsh curl axel i3 rofi vim vim-nox emacs libclang1 libclang-dev build-essential || { echo "could not install deps"; exit 1; }
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    #setup vim-plug
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	installFonts
	installDownloads

	git clone https://github.com/smjn/programs ~/programs
	mv ${prefix}/.zshrc{,.bak}
	mv ${prefix}/.bashrc{,.bak}
	mv ${prefix}/.vimrc{,.bak}
    mv ${prefix}/.emacs{,.bak}

	mkdir -p ${prefix}/.config/{i3,xfce4/terminal}
	ln -sf ${repo}/.oh-my-zsh/themes/sushant.zsh-theme ${prefix}/.oh-my-zsh/themes/sushant.zsh-theme
	ln -sf ${repo}/.config/xfce4/terminal/terminalrc ${prefix}/.config/xfce4/terminal/terminalrc
	ln -sf ${repo}/.oh-my-zsh/themes/maran2.zsh-theme ${prefix}/.oh-my-zsh/themes/maran2.zsh-theme
	ln -sf ${repo}/.zshrc ${prefix}/.zshrc
	ln -sf ${repo}/.bashrc ${prefix}/.bashrc
	ln -sf ${repo}/.vimrc ${prefix}/.vimrc
	ln -sf ${repo}/.emacs.d/init.el ${prefix}/.emacs.d/init.el
	ln -sf ${repo}/.emacs.d/init ${prefix}/.emacs.d/init
	ln -sf ${repo}/wall.png ${prefix}/wall.png
	sudo ln -sf ${repo}/vimrc.local /etc/vim/vimrc.local


	ln -sf ${repo}/.config/i3/config ${prefix}/.config/i3/config
	ln -sf ${repo}/.i3status.conf ${prefix}/.i3status.conf

	git clone https://github.com/powerline/fonts /tmp/fonts
	bash /tmp/fonts/install.sh

	#dictionary
	wget 'https://www.dropbox.com/s/f293v4w310inrut/stardict.tgz?dl=0' -O /tmp/stardict.tgz
	tar -xvf /tmp/stardict.tgz -C ${prefix}
fi

