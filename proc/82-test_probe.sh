#!/bin/bash
##proc/82-test_probe.sh: Determining test type
##Part of AB3 integrated package build-time test module
##@copyright GPL-2.0+

if bool $ABTEST_ENABLED; then
    if [ -z "$ABTEST_TYPE"]; then
        abinfo "No $ABTEST_TYPE set, automatically determining ..."
        for i in $ABTEST_TESTPROBES; do
            if abtest_${i}_probe; then
                abinfo "Automatically set ABTEST_TYPE to ${i}"
                ABTEST_TYPE=$i
                break
            fi
        done
    fi
fi
