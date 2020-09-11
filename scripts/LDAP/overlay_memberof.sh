#!/bin/bash

# Note: Every group created before this module is enabled has to be deleted and
#   remade in order for these changes to take effect.
# @reference    How to enable MemberOf using OpenLDAP
#               https://adimian.com/blog/2014/10/how-to-enable-memberof-using-openldap/
#
# Note that the memberOf attribute is an operational attribute, so it must be
#   requested explicitly.
# @reference    OpenLDAP Administrator's Guide: Overlays
#               https://www.openldap.org/doc/admin24/overlays.html
#
# man slapo-memberof

THIS_DIR=$(dirname "$0")
source "$THIS_DIR/global_defines.sh"
echo "Running:" $(basename "$0")

OVERLAY_MEMBEROF_DN=$(DN_Insert_Front "olcOverlay=memberof" "$DB_DN")
NUMBER_MEMBEROF_CONFIG=$(sudo ldapsearch -H ldapi:// -Y EXTERNAL -b "cn=config" -LLL -Q "objectClass=olcMemberOf" dn | grep --count "^dn:")

# Only enable memberof, if it is not already enabled
if [ "$NUMBER_MEMBEROF_CONFIG" -eq 0 ]; then

    sudo ldapmodify -Y EXTERNAL -H ldapi:// -Q -c << EOF
$MODULE_CONFIG_DN
changetype: modify
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
