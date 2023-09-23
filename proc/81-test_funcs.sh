#!/bin/bash
##proc/81-test_funcs: Loads the tests/ functions
##Part of AB3 integrated package build-time test module
##@copyright GPL-2.0+

if bool $ABTEST_ENABLED; then
    for i in "$AB/tests"/*.sh
    do
        . "$i"
    done
else
    abinfo "Build-time package integrity check is disabled. Skipping ..."
fi
