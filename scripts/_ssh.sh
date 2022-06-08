#!/bin/bash

set -e

THIS_DIR=$(dirname "$0")

DEFAULT_KEY_FILE_NAME="id_ed25519"
PPLUS_KEY_FILE_NAME="id_ed25519_pplus"
EVEN_KEY_FILE_NAME="id_ed25519_even"

DEFAULT_KEY_FILE="$HOME/.ssh/$DEFAULT_KEY_FILE_NAME"

if [ -f "$DEFAULT_KEY_FILE" ]; then
    echo "SSH Key file '$DEFAULT_KEY_FILE' already existed."
    exit 0
fi

##
# @reference    Generating a new SSH key and adding it to the ssh-agent
#               https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
#
GenerateSshKey() {
    local USER_NAME="$1"
    local KEY_FILE_NAME="$2"

    $THIS_DIR/ssh_keygen.exp "$USER_NAME@$(hostname)" $HOME $KEY_FILE_NAME

    ssh-add "$HOME/.ssh/$KEY_FILE_NAME"
}

eval "$(ssh-agent)"

GenerateSshKey $(whoami) $DEFAULT_KEY_FILE_NAME
GenerateSshKey "even" $EVEN_KEY_FILE_NAME
GenerateSshKey "pplus" $PPLUS_KEY_FILE_NAME
