#!/bin/bash

# This script is only for Ubuntu.

source ~/.bash_util.sh

THIS_DIR=$(dirname "$0")

sudo apt install slapd ldap-utils libldap2-dev
# Config DB
sudo dpkg-reconfigure slapd

source "$THIS_DIR/global_defines.sh"

# This script only works for single normal DIT configuration
if [ "$NUMBER_DB" -ne 1 ]; then
    Error "Multiple DB:"
    echo $DB_DN
    exit 1
fi

# Now we should have only one module config entry
if [ "$NUMBER_MODULE_CONFIG" -ne 1 ]; then
    Error "Multiple module config entries:"
    echo $MODULE_CONFIG_DN
    exit 1
fi

./$THIS_DIR/overlay_memberof.sh
./$THIS_DIR/overlay_refint.sh

# Query current overlay configuration
sudo ldapsearch -H ldapi:// -Y EXTERNAL -b "cn=config" -LLL -Q "objectClass=olcOverlayConfig"
