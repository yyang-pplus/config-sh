#!/bin/bash

THIS_DIR=$(dirname "$0")

CONFIG_DIR=$(readlink --canonicalize "$THIS_DIR/../config")
BACKUP_DIR=$HOME/$(date +%s)
SUPPORT_CONFIGS=( $(ls "$CONFIG_DIR") )


mkdir -p "$BACKUP_DIR"

alias_backup=$BACKUP_DIR/.alias
echo "Backup existing alias to: $alias_backup"
alias &> "$alias_backup"

for config_name in "${SUPPORT_CONFIGS[@]}"; do
    home_config=$HOME/.$config_name
    backup=$BACKUP_DIR/.$config_name
    new_config=$CONFIG_DIR/$config_name

    if [ -e "$home_config" ]; then
        if [ ! -L "$home_config" ]; then
            echo "Backup existing configuration file to: $backup"
            mv "$home_config" "$backup"
        fi
    fi

    ln --symbolic --force --no-target-directory "$new_config" "$home_config"
done
