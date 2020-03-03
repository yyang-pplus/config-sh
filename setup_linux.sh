#!/bin/bash

##
# This script suppose to be download and run manually, which means it shouldn't depend on
#   other scripts in this repository.
##


if [ "$EUID" -eq 0 ]; then
    echo "Error: Cannot run as root."
    exit 1
fi


##
# @reference    Generating a new SSH key and adding it to the ssh-agent
#               https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
#
echo "\nGenerating a new SSH key."
read -p 'SSH Key ID (user@os.machine.domain): ' key_id
ssh-keygen -t rsa -b 4096 -C "$key_id"

ssh-add $HOME/.ssh/id_rsa


echo "\nAdding the SSH key to my account."
cat $HOME/.ssh/id_rsa.pub
URL="https://review.gerrithub.io/settings/#SSHKeys"
firefox --new-tab "$URL"


echo "\nUpgrading system."
sudo apt --yes update
sudo apt --yes upgrade


sudo apt --yes install git
PROJECTS_DIR="$HOME/projects"
mkdir "$PROJECTS_DIR"


pushd "$PROJECTS_DIR"
    ACTIVE_PROJECTS=(yyLinuxConfig algorithms yyangtech_wordpress_com)
    for a_project in ${ACTIVE_PROJECTS[@]}; do
        echo "\nDownloading project $a_project"
        git clone "ssh://yyang-even@review.gerrithub.io:29418/yyang-even/$a_project" && scp -p -P 29418 yyang-even@review.gerrithub.io:hooks/commit-msg "$a_project/.git/hooks/"
    done


    pushd yyLinuxConfig
        ./main.sh
    popd


    pushd algorithms
        ./scripts/setup.sh
    popd
popd
