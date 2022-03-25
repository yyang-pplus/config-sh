#!/bin/bash

##
# This script suppose to be download and run manually, which means other scripts in this
# repository may not be available.
##

set -e

pushd /tmp
SCRIPT_NAME="setup_ubuntu.sh"
wget -O $SCRIPT_NAME "https://raw.githubusercontent.com/yyang-pplus/config-sh/master/$SCRIPT_NAME" && sh $SCRIPT_NAME
popd

$HOME/projects/config-sh/scripts/virtualbox.sh

mkdir -p /media/sf_VM_Shared/DO_NOT_DELETE/setup
