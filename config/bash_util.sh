##
# Global Utility Functions
##

Assert() {
    if ! "$@"; then
        exit 1
    fi
}

Error() {
    cat <<< "Error: $@" 1>&2
}

Fatal() {
    Error "$@"
    exit 1
}

LogAndRun() {
    echo "[$(date)]$" "$@"
    $@
}

QuietRun() {
    "$@" > /dev/null
}

##
# @reference    Repeatedly run a shell command until it fails?
#               https://stackoverflow.com/questions/12967232/repeatedly-run-a-shell-command-until-it-fails
##
RunUntilFail() {
    while "$@"; do :; done
}
