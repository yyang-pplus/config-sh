#!/bin/bash


THIS_DIR=$(dirname "$0")
source "$THIS_DIR/global_defines.sh"


if [ "$NUMBER_DB" -ne 1 ]; then
    echo "Error: Multiple DB:"
    echo $DB_DN
    exit 1
fi

./$THIS_DIR/install.sh
./$THIS_DIR/schema.sh
./$THIS_DIR/db_config.sh
