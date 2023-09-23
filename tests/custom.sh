#!/bin/bash
#tests/custom: test script wrapper for custom test runs
#This script is called by autobuild-test to run custom tests.

abtest() {
    if bool $CUSTOM_IS_BASHSCRIPT; then
        load_strict $CUSTOM_SCRIPT $CUSTOM_ARGS
    else
        $CUSTOM_SCRIPT $CUSTOM_ARGS
    fi
    EXIT_CODE=$?
}
