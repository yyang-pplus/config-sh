source ~/.bash_util.sh


# Install the given packages base on OS
#   @param  $@  Common packages list
#   See vim.sh for a complete example
Install_Packages() {
    local OPERATING_SYSTEM=$(uname)
    if [ $OPERATING_SYSTEM == "Linux" ]; then
        if [ -f /etc/redhat-release ]; then
            sudo yum --assumeyes install $redhat_packages_list $@
        elif [ -f /etc/debian_version ]; then
            sudo apt --yes install $debian_packages_list $@
        else
            Error "Unsupported distribution"
            cat /etc/*-release
            return 1
        fi
    else
        Error "Unsupported OS: " $OPERATING_SYSTEM
        return 1
    fi
    return $?
}


Install_Package_If_Necessary() {
    local PACKAGE="$1"
    if ! which "$PACKAGE" 2> /dev/null; then
        Install_Packages "$PACKAGE"
    fi
}
