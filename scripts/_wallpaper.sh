#!/bin/bash

set -e

THIS_DIR=$(dirname "$0")
source "$THIS_DIR/util.sh"

if isRedHat; then
    echo "Setting wallpaper only works on Ubuntu for now."
    exit 0
fi

if ! which xdpyinfo &> /dev/null; then
    echo "Skip setting wallpaper: Not desktop."
    exit 0
fi

RESOLUTION=$(xdpyinfo | grep -oP 'dimensions:\s+\K\S+')

FILENAME="vim-shortcuts-blue-1920x1200.png"
if [[ $RESOLUTION == *"2560x1600"* ]]; then
    FILENAME="vim-shortcuts-dark_2560x1600.png"
elif [[ $RESOLUTION == *"2048x1280"* ]]; then
    FILENAME="vim-shortcuts-dark_2560x1600.png"
fi

URI="https://raw.githubusercontent.com/LevelbossMike/vim_shortcut_wallpaper/master/$FILENAME"

wget --no-check-certificate -O $HOME/Pictures/$FILENAME "$URI"

gsettings set org.gnome.desktop.background picture-uri "file:///$HOME/Pictures/$FILENAME"
