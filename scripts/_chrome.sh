#!/bin/bash

THIS_DIR=$(dirname "$0")
source "$THIS_DIR/util.sh"

##
# @reference    How to Install Google Chrome Web Browser on Ubuntu 18.04
#               https://linuxize.com/post/how-to-install-google-chrome-web-browser-on-ubuntu-18-04/
# @reference    How to Install Google Chrome Web Browser on CentOS 7
#               https://linuxize.com/post/how-to-install-google-chrome-web-browser-on-centos-7/
##
temp_dir=$(date +%s)
mkdir $temp_dir
pushd $temp_dir
if [ -f /etc/debian_version ]; then
    PACKAGE_NAME="google-chrome-stable_current_amd64.deb"
else
    PACKAGE_NAME="google-chrome-stable_current_x86_64.rpm"
fi

wget "https://dl.google.com/linux/direct/$PACKAGE_NAME"

if [ -f /etc/debian_version ]; then
    Install_Packages "./$PACKAGE_NAME"
else
    sudo yum --assumeyes localinstall "$PACKAGE_NAME"
fi
popd
rm -rf "$temp_dir"
