#!/bin/bash

# This script only works for CentOS

THIS_DIR=$(dirname "$0")
source "$THIS_DIR/global_defines.sh"

# This script only works for single normal DIT configuration
if [ "$NUMBER_DB" -ne 1 ]; then
    echo "Error: Multiple DB:"
    echo $DB_DN
    exit 1
fi

./$THIS_DIR/install.sh
./$THIS_DIR/schema.sh
./$THIS_DIR/db_config.sh

# Reload defines
source "$THIS_DIR/global_defines.sh"

# Now we should have only one module config entry
if [ "$NUMBER_MODULE_CONFIG" -ne 1 ]; then
    echo "Error: Multiple module config entries:"
    echo $MODULE_CONFIG_DN
    exit 1
fi

./$THIS_DIR/overlay_memberof.sh
./$THIS_DIR/overlay_refint.sh

# Query current overlay configuration
sudo ldapsearch -H ldapi:// -Y EXTERNAL -b "cn=config" -LLL -Q "objectClass=olcOverlayConfig"
