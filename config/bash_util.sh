##
# Global Utility Functions
##


Assert() {
    if ! "$@"; then
        exit 1
    fi
}


Error() {
    cat <<< "Error: $@" 1>&2;
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
