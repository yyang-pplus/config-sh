#!/bin/bash


THIS_DIR=$(dirname "$0")

./$THIS_DIR/install.sh
./$THIS_DIR/schema.sh
./$THIS_DIR/db_config.sh
