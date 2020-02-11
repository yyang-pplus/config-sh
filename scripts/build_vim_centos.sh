#!/bin/bash

sudo yum install -y ncurses ncurses-devel

sudo yum remove -y vim-enhanced vim-common vim-filesystem vim-X11

./configure --with-features=huge --enable-multibyte --enable-rubyinterp=yes --enable-pythoninterp=yes --enable-python3interp=yes --enable-perlinterp=yes --enable-cscope --enable-gui=auto

pushd src
    make distclean

    make

    sudo make install
popd
