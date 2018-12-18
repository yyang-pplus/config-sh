#!/bin/bash

# This script add additional schemas.

echo "Running:" $(basename "$0")

echo "List available schemas:"
ls /etc/openldap/schema/*.ldif -1

# echo the config before change
sudo ldapsearch -H ldapi:// -Y EXTERNAL -b "cn=schema,cn=config" -s one -Q -LLL dn

sudo ldapadd -Y EXTERNAL -H ldapi:// -Q -f /etc/openldap/schema/cosine.ldif
sudo ldapadd -Y EXTERNAL -H ldapi:// -Q -f /etc/openldap/schema/nis.ldif
sudo ldapadd -Y EXTERNAL -H ldapi:// -Q -f /etc/openldap/schema/inetorgperson.ldif

# echo the config after change
sudo ldapsearch -H ldapi:// -Y EXTERNAL -b "cn=schema,cn=config" -s one -Q -LLL dn
