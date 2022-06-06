#!/bin/bash
##proc/81-test_probe.sh: TBF
##FIXME: is there a better name for this?
##@copyright GPL-2.0+

. "$AB/lib/tests.sh"

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
else
    abinfo "Build-time package integrity check is disabled. Skipping ..."
fi

