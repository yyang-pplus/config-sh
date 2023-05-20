#!/bin/bash

set -e

THIS_DIR=$(dirname "$0")

CONFIG_DIR=$(readlink --canonicalize "$THIS_DIR/../config")
BACKUP_ROOT_DIR=$HOME/$(date +%s)
SUPPORT_CONFIGS=($(ls "$CONFIG_DIR"))

mkdir -p "$BACKUP_ROOT_DIR"

alias_backup=$BACKUP_ROOT_DIR/.alias
echo "Backup existing alias to: $alias_backup"
alias &> "$alias_backup"

for config_name in "${SUPPORT_CONFIGS[@]}"; do
    new_config=$CONFIG_DIR/$config_name

    # Expand '@' file path format to '/' directory path format
    config_name=${config_name//@//}
    home_config=$HOME/.$config_name
    backup=$BACKUP_ROOT_DIR/.$config_name

    mkdir -p $(dirname "$home_config")

    if [ -e "$home_config" ]; then
        if [ ! -L "$home_config" ]; then
            echo "Backup existing configuration file to: $backup"
            mkdir -p $(dirname "$backup")
            mv "$home_config" "$backup"
        fi
    fi

    ln --symbolic --force --no-target-directory "$new_config" "$home_config"
done

OLD_BASH_RC=$BACKUP_ROOT_DIR/.bashrc
if [ -f "$OLD_BASH_RC" ]; then
    LOCAL_BASH_RC=$HOME/.bashrc.local
    if [ ! -f "$LOCAL_BASH_RC" ]; then
        echo "Using existing bashrc as bashrc.local"
        cp "$OLD_BASH_RC" "$LOCAL_BASH_RC"
    fi
fi

chmod 600 $HOME/.ssh/config
