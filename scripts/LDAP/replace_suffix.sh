#!/bin/bash

# This script replace the olcSuffix to $SUFFIX. It also determines the DN of the database
#   automatically if there is only one DB.

SUFFIX="dc=yyangtech,dc=wordpress,dc=com"
DB_DN=$(sudo ldapsearch -H ldapi:// -Y EXTERNAL -b "cn=config" "(olcSuffix=*)" dn -LLL -Q)
NUMBER_DB=$(wc -l <<< "$DB_DN")

if [ "$NUMBER_DB" -ne 1 ]; then
    echo "Error: Multiple DB:"
    echo $DB_DN
    exit 1
fi

# echo the suffix before change
sudo ldapsearch -H ldapi:// -Y EXTERNAL -b "cn=config" "(olcSuffix=*)" olcSuffix -LLL -Q

sudo ldapmodify -Y EXTERNAL  -H ldapi:// -Q <<EOF
$DB_DN
changetype: modify
replace: olcSuffix
olcSuffix: $SUFFIX
EOF

# echo the suffix after change
sudo ldapsearch -H ldapi:// -Y EXTERNAL -b "cn=config" "(olcSuffix=*)" olcSuffix -LLL -Q
