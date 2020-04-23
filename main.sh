#!/bin/bash

source ~/.bash_util.sh


# Don't run this script as sudo, as required by git.sh
if [ "$EUID" -eq 0 ]; then
    Echo_Error "Error: Cannot run as root."
    exit 1
fi


THIS_DIR=$(dirname "$0")
MAIN_DIR=$THIS_DIR
SCRIPT_DIR=$MAIN_DIR/scripts


# Run selected scripts
pushd $SCRIPT_DIR
    SELECTED_SCRIPTS=( $(ls _*) )

    for script in "${SELECTED_SCRIPTS[@]}"; do
        printf "\n\nRunning script: $script\n"
        ./$script
    done

    printf "\n\n"
    ./config.sh
popd
