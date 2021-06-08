#!/bin/bash

if which ccache &> /dev/null; then
    echo "Previous ccache settings:"
    ccache -s
    ccache --max-size 10GB
    ccache --max-files 0
fi
