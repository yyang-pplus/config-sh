#!/bin/bash

##
# @note	Avoid using bash_util.sh functions in this script.

# Don't run this script as sudo, as required by git.sh
if [ "$EUID" -eq 0 ]; then
    echo "Cannot run as root."
    exit 1
fi

set -e

MAIN_DIR=$(dirname "$0")
SCRIPT_DIR=$MAIN_DIR/scripts

./$SCRIPT_DIR/config.sh
./$SCRIPT_DIR/dependencies.sh
