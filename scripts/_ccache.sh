#!/bin/bash

THIS_DIR=$(dirname "$0")
source "$THIS_DIR/util.sh"

#Install ccache and distcc
Install_Package_If_Necessary ccache
Install_Package_If_Necessary distcc

if which ccache &> /dev/null; then
    echo "Previous ccache settings:"
    ccache -s
    #Set the cache size limit
    ccache -M 10GB
    #Set the cache file limit
    ccache -F 20000
fi
