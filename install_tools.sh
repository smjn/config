#!/usr/bin/env bash

readonly LOCAL=$HOME/.local
readonly NPM_GLOBAL=$LOCAL/npm-global
readonly LUA_GLOBAL=$LOCAL/lua-global
readonly DOTS=$HOME/.dotfiles
readonly NVIM_LOCAL=$HOME/.config/nvim

function __checkos {
	local OS=$(cat /etc/issue)
	pattern="$1"
	echo "$OS" | grep -iE "$pattern" 2>&1 >/dev/null
	return $?
}

function install_deb {
	sudo apt-get -y update
	# deps
	sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl git cmake zsh zsh-common guake emacs pipx silversearcher-ag ripgrep alacritty
	# pkg mgrs
	sudo apt-get -y install luarocks npm
	# languages
	sudo apt-get -y install clang clang-format nodejs
}

function get_config {
	git clone https://github.com/smjn/config ~/.dotfiles
}

function mkdirs {
	mkdir -p $NPM_GLOBAL $LUA_GLOBAL
}

function so_zshrc {
	source ~/.zshrc
}

function install_lua_tools {
	so_zshrc
	luarocks install --tree $LUA_GLOBAL --server=https://luarocks.org/dev luaformatter
	luarocks install --tree $LUA_GLOBAL luacheck
}

function install_py_tools {
	so_zshrc
	pipx install pyright pynvim neovim cpplint black isort
	pipx install 'python-lsp-server[all]'
}

function install_npm_tools {
	so_zshrc
	npm -g install prettier jshint
}

function install_pyenv {
	git clone https://github.com/pyenv/pyenv.git ~/.pyenv
}

function install_packer {
	git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
}

function install_nvim {
	wget -L https://github.com/neovim/neovim/releases/download/v0.7.2/nvim-linux64.deb -o /tmp/nvim-linux64.deb
	sudo apt -y install /tmp/nvim-linux64.deb
	install_packer
	mkdir -p $NVIM_LOCAL
	ln -sf $DOTS/.config/nvim/init.lua $NVIM_LOCAL/init.lua
	ln -sf $DOTS/.config/nvim/lua $NVIM_LOCAL/lua
}

function setup_zsh {
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	rm -f $HOME/.zshrc
	ln -sf $DOTS/.zshrc $HOME/.zshrc
	ln -sf $DOTS/mytheme.zsh-theme $HOME/.oh-my-zsh/themes/mytheme.zsh-theme
	ln -sf $DOTS/alias.zshrc $HOME/alias.zshrc
}

function install_alacritty {
    git clone https://github.com/eendroroy/alacritty-theme.git ~/.alacritty-colorscheme
}

function get_fonts {
	wget -qL https://download.jetbrains.com/fonts/JetBrainsMono-2.242.zip -o /tmp/jb.zip
	mkdir -p $LOCAL/share/fonts/jb
	unzip /tmp/jb.zip -d LOCAL/share/fonts/jb
	fc-cache -fv
}

function setup_emacs {
	rm -rf $HOME/.emacs.d $HOME/.emacsrc
	mkdir -p $HOME/.emacs.d
	ln -sf $DOTS/.emacs.d/init.el $HOME/.emacs.d/init.el
}

if __checkos 'debian|ubuntu|pop'; then
	install_deb
	get_fonts
	get_config
	mkdirs
	setup_zsh
	install_alacritty
	install_pyenv
	install_nvim
	install_py_tools
	install_lua_tools
	install_npm_tools
	setup_emacs
fi
