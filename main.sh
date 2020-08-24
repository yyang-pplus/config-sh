#!/bin/bash


##
# @note	Avoid using bash_util.sh functions in this script.

# Don't run this script as sudo, as required by git.sh
if [ "$EUID" -eq 0 ]; then
    echo "Cannot run as root."
    exit 1
fi


set -ex


MAIN_DIR=$(dirname "$0")
SCRIPT_DIR=$MAIN_DIR/scripts


# Run selected scripts
pushd $SCRIPT_DIR
    printf "\n\n"
    # config.sh needs to run first to setup bash_util.sh.
    ./config.sh

    SELECTED_SCRIPTS=( $(ls _*) )

    for script in "${SELECTED_SCRIPTS[@]}"; do
        printf "\n\nRunning script: $script\n"
        ./$script
    done
popd
