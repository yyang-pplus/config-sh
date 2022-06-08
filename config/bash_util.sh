##
# Global Utility Functions
##
PROJECTS_DIR="$HOME/projects"

Assert() {
    if ! "$@"; then
        exit 1
    fi
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

ForEachChildDir() {

    ALL_ITEMS=($(ls))
    for one_item in "${ALL_ITEMS[@]}"; do
        if [ -d "$one_item" ]; then
            pushd "$one_item"
            $@
            popd
        fi
    done
}

Error() {
    cat <<< "Error: $@" 1>&2
}

Fatal() {
    Error "$@"
    exit 1
}
