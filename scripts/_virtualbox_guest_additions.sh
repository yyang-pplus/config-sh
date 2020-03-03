#!/bin/bash


THIS_DIR=$(dirname "$0")
source "$THIS_DIR/util.sh"


##
# @reference    How to Install VirtualBox Guest Additions on Ubuntu 18.04
#               https://linuxize.com/post/how-to-install-virtualbox-guest-additions-in-ubuntu/
##
Install_Packages build-essential dkms linux-headers-$(uname -r)

sudo updatedb

installer_path=$(locate VBoxLinuxAdditions.run)
if [ $(wc -l <<< "$installer_path") -eq 1 ]; then
    sudo sh "$installer_path"
else
    Echo_Error "Installer not found."
fi

#sudo shutdown -r now
