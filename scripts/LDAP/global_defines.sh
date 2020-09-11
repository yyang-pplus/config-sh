SUFFIX="dc=yyangtech,dc=wordpress,dc=com"
ROOT_DN="cn=admin,$SUFFIX"

DB_DN=$(sudo ldapsearch -H ldapi:// -Y EXTERNAL -b "cn=config" -s one "(olcSuffix=*)" dn -LLL -Q)
NUMBER_DB=$(grep --count "^dn:" <<< "$DB_DN")

MODULE_CONFIG_DN=$(sudo ldapsearch -H ldapi:// -Y EXTERNAL -b "cn=config" -LLL -Q "objectClass=olcModuleList" dn)
NUMBER_MODULE_CONFIG=$(grep --count "^dn:" <<< "$MODULE_CONFIG_DN")

DN_Insert_Front() {
    local COMPONENT="$1"
    local DN="$2"
    sed -e "s/dn: /dn: $COMPONENT,/" <<< $DN
}
