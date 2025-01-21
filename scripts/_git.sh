#!/bin/bash

# Don't run this script as sudo

set -ex

THIS_DIR=$(dirname "$0")
source "$THIS_DIR/util.sh"

if which git &> /dev/null; then
    BASE_URL="https://raw.githubusercontent.com/git/git/refs/heads/master/contrib/completion"

    COMPLETION_SCRIPT_NAME="git-completion.bash"
    wget --no-check-certificate -O /tmp/$COMPLETION_SCRIPT_NAME "$BASE_URL/$COMPLETION_SCRIPT_NAME"
    mv /tmp/$COMPLETION_SCRIPT_NAME $HOME/.git-completion.sh

    PROMPT_SCRIPT_NAME="git-prompt.sh"
    wget --no-check-certificate -O /tmp/$PROMPT_SCRIPT_NAME "$BASE_URL/$PROMPT_SCRIPT_NAME"
    mv /tmp/$PROMPT_SCRIPT_NAME $HOME/.$PROMPT_SCRIPT_NAME
fi
