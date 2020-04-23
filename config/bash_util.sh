##
# Global Utility Functions
##

LogAndRun() {
    echo "[$(date)]$" "$@"
    $@
}


Assert() {
    if [ ! $@ ]; then
        exit 1
    fi
}
