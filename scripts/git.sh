#!/bin/bash

source util.sh

which git 2> /dev/null
if [ $? -ne 0 ]; then
    #Install git
    Install_Packages git
fi

which git &> /dev/null
if [ $? -eq 0 ]; then
    echo "Previous git settings:"
    git config --list

    #git config --global user.name "YOUR NAME"
    #git config --global user.email "YOUR EMAIL ADDRESS"

    git config --global color.ui true
    git config --global core.autocrlf input
    git config --global core.editor vim
    git config --global grep.lineNumber true

    pushd $HOME
        temp_dir=$(date +%s)
        mkdir $temp_dir
        if [ $? -ne 0 ]; then
            Echo_Error "Error: Failed to create temporary directory: " $temp_dir
            exit 1
        fi
        pushd $temp_dir
            git clone git://git.kernel.org/pub/scm/git/git.git
            if [ $? -ne 0 ]; then
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
