#!/bin/bash

##
# This script suppose to be download and run manually, which means other scripts in this
# repository may not be available.
##

set -ex

if [ "$EUID" -eq 0 ]; then
    echo "Error: Cannot run as root."
    exit 1
fi

sudo yum --assumeyes install git

SETUP_SCRIPT_NAME="setup_common.sh"
wget -O /tmp/$SETUP_SCRIPT_NAME "https://raw.githubusercontent.com/yyang-pplus/config-sh/master/scripts/$SETUP_SCRIPT_NAME"
bash /tmp/$SETUP_SCRIPT_NAME

# Require config.sh to run first
source "$HOME/.bash_util.sh"

pushd "$PROJECTS_DIR"
ACTIVE_GIT_PROJECTS=(script-sh)
for a_project in ${ACTIVE_GIT_PROJECTS[@]}; do
    if [ ! -d "$a_project" ]; then
        printf "\nDownloading project $a_project\n"
        git clone --recurse-submodules -j8 "https://github.com/yyang-pplus/$a_project.git"
    fi
done
popd
