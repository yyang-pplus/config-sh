#!/bin/bash

set -e

##
# @note This script supposes to be run before other scripts in this repository are available
##

##
# @reference    Generating a new SSH key and adding it to the ssh-agent
#               https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
#
KEY_FILE="$HOME/.ssh/id_rsa"

if [ -f "$KEY_FILE" ]; then
    echo "SSH Key file '$KEY_FILE' already existed."
else

    printf "\nGenerating a new SSH key.\n"
    read -p 'SSH Key ID (user@os.machine.domain): ' key_id
    if [ -z "${key_id// /}" ]; then
        echo "Error: Please set SSH Key ID."
        exit 1
    fi
    ssh-keygen -t rsa -b 4096 -C "$key_id"

    ssh-add $KEY_FILE

    cat $KEY_FILE.pub

    echo "Adding the new SSH key to yyang-even."
    echo "Please close the browser when done."
    GERRIT_URL="https://review.gerrithub.io/settings/#SSHKeys"
    firefox --new-tab "$GERRIT_URL"

    echo "Adding the new SSH key to yyang-pplus."
    echo "Please close the browser when done."
    GIT_URL="https://github.com/settings/keys"
    firefox --new-tab "$GIT_URL"
fi
