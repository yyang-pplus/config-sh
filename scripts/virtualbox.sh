#!/bin/bash

THIS_DIR=$(dirname "$0")
source "$THIS_DIR/util.sh"

echo "Fixing VM shared folder permission issue."
sudo usermod -aG vboxsf $(whoami)
sudo grep "vboxsf" /etc/group

##
# @reference    How to Install VirtualBox Guest Additions on Ubuntu 18.04
#               https://linuxize.com/post/how-to-install-virtualbox-guest-additions-in-ubuntu/
# @reference    Install VirtualBox Guest Additions in CentOS, RHEL & Fedora
#               https://www.tecmint.com/install-virtualbox-guest-additions-in-centos-rhel-fedora/
##
echo "Installing VirtualBox Guest Additions."
if isRedHat; then
    sudo yum -y install epel-release
    sudo yum -y install make gcc kernel-headers kernel-devel perl dkms bzip2
    export KERN_DIR=/usr/src/kernels/$(uname -r)
else
    sudo apt --yes install build-essential dkms linux-headers-$(uname -r)
fi

installer_path=$(find /media/ -name "VBoxLinuxAdditions.run")
if [ $(wc -l <<< "$installer_path") -eq 1 ]; then
    echo "Running installer '$installer_path'"
    sudo bash "$installer_path"
else
    Fatal "Installer not found. Please insert Guest Additions CD."
fi

#sudo shutdown -r now
