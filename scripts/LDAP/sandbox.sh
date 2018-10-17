#!/bin/bash

# This script is only for CentOS.


source scripts/util.sh


sudo yum -y install openldap-servers openldap-clients

if which systemctl &> /dev/null; then
    Log_Run sudo systemctl enable slapd
    Log_Run sudo systemctl start slapd
    sudo systemctl status slapd
fi
