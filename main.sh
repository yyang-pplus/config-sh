#!/bin/bash

Smart_Merge() {
    cat --number "$1" "$2" | sort --unique --key 2 | sort --key 1,1 --numeric-sort | cut --fields 2-
}

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
    else
        touch "$home_config"
    fi
    
    #This method doesn't work as files often contains repeated elements, e.g. fi, done, etc.
    #Smart_Merge "$home_config" "$new_config" > "$home_config"
done
