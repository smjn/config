#!/usr/bin/env bash
if ! groups|grep sudo >/dev/null 2>&1; then
    echo "user not a sudoer make him so"
    exit 1
fi

if sudo apt -y update && sudo apt -y install git; then
    git clone https://github.com/smjn/config $HOME/.dotfiles
    cd $HOME/.dotfiles
    ./install $HOME
fi

