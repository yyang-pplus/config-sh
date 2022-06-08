#!/bin/bash

##
# This script suppose to be download and run manually, which means other scripts in this
# repository may not be available.
##

# Don't run this script as sudo
if [ "$EUID" -eq 0 ]; then
    echo "Cannot run as root."
    exit 1
fi

set -e

PROJECTS_DIR="$HOME/projects"
mkdir -p "$PROJECTS_DIR"

pushd "$PROJECTS_DIR"
git clone --recurse-submodules -j8 "https://github.com/yyang-pplus/config-sh.git"

TMP_DIR="$HOME/tmp"
mkdir -p "$TMP_DIR"

pushd config-sh
git remote set-url origin git@github-pplus:yyang-pplus/config-sh.git

./main.sh |& tee "$TMP_DIR/config.txt"
popd
popd
