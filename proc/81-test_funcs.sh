#!/bin/bash
##proc/build_funcs: Loads the tests/ functions
##@copyright GPL-2.0+
if bool $ABTEST_ENABLED; then
    for i in "$AB/tests"/*.sh
    do
        . "$i"
    done
fi
