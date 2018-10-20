#!/bin/bash

# This script runs sample_dit.ldif.
#   If the same DIT already exists, delete it first.

THIS_DIR=$(dirname "$0")

if ldapsearch -H ldap:// -x -b "dc=yyangtech,dc=wordpress,dc=com" -LLL &> /dev/null; then
    #Delete everything
    ldapdelete -H ldap:// -x -D "cn=admin,dc=yyangtech,dc=wordpress,dc=com" -W -r "dc=yyangtech,dc=wordpress,dc=com"
fi

ldapadd -H ldap:// -x -D "cn=admin,dc=yyangtech,dc=wordpress,dc=com" -W -f $THIS_DIR/sample_dit.ldif

ldapsearch -H ldap:// -x -b "dc=yyangtech,dc=wordpress,dc=com" -LLL
