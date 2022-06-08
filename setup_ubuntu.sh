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

UTIL_SCRIPT_NAME="util.sh"
wget -O /tmp/$UTIL_SCRIPT_NAME "https://raw.githubusercontent.com/yyang-pplus/config-sh/master/scripts/$UTIL_SCRIPT_NAME"
source /tmp/$UTIL_SCRIPT_NAME
if GenerateSshKey; then
    AddSshKeyTo "yyang-pplus" "https://github.com/settings/keys"
fi

printf "\nUpgrading system.\n"
sudo apt --yes update
sudo apt --yes upgrade

sudo apt --yes install git

PROJECTS_DIR="$HOME/projects"
mkdir -p "$PROJECTS_DIR"

pushd "$PROJECTS_DIR"
ACTIVE_EVEN_PROJECTS=(algorithms)
for a_project in ${ACTIVE_EVEN_PROJECTS[@]}; do
    if [ ! -d "$a_project" ]; then
        printf "\nDownloading project $a_project\n"
        git clone --recurse-submodules -j8 "git@github.com:yyang-even/$a_project.git"
    fi
done

ACTIVE_PPLUS_PROJECTS=(config-sh script-sh)
for a_project in ${ACTIVE_PPLUS_PROJECTS[@]}; do
    if [ ! -d "$a_project" ]; then
        printf "\nDownloading project $a_project\n"
        git clone --recurse-submodules -j8 "git@github.com:yyang-pplus/$a_project.git"
    fi
done

TMP_DIR="$HOME/tmp"
mkdir -p "$TMP_DIR"

pushd config-sh
./main.sh |& tee "$TMP_DIR/config.txt"
popd

pushd algorithms
printf "\n\n"
./scripts/setup.sh |& tee "$TMP_DIR/algorithms.txt"
popd
popd

if isVirtualBox; then
    mkdir -p /media/sf_VM_Shared/DO_NOT_DELETE/setup
fi
