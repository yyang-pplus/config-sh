#!/bin/bash

pushd /tmp
##
# @reference    dotnet-install scripts reference
#               https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-install-script
##
wget https://dot.net/v1/dotnet-install.sh
bash dotnet-install.sh
popd
