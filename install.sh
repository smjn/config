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

for i in $(ls -a)
do
	[[ "$i" = "install.sh" || "$i" = ".gitignore" || ! -f "$i" || -e "${prefix}/$i" || "$i" == "README.md" || "$i" == "soft.sh" || "$i" == "login.sh" || "$i" == "vimrc.local" ]] && continue
	echo "${prefix}/$i -> ${repo}/$i";
	[[ $noop -eq 0 ]] && ln -sf ${repo}/$i ${prefix}/$i;
done

echo "${prefix}/.config/terminator/config -> ${repo}/.config/terminator/config"
echo "${prefix}/.oh-my-zsh/themes/sushant.zsh-theme -> ${repo}/.oh-my-zsh/themes/sushant.zsh-theme"
echo "${prefix}/.config/xfce4/terminal/terminalrc -> ${repo}/.config/xfce4/terminal/terminalrc"

if [[ $noop -eq 0 ]]; then
	sudo apt-get install git p7zip-full || { echo "could not install deps"; exit 1; }
	git clone https://github.com/smjn/programs ~/programs
	mv ${prefix}/.zshrc{,.bak}
	mv ${prefix}/.bashrc{,.bak}
	mv ${prefix}/.vimrc{,.bak}
	mkdir -p ${prefix}/.config/{terminator,i3,xfce4/terminal}
	ln -sf ${repo}/.config/terminator/config ${prefix}/.config/terminator/config
	ln -sf ${repo}/.oh-my-zsh/themes/sushant.zsh-theme ${prefix}/.oh-my-zsh/themes/sushant.zsh-theme
	ln -sf ${repo}/.config/xfce4/terminal/terminalrc ${prefix}/.config/xfce4/terminal/terminalrc
	ln -sf ${repo}/.oh-my-zsh/themes/maran2.zsh-theme ${prefix}/.oh-my-zsh/themes/maran2.zsh-theme

	ln -sf ${repo}/.config/i3/config ${prefix}/.config/i3/config
	ln -sf ${repo}/.i3status.conf ${prefix}/.i3status.conf

	git clone https://github.com/powerline/fonts /tmp/fonts
	bash /tmp/fonts/install.sh

	wget -L 'https://github.com/RedHatBrand/Overpass/releases/download/3.0.2/overpass-desktop-fonts.zip' -O /tmp/overpass.zip
	7z x /tmp/overpass.zip
	mv overpass overpass-mono ~/.local/share/fonts/
	fc-cache -fv

	wget 'https://www.dropbox.com/s/f293v4w310inrut/stardict.tgz?dl=0' -O /tmp/stardict.tgz
	tar -xvf /tmp/stardict.tgz -C ${prefix}

	wget 'https://www.dropbox.com/s/dbgpjjt13hurczq/fonts.tgz?dl=0' -O /tmp/fonts.tgz
	tar -xvf /tmp/stardict.tgz -C ${prefix}/.local/share
	fc-cache -fv
	
	wget 'https://www.dropbox.com/s/g4f8c43fnlzmzu0/vim.tgz?dl=0' -O /tmp/vim.tgz
	tar -xvf /tmp/vim.tgz -C ${prefix}

	sudo ln -sf ${repo}/vimrc.local /etc/vim/vimrc.local
	ln -sf ${repo}/.config/redshift.conf ${prefix}/.config/redshift.conf

	ln -sf ${prefix}/.vim ${prefix}/.config/nvim
	ln -sf ${repo}/init.vim ${prefix}/.config/nvim/init.vim
fi
