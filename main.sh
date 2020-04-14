#!/bin/bash

THIS_DIR=$(dirname "$0")
source "$THIS_DIR/scripts/util.sh"


# Don't run this script as sudo, as required by git.sh
if [ "$EUID" -eq 0 ]; then
    Echo_Error "Error: Cannot run as root."
    exit 1
fi


MAIN_DIR=$THIS_DIR
SCRIPT_DIR=$MAIN_DIR/scripts


# Run selected scripts
pushd $SCRIPT_DIR
    SELECTED_SCRIPTS=( $(ls _*) )

    for script in "${SELECTED_SCRIPTS[@]}"; do
        echo "\n\nRunning script: $script"
        ./$script
    done

    ./config.sh
popd
