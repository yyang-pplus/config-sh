#!/bin/bash

# Don't run this script as sudo, as required by git.sh
if [ "$EUID" -eq 0 ]; then
    echo "Cannot run as root."
    exit 1
fi

set -e

MAIN_DIR=$(dirname "$0")
MAIN_DIR=$(realpath "$MAIN_DIR")
SCRIPT_DIR=$MAIN_DIR/scripts

$SCRIPT_DIR/config.sh
$SCRIPT_DIR/dependencies.sh
