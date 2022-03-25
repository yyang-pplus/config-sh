#!/bin/bash

##
# This script suppose to be download and run manually, which means other scripts in this
# repository may not be available.
##

set -e

SCRIPT_NAME="setup_ubuntu.sh"
wget -O /tmp/$SCRIPT_NAME "https://raw.githubusercontent.com/yyang-pplus/config-sh/master/$SCRIPT_NAME" && bash /tmp/$SCRIPT_NAME

$HOME/projects/config-sh/scripts/virtualbox.sh |& tee "$TMP_DIR/virtualbox.txt"

mkdir -p /media/sf_VM_Shared/DO_NOT_DELETE/setup
