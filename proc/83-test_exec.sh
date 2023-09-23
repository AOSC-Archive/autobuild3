#!/bin/bash
##proc/83-test_exec.sh: Perform test
##Part of AB3 integrated package build-time test module
##@copyright GPL-2.0+

if bool $ABTEST_ENABLED; then
    cd "$SRCDIR" 
    # FIXME: use a non-zero handler?
    abtest_${ABTEST_TYPE}_test || \
        abwarn "Test exited with non-zero status: $?"
fi
