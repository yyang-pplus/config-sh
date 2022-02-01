#!/bin/bash

# Don't run this script as sudo

THIS_DIR=$(dirname "$0")
source "$THIS_DIR/util.sh"

if which git &> /dev/null; then
    echo "Previous git settings:"
    git config --list

    git config --global user.name "Yang Yang"
    git config --global user.email "yyang.pplus@gmail.com"

    git config --global color.ui true

    git config --global core.autocrlf input
    git config --global core.editor vim
    ##
    # @reference    Ignoring files
    #               https://help.github.com/en/github/using-git/ignoring-files
    ##
    git config --global core.excludesfile ~/.gitignore

    git config --global diff.tool meld
    git config --global diff.guitool meld
    git config --global difftool.prompt false

    git config --global fetch.prune true

    git config --global grep.lineNumber true

    # Other options are not available for versions below 2.0
    git config --global push.default current

    set -ex

    temp_dir="/tmp/$(date +%s)"
    mkdir $temp_dir
    git clone https://github.com/git/git "$temp_dir/git"

    # Copy git auto completion script
    cp $temp_dir/git/contrib/completion/git-completion.bash $HOME/.git-completion.sh
    # Copy git prompt script
    cp $temp_dir/git/contrib/completion/git-prompt.sh $HOME/.git-prompt.sh

    rm -rf "$temp_dir"
fi

# To push to gerrit hub
#git push origin HEAD:refs/for/master
