# config-sh

[![Build Status](https://github.com/yyang-pplus/config-sh/workflows/config-sh-master/badge.svg)](https://github.com/yyang-pplus/config-sh/actions)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

My Linux configuration.

Hostname format: **OS-machine-domain**

```bash
sudo hostnamectl set-hostname OS-machine-domain
```

## To Setup Ubuntu

```bash
SCRIPT_NAME="setup_ubuntu.sh"
wget --no-check-certificate -O /tmp/$SCRIPT_NAME "https://raw.githubusercontent.com/yyang-pplus/config-sh/master/$SCRIPT_NAME" && bash /tmp/$SCRIPT_NAME

```

## To Setup Redhat

```bash
SCRIPT_NAME="setup_redhat.sh"
wget --no-check-certificate -O /tmp/$SCRIPT_NAME "https://raw.githubusercontent.com/yyang-pplus/config-sh/master/$SCRIPT_NAME" && bash /tmp/$SCRIPT_NAME

```
