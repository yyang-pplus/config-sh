#!/bin/bash

echo "Usage: $(basename $0) [vim_root_dir]"

WORKING_DIR=$(pwd)
VIM_ROOT_DIR=$WORKING_DIR

# Use the first command argument if possible,
# Use current working directory otherwise
if [ $# -eq 1 ]; then
    if [ -d "$1" ]; then
        VIM_ROOT_DIR="$1"
    fi
fi

pushd "$VIM_ROOT_DIR"
    sudo yum install -y ncurses ncurses-devel

    sudo yum remove -y vim-enhanced vim-common vim-filesystem vim-X11

    make distclean

    ./configure --with-features=huge --enable-multibyte --enable-rubyinterp=yes --enable-pythoninterp=yes --enable-python3interp=yes --enable-perlinterp=yes --enable-cscope --enable-gui=auto

    make

    sudo make install
popd
