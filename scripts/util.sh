Echo_Error() {
    cat <<< "$@" 1>&2;
}

Log_Run() {
    echo "$@"
    "$@"
}

# Install the given packages base on OS
#   @param  $@  Common packages list
#   See vim.sh for a complete example
Install_Packages() {
    operating_system=$(uname)
    if [ $operating_system == "Linux" ]; then
        if [ -f /etc/redhat-release ]; then
            sudo yum --assumeyes install $redhat_packages_list $@
        elif [ -f /etc/debian_version ]; then
            sudo apt-get --yes install $debian_packages_list $@
        else
            Echo_Error "Error: Unsupported distribution"
            cat /etc/*-release
            return 1
        fi
    else
        Echo_Error "Error: Unsupported OS: " $operating_system
        return 1
    fi
    return $?
}

Install_Package_If_Necessary() {
    if ! which "$1" 2> /dev/null; then
        Install_Packages "$1"
    fi
}
