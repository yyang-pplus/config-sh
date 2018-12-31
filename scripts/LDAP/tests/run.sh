#!/bin/bash

# This script runs sample_dit.ldif.
#   If the same DIT already exists, delete it first.

THIS_DIR=$(dirname "$0")
source "$THIS_DIR/../global_defines.sh"

if ldapsearch -H ldap:// -x -b "$SUFFIX" -LLL &> /dev/null; then
    #Delete everything
    ldapdelete -H ldap:// -x -D "$ROOT_DN" -W -r "$SUFFIX"
fi

ldapadd -H ldap:// -x -D "$ROOT_DN" -W -c -f $THIS_DIR/sample_dit.ldif

ldapsearch -H ldap:// -x -b "$SUFFIX" -LLL

# Test memberof
ldapsearch -H ldap:// -x -b "uid=yyang,ou=People,$SUFFIX" -LLL memberof
