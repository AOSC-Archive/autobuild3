#!/bin/bash
#tests/custom: test script wrapper for custom test runs
#This script is called by autobuild-test to run custom tests.

abtest_custom_test () {
    if bool $CUSTOM_IS_BASHSCRIPT; then
        abinfo "Sourcing bash script $CUSTOM_SCRIPT ..."
        load_strict $CUSTOM_SCRIPT $CUSTOM_ARGS
    else
        abinfo "Executing test script $CUSTOM_SCRIPT ..."
        $CUSTOM_SCRIPT $CUSTOM_ARGS
    fi
    EXIT_CODE=$?
}
