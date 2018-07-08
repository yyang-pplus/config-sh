#!/bin/bash

source util.sh

# epel-release is required by terminator and some other packages on CentOS
redhat_packages_list="epel-release" debian_packages_list="astyle" Install_Packages
