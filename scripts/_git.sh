#!/bin/bash

# Don't run this script as sudo

set -ex

THIS_DIR=$(dirname "$0")
source "$THIS_DIR/util.sh"

if which git &> /dev/null; then

    temp_dir="/tmp/$(date +%s)"
    mkdir $temp_dir
    git clone https://github.com/git/git "$temp_dir/git"

    # Copy git auto completion script
    cp $temp_dir/git/contrib/completion/git-completion.bash $HOME/.git-completion.sh
    # Copy git prompt script
    cp $temp_dir/git/contrib/completion/git-prompt.sh $HOME/.git-prompt.sh

    rm -rf "$temp_dir"
fi
