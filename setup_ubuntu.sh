#!/bin/bash

##
# This script suppose to be download and run manually, which means it shouldn't depend on
#   other scripts in this repository.
##

set -ex

if [ "$EUID" -eq 0 ]; then
    echo "Error: Cannot run as root."
    exit 1
fi

##
# @reference    Generating a new SSH key and adding it to the ssh-agent
#               https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
#
printf "\nGenerating a new SSH key.\n"
read -p 'SSH Key ID (user@os.machine.domain): ' key_id
if [ -z "${key_id// /}" ]; then
    echo "Error: Please set SSH Key ID."
    exit 1
fi
ssh-keygen -t rsa -b 4096 -C "$key_id"

ssh-add $HOME/.ssh/id_rsa

printf "\nAdding the SSH key to my account.\n"
cat $HOME/.ssh/id_rsa.pub
URL="https://review.gerrithub.io/settings/#SSHKeys"
firefox --new-tab "$URL"

printf "\nUpgrading system.\n"
sudo apt --yes update
sudo apt --yes upgrade

TMP_DIR="$HOME/tmp"
mkdir "$TMP_DIR"
sudo apt --yes install git
PROJECTS_DIR="$HOME/projects"
mkdir "$PROJECTS_DIR"
pushd "$PROJECTS_DIR"
ACTIVE_PROJECTS=(yyLinuxConfig yyLinuxScripts algorithms yyangtech_wordpress_com)
for a_project in ${ACTIVE_PROJECTS[@]}; do
    printf "\nDownloading project $a_project\n"
    git clone --recurse-submodules -j8 "ssh://yyang-even@review.gerrithub.io:29418/yyang-even/$a_project" && scp -p -P 29418 yyang-even@review.gerrithub.io:hooks/commit-msg "$a_project/.git/hooks/"
done

pushd yyLinuxConfig
./main.sh | tee "$TMP_DIR/config.txt"
popd

pushd algorithms
printf "\n\n"
./scripts/setup.sh | tee "$TMP_DIR/algorithms.txt"
popd
popd
