#!/bin/bash

set -ex

# Require config.sh to run first
source ~/.bash_util.sh

THIS_DIR=$(dirname "$0")
source "$THIS_DIR/packages.sh"
source "$THIS_DIR/util.sh"

AssertLinux

if isRedHat; then
    # epel-release is required by terminator and some other packages on CentOS
    sudo yum --assumeyes install epel-release

    sudo yum --assumeyes install $COMMON_PACKAGES $REDHAT_PACKAGES
elif isDebian; then
    sudo apt-get update

    sudo apt --yes install $COMMON_PACKAGES $DEBIAN_PACKAGES

    sudo snap install $SNAP_PACKAGES

    sudo apt autoremove
else
    Fatal "Unsupported Linux distribution."
fi

sudo pip3 install $PIP_PACKAGES

# Run selected scripts
pushd $THIS_DIR
SELECTED_SCRIPTS=($(ls _*))

for script in "${SELECTED_SCRIPTS[@]}"; do
    ./$script
done
popd
