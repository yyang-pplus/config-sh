#!/bin/bash

set -ex

THIS_DIR=$(dirname "$0")
source "$THIS_DIR/util.sh"

##
# @reference    How to Install VirtualBox Guest Additions on Ubuntu 18.04
#               https://linuxize.com/post/how-to-install-virtualbox-guest-additions-in-ubuntu/
##
echo "Installing VirtualBox Guest Additions."
if isRedHat; then
    sudo yum --assumeyes install epel-release
    sudo dnf --assumeyes install tar bzip2 kernel-devel-$(uname -r) perl gcc make elfutils-libelf-devel
    MEDIA_PATH=/run/media/$(whoami)/
else
    sudo apt --yes install build-essential dkms linux-headers-$(uname -r)
    MEDIA_PATH=/media/
fi

installer_path=$(find $MEDIA_PATH -name "VBoxLinuxAdditions.run")
if [ -z "$installer_path" ]; then
    Fatal "Installer not found. Please insert Guest Additions CD."
else
    echo "Running installer '$installer_path'"
    # The installer returns non-zero if it cannot reload the modules; needs reboot.
    sudo bash "$installer_path" || true

    echo "Fixing VM shared folder permission issue."
    sudo usermod -aG vboxsf $(whoami)
    sudo grep "vboxsf" /etc/group
fi
