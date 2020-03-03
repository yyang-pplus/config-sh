#!/bin/bash

THIS_DIR=$(dirname "$0")
source "$THIS_DIR/scripts/util.sh"


# Don't run this script as sudo, as required by git.sh
if [ "$EUID" -eq 0 ]; then
    Echo_Error "Error: Cannot run as root."
    exit 1
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
        echo "\n\nRunning script: $script"
        ./$script
    done
popd


mkdir -p "$BACKUP_DIR"

alias_backup=$BACKUP_DIR/.alias
echo "\nBackup existing alias to: $alias_backup"
alias &> "$alias_backup"

for config_name in "${SUPPORT_CONFIGS[@]}"; do
    home_config=$HOME/.$config_name
    backup=$BACKUP_DIR/.$config_name
    new_config=$CONFIG_DIR/$config_name

    if [ -f "$home_config" ]; then
        echo "\nBackup existing configuration file to: $backup"
        cp "$home_config" "$backup"
        rm -r "$home_config"
    fi

    ln -s "$(pwd)/$new_config" "$home_config"
done
