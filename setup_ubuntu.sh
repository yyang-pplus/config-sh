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

sudo apt --yes install git

SETUP_SCRIPT_NAME="setup_common.sh"
wget --no-check-certificate -O /tmp/$SETUP_SCRIPT_NAME "https://raw.githubusercontent.com/yyang-pplus/config-sh/master/$SETUP_SCRIPT_NAME"
bash /tmp/$SETUP_SCRIPT_NAME

# Require config.sh to run first
source "$HOME/.bashrc"
source "$HOME/.bash_util.sh"

CONFIG_SH_ROOT_DIR="$PROJECTS_DIR/config-sh"
source "$CONFIG_SH_ROOT_DIR/scripts/util.sh"

pushd "$CONFIG_SH_ROOT_DIR"
git remote set-url origin git@github-pplus:yyang-pplus/config-sh.git
popd

PPLUS_KEY_FILE_NAME="id_ed25519_pplus"
EVEN_KEY_FILE_NAME="id_ed25519_even"

AddSshKeyTo $PPLUS_KEY_FILE_NAME "https://github.com/settings/keys"
AddSshKeyTo $EVEN_KEY_FILE_NAME "https://github.com/settings/keys"

## The following parts require SSH key been added to github

pushd "$PROJECTS_DIR"
ACTIVE_EVEN_PROJECTS=(algorithms)
for a_project in ${ACTIVE_EVEN_PROJECTS[@]}; do
    if [ ! -d "$a_project" ]; then
        printf "\nDownloading project $a_project\n"
        git clone --recurse-submodules -j8 "git@github-even:yyang-even/$a_project.git"
    fi
done

ACTIVE_PPLUS_PROJECTS=(script-sh)
for a_project in ${ACTIVE_PPLUS_PROJECTS[@]}; do
    if [ ! -d "$a_project" ]; then
        printf "\nDownloading project $a_project\n"
        git clone --recurse-submodules -j8 "git@github-pplus:yyang-pplus/$a_project.git"
    fi
done

ALL_PROJECTS=($(ls))
for one_project in "${ALL_PROJECTS[@]}"; do
    if [ -d "$one_project/.git" ]; then

        pushd "$one_project"

        $CONFIG_SH_ROOT_DIR/scripts/git/install_hooks.sh
        $CONFIG_SH_ROOT_DIR/scripts/git/config_to_initial_account.sh
        popd
    fi
done

pushd algorithms
./scripts/setup.sh || true
popd
popd
