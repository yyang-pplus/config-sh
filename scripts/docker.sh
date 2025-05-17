#!/bin/bash

set -e

THIS_DIR=$(dirname "$0")
source "$THIS_DIR/util.sh"

##
# @reference    Install Docker Engine on Ubuntu
#               https://docs.docker.com/engine/install/ubuntu/
##
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
    $SUDO_CMD apt-get remove $pkg
done

if which docker &> /dev/null; then
    echo "Docker already installed."
    exit 0
fi

pushd /tmp
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
popd

$SUDO_CMD usermod -aG docker $USER
