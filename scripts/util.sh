# Require config.sh to run first
source ~/.bash_util.sh

AssertLinux() {
    local OPERATING_SYSTEM=$(uname)
    if [ $OPERATING_SYSTEM != "Linux" ]; then
        Fatal "Unsupported OS: " $OPERATING_SYSTEM
    fi
}

isRedHat() {
    [ -f /etc/redhat-release ]
}

isDebian() {
    [ -f /etc/debian_version ]
}
