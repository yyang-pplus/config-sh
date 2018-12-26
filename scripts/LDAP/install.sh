#!/bin/bash

# This script is only for CentOS.
# This script installs the OpenLDAP packages, starts the OpenLDAP Server Daemon
#   and also enable it to be automatically started at boot time.


THIS_DIR=$(dirname "$0")
source $THIS_DIR/../util.sh
echo "Running:" $(basename "$0")


sudo yum -y install openldap-servers openldap-clients

if which systemctl &> /dev/null; then
    Log_Run sudo systemctl enable slapd
    Log_Run sudo systemctl start slapd
    sudo systemctl status slapd
else
    Log_Run sudo chkconfig slapd on
    sudo chkconfig --list slapd

    sudo service slapd start
    sudo service slapd status
fi
