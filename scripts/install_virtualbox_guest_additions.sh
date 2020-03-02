#!/bin/bash

##
# @reference    How to Install VirtualBox Guest Additions on Ubuntu 18.04
#               https://linuxize.com/post/how-to-install-virtualbox-guest-additions-in-ubuntu/
##

source util.sh

sudo apt-get update
Install_Packages build-essential dkms linux-headers-$(uname -r)

sudo updatedb

installer_path=$(locate VBoxLinuxAdditions.run)
if [ $(wc -l <<< "$installer_path") -eq 1 ]; then
    sudo sh "$installer_path"
fi

#sudo shutdown -r now
