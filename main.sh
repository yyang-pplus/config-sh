#!/bin/bash

set -e

MAIN_DIR=$(dirname "$0")
MAIN_DIR=$(realpath "$MAIN_DIR")
SCRIPT_DIR=$MAIN_DIR/scripts

$SCRIPT_DIR/config.sh
$SCRIPT_DIR/dependencies.sh
