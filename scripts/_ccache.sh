#!/bin/bash

if which ccache &> /dev/null; then
    echo "Previous ccache settings:"
    ccache -s
    #Set the cache size limit
    ccache -M 10GB
    #Set the cache file limit
    ccache -F 20000
fi
