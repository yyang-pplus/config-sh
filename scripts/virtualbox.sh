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
    $SUDO_CMD dnf --assumeyes install epel-release
    $SUDO_CMD dnf --assumeyes install tar bzip2 kernel-devel-$(uname -r) perl gcc make elfutils-libelf-devel
    MEDIA_PATH=/run/media/$(whoami)/
else
    $SUDO_CMD apt --yes install build-essential dkms linux-headers-$(uname -r)
    MEDIA_PATH=/media/
fi

installer_path=$(find $MEDIA_PATH -name "VBoxLinuxAdditions.run" || true)
if [ -z "$installer_path" ]; then
    Fatal "Installer not found. Please insert Guest Additions CD."
else
    echo "Running installer '$installer_path'"
    # The installer returns non-zero if it cannot reload the modules; needs reboot.
    $SUDO_CMD bash "$installer_path" || true

    echo "Fixing VM shared folder permission issue."
    $SUDO_CMD usermod -aG vboxsf $(whoami)
    $SUDO_CMD grep "vboxsf" /etc/group
fi
