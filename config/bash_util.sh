##
# Global Utility Functions
##


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
