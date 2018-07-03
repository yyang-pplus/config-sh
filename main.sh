#!/bin/bash

#
# This is the main interface. It does following works in order:
#   1) Run selected scripts, which start with "_"
#   2) Backup existing configuration files
#   3) Append common configuration files to the existing ones
#


# Don't run this script as sudo; as required by git.sh
if [ "$EUID" -eq 0 ]; then
    echo "Error: Cannot run as root."
    exit
fi


MAIN_DIR=$(dirname "$0")
CONFIG_DIR=$MAIN_DIR/config
SCRIPT_DIR=$MAIN_DIR/scripts
BACKUP_DIR=$HOME/$(date +%s)
SUPPORT_CONFIGS=( $(ls "$CONFIG_DIR") )


# Run selected scripts
pushd $SCRIPT_DIR
    SELECTED_SCRIPTS=( $(ls _*) )

    for script in "${SELECTED_SCRIPTS[@]}"; do
        echo "Running script: $script"
        ./$script
    done
popd


mkdir -p "$BACKUP_DIR"
for config_name in "${SUPPORT_CONFIGS[@]}"; do
    home_config=$HOME/.$config_name
    backup=$BACKUP_DIR/.$config_name
    new_config=$CONFIG_DIR/$config_name

    if [ -f "$home_config" ]; then
        echo "Backup existing configuration file to: $backup"
        cp "$home_config" "$backup"
    fi

    #Append common configuration files to the existing ones
    cat "$new_config" >> "$home_config"
done
