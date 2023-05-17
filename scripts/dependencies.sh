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

    sudo yum --assumeyes --skip-broken install $COMMON_PACKAGES $REDHAT_PACKAGES

elif isDebian; then
    # Node.js
    # @reference    https://github.com/nodesource/distributions/blob/master/README.md
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -

    sudo apt-get update

    sudo apt --yes install $COMMON_PACKAGES $DEBIAN_PACKAGES

    sudo snap install $SNAP_PACKAGES

    $THIS_DIR/docker.sh

    sudo apt --yes autoremove
else
    Fatal "Unsupported Linux distribution."
fi

pip3 install --user $PIP_PACKAGES

if which gem > /dev/null; then
    gem install --user-install $RUBY_GEMS
fi

if which npm > /dev/null; then
    sudo npm -g install $NPM_PACKAGES
fi

# Run selected scripts
pushd $THIS_DIR
SELECTED_SCRIPTS=($(ls _*))

for script in "${SELECTED_SCRIPTS[@]}"; do
    ./$script
done

if isVirtualBox; then
    ./virtualbox.sh || true
fi
popd
