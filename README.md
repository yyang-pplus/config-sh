[![Build Status](https://app.travis-ci.com/yyang-pplus/config-sh.svg?branch=master)](https://app.travis-ci.com/yyang-pplus/config-sh) [![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

# config-sh
My Linux configuration.

## To Setup Ubuntu
```bash
pushd /tmp
SCRIPT_NAME="setup_ubuntu.sh"
wget -O $SCRIPT_NAME "https://raw.githubusercontent.com/yyang-pplus/config-sh/master/$SCRIPT_NAME" && bash $SCRIPT_NAME
popd

```

## To Setup Ubuntu Inside VirtualBox
```bash
pushd /tmp
SCRIPT_NAME="setup_ubuntu_vbox.sh"
wget -O $SCRIPT_NAME "https://raw.githubusercontent.com/yyang-pplus/config-sh/master/$SCRIPT_NAME" && bash $SCRIPT_NAME
popd

```

## To push to gerrit hub
```bash
git push origin HEAD:refs/for/master
```
