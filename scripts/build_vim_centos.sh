#!/bin/bash

source ~/.bash_util.sh
THIS_DIR=$(dirname "$0")
source "$THIS_DIR/util.sh"

set -e

echo "Usage: $(basename $0) [<vim_root_dir>]"

VIM_ROOT_DIR=${1:-$(pwd)}

if [ ! -d "$VIM_ROOT_DIR/.git" ]; then
    if [ ! -d "$VIM_ROOT_DIR" ]; then
        mkdir --parents "VIM_ROOT_DIR"
    fi

    git clone https://github.com/vim/vim "$VIM_ROOT_DIR"
fi

QuietRun pushd "$VIM_ROOT_DIR"
$SUDO_CMD dnf install -y ncurses ncurses-devel

$SUDO_CMD dnf remove -y vim-enhanced vim-common vim-filesystem vim-X11

make distclean

./configure --with-features=huge --enable-multibyte --enable-rubyinterp=yes --enable-pythoninterp=yes --enable-python3interp=yes --enable-perlinterp=yes --enable-cscope --enable-gui=auto

make

$SUDO_CMD make install
QuietRun popd
