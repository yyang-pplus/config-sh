#!/bin/bash

oneTimeSetUp() {
    git checkout --quiet master

    PROJECT_ROOT_DIR=$(git rev-parse --show-toplevel)
    PRE_PUSH_SCRIPT_FILE="$PROJECT_ROOT_DIR/git_hooks/push-guard.sh"
    REMOVE_REMOTE_PREFIX_CMD=$(grep --no-filename "DEFAULT_UPSTREAM_BRANCH_NAME=" "$PRE_PUSH_SCRIPT_FILE")

    PATTERN_CMD=$(grep --no-filename "PATTERN=" "$PRE_PUSH_SCRIPT_FILE")
}

oneTimeTearDown() {
    ##
    # @reference    Is there any way to git checkout previous branch?
    #               https://stackoverflow.com/questions/7206801/is-there-any-way-to-git-checkout-previous-branch
    ##
    git checkout --quiet -
}

testPreHookScriptExistAndRunable() {
    DOT_GIT_DIR=$(git rev-parse --git-dir)
    assertTrue "[ -x \"$DOT_GIT_DIR/hooks/pre-push\" ]"
}

testDefaultPushToMasterWouldFail() {
    git push --dry-run
    assertFalse $?
}

testPushToGerrithubShouldWork() {
    git push --dry-run origin HEAD:refs/for/master
    assertTrue $?
}

testRemoveRemotePrefixWithMaster() {
    local EXPECTED_BRANCH_NAME="master"
    local REMOTE="origin"
    local DEFAULT_FULL_UPSTREAM="$REMOTE/$EXPECTED_BRANCH_NAME"

    eval "local $REMOVE_REMOTE_PREFIX_CMD"

    assertEquals "$EXPECTED_BRANCH_NAME" "$DEFAULT_UPSTREAM_BRANCH_NAME"
}

testRemoveRemotePrefixWithRefsFor() {
    local REMOTE=origin
    local DEFAULT_FULL_UPSTREAM="refs/for/master"

    eval "local $REMOVE_REMOTE_PREFIX_CMD"

    assertEquals "$DEFAULT_FULL_UPSTREAM" "$DEFAULT_UPSTREAM_BRANCH_NAME"
}

testProtectedPatternMatchesMain() {
    eval "$PATTERN_CMD"

    assertTrue "[[ 'main' =~ $PATTERN ]]"
}

testProtectedPatternMatchesAheadMain() {
    eval "$PATTERN_CMD"

    assertTrue "[[ 'refs/heads/main' =~ $PATTERN ]]"
}

testProtectedPatternNotMatchRefsFor() {
    eval "$PATTERN_CMD"

    assertFalse "[[ 'refs/for/main' =~ $PATTERN ]]"
}

testProtectedPatternMatchesMaster() {
    eval "$PATTERN_CMD"

    assertTrue "[[ 'master' =~ $PATTERN ]]"
}

testProtectedPatternMatchesAheadMaster() {
    eval "$PATTERN_CMD"

    assertTrue "[[ 'refs/heads/master' =~ $PATTERN ]]"
}

testProtectedPatternNotMatchRefsFor() {
    eval "$PATTERN_CMD"

    assertFalse "[[ 'refs/for/master' =~ $PATTERN ]]"
}

testExtraProtectedPatternPrefix() {
    local GIT_EXTRA_PROTECTED_BRANCH_PATTERN="example.*"

    eval "$PATTERN_CMD"

    assertTrue "Case 1" "[[ 'example' =~ $PATTERN ]]"
    assertTrue "Case 2" "[[ 'example_branch_1' =~ $PATTERN ]]"
    assertTrue "Case 3" "[[ 'example-1.6.0' =~ $PATTERN ]]"
}

source /usr/bin/shunit2
