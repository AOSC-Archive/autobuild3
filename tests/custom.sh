#!/bin/bash
#tests/custom: test script wrapper for custom test runs
#This script is called by autobuild-test to run custom tests.

abtest() {
    $SRCDIR/autobuild/$CUSTOM_SCRIPT $CUSTOM_ARGS
    EXIT_CODE=$?
}
