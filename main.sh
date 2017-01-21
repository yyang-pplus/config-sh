#!/bin/bash
#
# This is the main interface. It does following works in order:
#   1) Backup existing configuration files
#   2) Append common configuration files to the existing ones
#

MAIN_DIR=$(dirname "$0")
CONFIG_DIR=$MAIN_DIR/config
SCRIPT_DIR=$MAIN_DIR/scripts
BACKUP_DIR=$HOME/$(date +%s)
SUPPORT_CONFIGS=( $(ls "$CONFIG_DIR") )

mkdir -p "$BACKUP_DIR"

for config_name in "${SUPPORT_CONFIGS[@]}"; do
	home_config=$HOME/.$config_name
    backup=$BACKUP_DIR/.$config_name
    new_config=$CONFIG_DIR/$config_name

    if [ -f "$home_config" ]; then
        echo "Backup existing configuration file to: $backup"
        cp "$home_config" "$backup"
    fi

    cat "$new_config" >> "$home_config"
done
