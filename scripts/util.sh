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

AddSshKeyTo() {
    local NAME="$1"
    local URL="$2"

    local KEY_FILE="$HOME/.ssh/id_rsa.pub"
    if which xclip &> /dev/null; then
        echo "Key $KEY_FILE pasted to clipboard."
        xclip -selection clipboard < $KEY_FILE
    else
        cat $KEY_FILE
    fi

    if pgrep -x "firefox" > /dev/null; then
        kill $(pgrep -x "firefox")
    fi

    echo "Adding the new SSH key to $NAME."
    echo "Please close the browser when done."
    firefox --new-tab "$URL"
}

##
# @reference    Generating a new SSH key and adding it to the ssh-agent
#               https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
#
GenerateSshKey() {
    local KEY_FILE="$HOME/.ssh/id_rsa"

    if [ -f "$KEY_FILE" ]; then
        echo "SSH Key file '$KEY_FILE' already existed."
        false
    else

        echo "Generating a new SSH key."
        read -p 'SSH Key ID (user@os.machine.domain): ' key_id
        if [ -z "${key_id// /}" ]; then
            echo "Error: Please set SSH Key ID."
            exit 1
        fi
        ssh-keygen -t rsa -b 4096 -C "$key_id"

        ssh-add $KEY_FILE
        true
    fi
}
