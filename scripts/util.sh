Echo_Error() {
    cat <<< "$@" 1>&2;
}

# Install the package base on OS
Install_Packages() {
    operating_system=$(uname)
    if [ $operating_system == "Linux" ]; then
        if [ -f /etc/redhat-release ]; then
            sudo yum --assumeyes install "$@"
        elif [ -f /etc/debian_version ]; then
            sudo apt-get --yes install "$@"
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
    which "$1" 2> /dev/null
    if [ $? -ne 0 ]; then
        Install_Packages "$1"
    fi
}
