##
# Global Utility Functions
##


Assert() {
    if [ ! $@ ]; then
        exit 1
    fi
}


Echo_Error() {
    cat <<< "$@" 1>&2;
}


LogAndRun() {
    echo "[$(date)]$" "$@"
    $@
}


QuietRun() {
    "$@" > /dev/null
}
