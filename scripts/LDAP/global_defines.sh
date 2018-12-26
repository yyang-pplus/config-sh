
SUFFIX="dc=yyangtech,dc=wordpress,dc=com"
ROOT_DN="cn=admin,$SUFFIX"

DB_DN=$(sudo ldapsearch -H ldapi:// -Y EXTERNAL -b "cn=config" -s one "(olcSuffix=*)" dn -LLL -Q)
NUMBER_DB=$(wc -l <<< "$DB_DN")

MODULE_CONFIG_DN=$(sudo ldapsearch -H ldapi:// -Y EXTERNAL -b "cn=config" -LLL -Q "objectClass=olcModuleList" dn)
NUMBER_MODULE_CONFIG=$(wc -l <<< "$MODULE_CONFIG_DN")


DN_Insert_Front() {
    sed -e "s/dn: /dn: $1,/" <<< $2
}
