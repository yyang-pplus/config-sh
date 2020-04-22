#!/bin/bash

# Don't run this script as sudo

THIS_DIR=$(dirname "$0")
source "$THIS_DIR/util.sh"


#Install git
Install_Package_If_Necessary git
Install_Package_If_Necessary gitk
Install_Package_If_Necessary meld

if which git &> /dev/null; then
    echo "Previous git settings:"
    git config --list

    git config --global user.name "Yang Yang"
    git config --global user.email "yyang.even@gmail.com"

    git config --global color.ui true

    git config --global core.autocrlf input
    git config --global core.editor vim
    git config --global core.excludesfile ~/.gitignore

    git config --global diff.tool meld
    git config --global diff.guitool meld
    git config --global difftool.prompt false

    git config --global fetch.prune true

    git config --global grep.lineNumber true

    git config --global push.default current    #Other options are not available for versions below 2.0

    pushd $HOME
        temp_dir=$(date +%s)
        mkdir $temp_dir
        pushd $temp_dir
            if ! git clone git://git.kernel.org/pub/scm/git/git.git; then
                Echo_Error "Error: Failed to clone git source."
                exit 1
            fi
        popd
        #Copy git auto completion script
        cp $temp_dir/git/contrib/completion/git-completion.bash $HOME/.git-completion.sh
        #Copy git prompt script
        cp $temp_dir/git/contrib/completion/git-prompt.sh $HOME/.git-prompt.sh
        rm -rf "$temp_dir"
    popd
fi

# To push to gerrit hub
#git push origin HEAD:refs/for/master
