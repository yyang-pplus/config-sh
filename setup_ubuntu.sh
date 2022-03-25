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

SSH_SCRIPT_NAME="setup_ssh.sh"
wget -O /tmp/$SSH_SCRIPT_NAME "https://raw.githubusercontent.com/yyang-pplus/config-sh/master/scripts/$SSH_SCRIPT_NAME"
bash /tmp/$SSH_SCRIPT_NAME

printf "\nUpgrading system.\n"
sudo apt --yes update
sudo apt --yes upgrade

sudo apt --yes install git

PROJECTS_DIR="$HOME/projects"
mkdir -p "$PROJECTS_DIR"

pushd "$PROJECTS_DIR"
ACTIVE_GERRIT_PROJECTS=(algorithms yyangtech_wordpress_com)
for a_project in ${ACTIVE_GERRIT_PROJECTS[@]}; do
    printf "\nDownloading project $a_project\n"
    git clone --recurse-submodules -j8 "ssh://yyang-even@review.gerrithub.io:29418/yyang-even/$a_project" && scp -p -P 29418 yyang-even@review.gerrithub.io:hooks/commit-msg "$a_project/.git/hooks/"
done

ACTIVE_GIT_PROJECTS=(config-sh script-sh)
for a_project in ${ACTIVE_GIT_PROJECTS[@]}; do
    printf "\nDownloading project $a_project\n"
    git clone --recurse-submodules -j8 "git@github.com:yyang-pplus/$a_project.git"
done

TMP_DIR="$HOME/tmp"
mkdir -p "$TMP_DIR"

pushd config-sh
./main.sh | tee "$TMP_DIR/config.txt"
popd

pushd algorithms
printf "\n\n"
./scripts/setup.sh | tee "$TMP_DIR/algorithms.txt"
popd
popd
