#!/bin/bash


THIS_DIR=$(dirname "$0")
source "$THIS_DIR/global_defines.sh"
echo "Running:" $(basename "$0")

OVERLAY_MEMBEROF_DN=$(DN_Insert_Front "olcOverlay=memberof" "$DB_DN")
NUMBER_MEMBEROF_CONFIG=$(sudo ldapsearch -H ldapi:// -Y EXTERNAL -b "cn=config" -LLL -Q "objectClass=olcMemberOf" dn | wc -l)

if [ "$NUMBER_MEMBEROF_CONFIG" -eq 0 ]; then

sudo ldapmodify -Y EXTERNAL -H ldapi:// -Q -c <<EOF
$MODULE_CONFIG_DN
add: olcmoduleload
olcmoduleload: memberof

$OVERLAY_MEMBEROF_DN
changetype: add
objectClass: olcConfig
objectClass: olcMemberOf
objectClass: olcOverlayConfig
olcMemberOfDangling: ignore
olcMemberOfRefInt: TRUE
olcMemberOfGroupOC: groupOfNames
olcMemberOfMemberAD: member
olcMemberOfMemberOfAD: memberOf
EOF

fi
