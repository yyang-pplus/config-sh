#!/bin/bash

THIS_DIR=$(dirname "$0")

CONFIG_DIR=$THIS_DIR/../config
BACKUP_DIR=$HOME/$(date +%s)
SUPPORT_CONFIGS=( $(ls "$CONFIG_DIR") )


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
