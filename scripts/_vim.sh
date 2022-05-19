#!/bin/bash

set -e

if [ ! -f $HOME/.viminfo ]; then
    exit 0
fi

echo "Initiating Vim history."

##
# @reference    How to suppress variable substitution in bash heredocs
#               https://stackoverflow.com/questions/31645341/how-to-suppress-variable-substitution-in-bash-heredocs
# @reference    Linux: Using sed to insert lines before or after a match
#               https://fabianlee.org/2018/10/28/linux-using-sed-to-insert-lines-before-or-after-a-match/
##
while read a_line; do
    if [ ! -z "${a_line// /}" ]; then
        sed -i "/^# Command Line History.*/a :$a_line\n|2,0,$(date +%s),,\"$a_line\"" $HOME/.viminfo
        sleep 1s
    fi
done << "EOF"
mksession! ~/tmp/session.vim

-1read scripts/main_template.cpp

Git commit -a --amend --no-edit
Git push origin HEAD:refs/for/master

.,$s/\\\\[/{/g
.,$s/\\\\]/}/g
EOF
