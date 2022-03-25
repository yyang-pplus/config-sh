#!/bin/bash

THIS_DIR=$(dirname "$0")
source "$THIS_DIR/util.sh"

set -e

if which google-chrome &> /dev/null; then
    echo "Chrome already installed."
    exit 0
fi

##
# @reference    How to Install Google Chrome Web Browser on Ubuntu 18.04
#               https://linuxize.com/post/how-to-install-google-chrome-web-browser-on-ubuntu-18-04/
# @reference    How to Install Google Chrome Web Browser on CentOS 7
#               https://linuxize.com/post/how-to-install-google-chrome-web-browser-on-centos-7/
##
temp_dir="/tmp/$(date +%s)"
mkdir $temp_dir

pushd $temp_dir
if isDebian; then
    PACKAGE_NAME="google-chrome-stable_current_amd64.deb"
else
    PACKAGE_NAME="google-chrome-stable_current_x86_64.rpm"
fi

wget "https://dl.google.com/linux/direct/$PACKAGE_NAME"

if isDebian; then
    sudo apt --yes install "./$PACKAGE_NAME"
else
    sudo yum --assumeyes localinstall "$PACKAGE_NAME"
fi
popd

rm -rf "$temp_dir"
