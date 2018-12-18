#!/bin/bash

# This script replace the olcSuffix to $SUFFIX. It also determines the DN of the database
#   automatically if there is only one DB.

SUFFIX="dc=yyangtech,dc=wordpress,dc=com"
DB_DN=$(sudo ldapsearch -H ldapi:// -Y EXTERNAL -b "cn=config" -s one "(olcSuffix=*)" dn -LLL -Q)
NUMBER_DB=$(wc -l <<< "$DB_DN")

if [ "$NUMBER_DB" -ne 1 ]; then
    echo "Error: Multiple DB:"
    echo $DB_DN
    exit 1
fi

PASSWORD=$(slappasswd -h {SSHA})
if [ $? -ne 0 ]; then
    exit 1
fi

# echo the suffix before change
sudo ldapsearch -H ldapi:// -Y EXTERNAL -b "cn=config" -s one "(olcSuffix=*)" olcSuffix olcRootDN olcRootPW -LLL -Q

sudo ldapmodify -Y EXTERNAL  -H ldapi:// -Q <<EOF
$DB_DN
changetype: modify
replace: olcSuffix
olcSuffix: $SUFFIX

$DB_DN
changetype: modify
replace: olcRootDN
olcRootDN: cn=admin,$SUFFIX

$DB_DN
changetype: modify
replace: olcRootPW
olcRootPW: $PASSWORD
EOF

# echo the suffix after change
sudo ldapsearch -H ldapi:// -Y EXTERNAL -b "cn=config" -s one "(olcSuffix=*)" olcSuffix olcRootDN olcRootPW -LLL -Q
