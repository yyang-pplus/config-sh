#!/bin/bash

THIS_DIR=$(dirname "$0")
source "$THIS_DIR/util.sh"

echo "Fixing VM shared folder permission issue."
sudo usermod -aG vboxsf $(whoami)
sudo grep "vboxsf" /etc/group

##
# @reference    How to Install VirtualBox Guest Additions on Ubuntu 18.04
#               https://linuxize.com/post/how-to-install-virtualbox-guest-additions-in-ubuntu/
##
echo "Installing VirtualBox Guest Additions."
sudo apt --yes install build-essential dkms linux-headers-$(uname -r)

installer_path=$(find /media/ -name "VBoxLinuxAdditions.run")
if [ $(wc -l <<< "$installer_path") -eq 1 ]; then
    echo "Running installer '$installer_path'"
    sudo sh "$installer_path"
else
    Fatal "Installer not found."
fi

#sudo shutdown -r now
