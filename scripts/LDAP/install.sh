#!/bin/bash

# This script is only for CentOS.
# This script installs the OpenLDAP packages, starts the OpenLDAP Server Daemon
#   and also enable it to be automatically started at boot time.


source ~/.bash_util.sh
echo "Running:" $(basename "$0")


set -ex

sudo yum -y install openldap-servers openldap-clients

# Previous versions of Red Hat Enterprise Linux, which were distributed with
#   SysV init or Upstart, used init scripts located in the /etc/rc.d/init.d/
#   directory. These init scripts were typically written in Bash, and allowed
#   the system administrator to control the state of services and daemons in
#   their system. In Red Hat Enterprise Linux 7, these init scripts have been
#   replaced with service units.
# Service units end with the .service file extension and serve a similar
#   purpose as init scripts. The service and chkconfig commands are still
#   available in the system and work as expected, but are only included for
#   compatibility reasons and should be avoided.
# @reference    Red Hat Enterprise Linux: System Administrator's Guide: Managing System Services
#               https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/system_administrators_guide/sect-managing_services_with_systemd-services
#
if which systemctl &> /dev/null; then
    sudo systemctl enable slapd
    sudo systemctl start slapd
    sudo systemctl status slapd
else
    sudo chkconfig slapd on
    sudo chkconfig --list slapd

    sudo service slapd start
    sudo service slapd status
fi
