#!/bin/bash

##
# A git pre-push hook that prevent pushing directly to protected branch(es)
#
# @env  GIT_EXTRA_PROTECTED_BRANCH_PATTERN
##

if [ -f ~/.bash_util.sh ]; then
    source ~/.bash_util.sh
else
    Error() {
        cat <<< "Error: $@" 1>&2
    }
fi

IsProtected() {
    local BRANCH_NAME="$1"
    ##
    # Regex 'a^' matches nothing
    # @reference    Regular expression syntax for “match nothing”?
    #               https://stackoverflow.com/questions/940822/regular-expression-syntax-for-match-nothing
    ##
    local PATTERN="^(refs/heads/)?((main$)|(master$)|(${GIT_EXTRA_PROTECTED_BRANCH_PATTERN:-'a^'}))"

    ##
    # @reference    Bash test: what does “=~” do?
    #               https://unix.stackexchange.com/questions/340440/bash-test-what-does-do
    #
    # @note The string, to be matched, should be quoted.
    #       The regular expression pattern shouldn't be quoted.
    ##
    if [[ "$BRANCH_NAME" =~ $PATTERN ]]; then
        Error "Push to $BRANCH_NAME is restricted."
        return 0
    else
        return 1
    fi
}

while read local_ref local_sha remote_ref remote_sha; do
    has_remote_ref=true
    if IsProtected "$remote_ref"; then
        exit 1
    fi
done

# This happens with default 'git push'
if [ -z "$has_remote_ref" ]; then
    ##
    # @reference    How can I see which Git branches are tracking which remote / upstream branch?
    #               https://stackoverflow.com/questions/4950725/how-can-i-see-which-git-branches-are-tracking-which-remote-upstream-branch
    ##
    DEFAULT_FULL_UPSTREAM=$(git rev-parse --abbrev-ref --symbolic-full-name @{upstream})
    REMOTE="$1"
    # Remove "$REMOTE/" prefix, for example "origin/", before test
    DEFAULT_UPSTREAM_BRANCH_NAME=${DEFAULT_FULL_UPSTREAM##$REMOTE/}

    if IsProtected "$DEFAULT_UPSTREAM_BRANCH_NAME"; then
        exit 1
    fi
fi
