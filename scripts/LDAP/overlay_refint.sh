#!/bin/bash

# man slapo-refint

THIS_DIR=$(dirname "$0")
source "$THIS_DIR/global_defines.sh"
echo "Running:" $(basename "$0")

OVERLAY_REFINT_DN=$(DN_Insert_Front "olcOverlay=refint" "$DB_DN")
NUMBER_REFINT_CONFIG=$(sudo ldapsearch -H ldapi:// -Y EXTERNAL -b "cn=config" -LLL -Q "objectClass=olcRefintConfig" dn | wc -l)


# Only enable refint, if it is not already enabled
if [ "$NUMBER_REFINT_CONFIG" -eq 0 ]; then

sudo ldapmodify -Y EXTERNAL -H ldapi:// -Q -c <<EOF
$MODULE_CONFIG_DN
changetype: modify
add: olcmoduleload
olcmoduleload: refint

$OVERLAY_REFINT_DN
changetype: add
objectClass: olcConfig
objectClass: olcOverlayConfig
objectClass: olcRefintConfig
olcRefintAttribute: memberof member manager owner
EOF

fi
