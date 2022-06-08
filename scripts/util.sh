# Require config.sh to run first
if [ -f ~/.bash_util.sh ]; then
    source ~/.bash_util.sh
fi

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

##
# @reference    Easy way to determine the virtualization technology of a Linux machine?
#               https://unix.stackexchange.com/questions/89714/easy-way-to-determine-the-virtualization-technology-of-a-linux-machine
##
isVirtualBox() {
    [[ $(sudo dmidecode -s system-product-name) == *"VirtualBox"* ]]
}

AddSshKeyTo() {
    local KEY_FILE_NAME="$1"
    local URL="$2"

    local KEY_FILE="$HOME/.ssh/$KEY_FILE_NAME.pub"
    if which xclip &> /dev/null; then
        echo "Key $KEY_FILE pasted to clipboard."
        xclip -selection clipboard < $KEY_FILE
    else
        cat $KEY_FILE
    fi

    if pgrep -x "firefox" > /dev/null; then
        kill $(pgrep -x "firefox")
    fi

    echo "Adding the new SSH key $KEY_FILE_NAME to $URL."
    echo "Please close the browser when done."
    firefox --new-tab "$URL"
}
