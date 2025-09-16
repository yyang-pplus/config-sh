#!/bin/bash

set -e

THIS_DIR=$(dirname "$0")
source "$THIS_DIR/util.sh"

##
# @reference    It's too easy to get Windows 11 VM on Linux
#               https://taonaw.com/2025/02/27/yesterday-i-mentioned-i-will.html
##
$SUDO_CMD apt --yes install qemu-kvm libvirt-daemon bridge-utils virt-manager

$SUDO_CMD usermod -aG libvirt $(whoami)
$SUDO_CMD usermod -aG kvm $(whoami)

# Shared Clipboard
# Auto resize VM resolution
$SUDO_CMD apt --yes install spice-vdagent

# Shared Folders
$SUDO_CMD apt --yes install virtiofsd
