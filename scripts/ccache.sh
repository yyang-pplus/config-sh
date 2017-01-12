#!/bin/bash

source util.sh

which ccache 2> /dev/null
if [ $? -ne 0 ]; then
    #Install ccache
    Install_Package ccache
fi

which ccache &> /dev/null
if [ $? -eq 0 ]; then
    echo "Previous ccache settings:"
    ccache -s
    #Set the cache size limit
    ccache -M 10GB
    #Set the cache file limit
    ccache -F 20000
fi
