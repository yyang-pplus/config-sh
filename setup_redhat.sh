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

PROJECTS_DIR="$HOME/projects"
mkdir -p "$PROJECTS_DIR"

pushd "$PROJECTS_DIR"
ACTIVE_GIT_PROJECTS=(config-sh script-sh)
for a_project in ${ACTIVE_GIT_PROJECTS[@]}; do
    if [ ! -d "$a_project" ]; then
        printf "\nDownloading project $a_project\n"
        git clone --recurse-submodules -j8 "https://github.com/yyang-pplus/$a_project.git"
    fi
done

TMP_DIR="$HOME/tmp"
mkdir -p "$TMP_DIR"

pushd config-sh
./main.sh |& tee "$TMP_DIR/config.txt"
popd
popd
