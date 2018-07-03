#!/bin/bash

source util.sh

# epel-release is required by terminator on CentOS
redhat_packages_list="epel-release" Install_Package_If_Necessary terminator
