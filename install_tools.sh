#!/usr/bin/env bash

readonly NPM_GLOBAL=$HOME/.local/npm-global
readonly LUA_GLOBAL=$HOME/.local/lua-global

function __checkos {
	local OS=$(cat /etc/issue)
	pattern="$1"
	echo "$OS" | grep -iE "$pattern" 2>&1 >/dev/null
	return $?
}

function install_deb {
	sudo apt-get -y update
	# deps
	sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl git cmake
	# pkg mgrs
	sudo apt-get -y install luarocks npm
	# languages
	sudo apt-get -y install clang clang-format nodejs
}

function mkdirs {
	mkdir -p $NPM_GLOBAL $LUA_GLOBAL
	echo 'export PATH='"$NPM_GLOBAL/bin:$LUA_GLOBAL/bin"':$PATH' >>~/.zshrc
}

function install_lua_tools {
	source ~/.zshrc
	luarocks install --tree $LUA_GLOBAL --server=https://luarocks.org/dev luaformatter
	luarocks install --tree $LUA_GLOBAL luacheck
}

function install_py_tools {
	source ~/.zshrc
	pipx install pyright pynvim neovim cpplint
	pipx install 'python-lsp-server[all]'
}

function install_pyenv {
	git clone https://github.com/pyenv/pyenv.git ~/.pyenv
	echo 'export PYENV_ROOT="$HOME/.pyenv"' >>~/.zshrc
	echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >>~/.zshrc
	echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n eval "$(pyenv init -)"\nfi' >>~/.zshrc
}

function install_nvim {
	wget -L https://github.com/neovim/neovim/releases/download/v0.7.2/nvim-linux64.deb -o /tmp/nvim-linux64.deb
	sudo apt -y install /tmp/nvim-linux64.deb
}

if __checkos 'debian|ubuntu|pop'; then
	install_deb
	mkdirs
	install_pyenv
	install_py_tools
	install_nvim
	install_lua_tools
fi
