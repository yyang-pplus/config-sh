#!/bin/bash

# This script config olcSuffix and olcRootDN to the desired value. It also prompt to set olcRootPW.
#   It determines the DN of the database automatically if there is only one DB.
# This script also enable module config, if it is not already enabled.

THIS_DIR=$(dirname "$0")
source "$THIS_DIR/global_defines.sh"
echo "Running:" $(basename "$0")


PASSWORD=$(slappasswd -h {SSHA})
if [ $? -ne 0 ]; then
    exit 1
fi

# echo the config before change
sudo ldapsearch -H ldapi:// -Y EXTERNAL -b "cn=config" -s one "(olcSuffix=*)" olcSuffix olcRootDN olcRootPW -LLL -Q

sudo ldapmodify -Y EXTERNAL -H ldapi:// -Q <<EOF
$DB_DN
changetype: modify
replace: olcSuffix
olcSuffix: $SUFFIX

$DB_DN
changetype: modify
replace: olcRootDN
olcRootDN: $ROOT_DN

$DB_DN
changetype: modify
replace: olcRootPW
olcRootPW: $PASSWORD
EOF

# echo the config after change
sudo ldapsearch -H ldapi:// -Y EXTERNAL -b "cn=config" -s one "(olcSuffix=*)" olcSuffix olcRootDN olcRootPW -LLL -Q


# Only enable module config, if it is not already enabled
if [ "$NUMBER_MODULE_CONFIG" -eq 0 ]; then
    sudo ldapmodify -Y EXTERNAL -H ldapi:// -Q -a -f $THIS_DIR/enable_module_config.ldif
fi

# List existing module list
sudo ldapsearch -H ldapi:// -Y EXTERNAL -b "cn=config" -LLL -Q "objectClass=olcModuleList" dn olcmoduleload
