# Git autocomplete
if [ -f ~/.git-completion.sh ]; then
    source ~/.git-completion.sh
fi

# Git show git branch on command promt
if [ -f ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
fi

PS1_PREFIX='\[\e[0;92m\][\[\e[0;95m\]\t \[\e[0;92m\]\u@\h\[\e[0;93m\] \w\[\e[0;92m\]]\[\e[0;94m\]$(__git_ps1 "(%s)")\[\e[0m\]'
PS1="$PS1_PREFIX$ "
# VIM :shell
test -n "$VIMRUNTIME" && PS1="$PS1_PREFIX\e[30m(vim)\e[0m$ "

# Enable ccache
export CC="ccache gcc"
export CXX="ccache g++"

# Enable distcc
#export CCACHE_PREFIX="distcc"

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
# Append to the history file, don't overwrite it
shopt -s histappend
# History sizes
HISTSIZE=10000
HISTFILESIZE=15000

export EDITOR=vim

# Covert the debug print of a protobuf string field to hex
#   Example:
#       $ to_hex ']\370\032-h\026\000'
#       5d f8 1a 2d 68 16 00
type to_hex &> /dev/null
if [ $? -eq 0 ]; then
    echo "Function name already taken: to_hex()"
    type to_hex
else
    to_hex() {
        echo -ne $(echo $1 | sed -E 's/\\([0-9]{3})/\\0\1/g') | od -A n -t x1
    }
fi

# Convert date to UTC
# Example:
#   1)  #epoch to UTC
#       $ to_utc 1483724853
#       Fri Jan  6 17:47:33 UTC 2017
#   2)  #epoch milliseconds to UTC
#       $ to_utc 1483724853236
#       Fri Jan  6 17:47:33 UTC 2017
#   3)  #UTC now
#       $ to_utc
#       Thu Jan 12 01:45:15 UTC 2017
#   4)  #static time to UTC
#       $ date
#       Wed Jan 11 17:46:10 PST 2017
#       $ to_utc "Wed Jan 11 17:46:10 PST 2017"
#       Thu Jan 12 01:46:10 UTC 2017
type to_utc &> /dev/null
if [ $? -eq 0 ]; then
    echo "Function name already taken: to_utc()"
    type to_utc
else
    to_utc() {
        if [ $# -eq 1 ]; then
            date --utc --date "$(echo $1 | sed -E 's/^([0-9]{10})[0-9]*$/@\1/g')"
        else
            date --utc "$@"
        fi
    }
fi
