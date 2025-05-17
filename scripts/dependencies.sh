#!/bin/bash

set -ex

# Require config.sh to run first
source ~/.bash_util.sh

THIS_DIR=$(dirname "$0")
source "$THIS_DIR/packages.sh"
source "$THIS_DIR/util.sh"

AssertLinux

if isRedHat; then
    $SUDO_CMD dnf --assumeyes --skip-broken install $COMMON_PACKAGES $REDHAT_PACKAGES

elif isDebian; then
    $SUDO_CMD apt-get update

    $SUDO_CMD apt --yes install $COMMON_PACKAGES $DEBIAN_PACKAGES

    $SUDO_CMD snap install $SNAP_PACKAGES

    $THIS_DIR/anki.sh
    $THIS_DIR/docker.sh

    $SUDO_CMD apt --yes autoremove
else
    Fatal "Unsupported Linux distribution."
fi

if which pipx > /dev/null; then
    pipx install $PIPX_PACKAGES
fi

if which gem > /dev/null; then
    gem install --user-install $RUBY_GEMS
fi

# Run selected scripts
pushd $THIS_DIR
SELECTED_SCRIPTS=($(ls _*))

for script in "${SELECTED_SCRIPTS[@]}"; do
    ./$script
done

if isVirtualBox; then
    ./virtualbox.sh
fi
popd
