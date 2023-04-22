#!/bin/bash

set -e

##
# @reference    Install Docker Engine on Ubuntu
#               https://docs.docker.com/engine/install/ubuntu/
##
sudo apt-get --yes remove docker docker-engine docker.io containerd runc

if which docker &> /dev/null; then
    echo "Docker already installed."
    exit 0
fi

pushd /tmp
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
popd

sudo usermod -aG docker $USER
