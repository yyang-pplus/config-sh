#!/bin/bash

THIS_DIR=$(dirname "$0")
source "$THIS_DIR/util.sh"


##
# @reference    How to Install Google Chrome Web Browser on Ubuntu 18.04
#               https://linuxize.com/post/how-to-install-google-chrome-web-browser-on-ubuntu-18-04/
##
temp_dir=$(date +%s)
mkdir $temp_dir
pushd $temp_dir
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    Install_Packages ./google-chrome-stable_current_amd64.deb
popd
rm -rf "$temp_dir"
