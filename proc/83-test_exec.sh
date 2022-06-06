#!/bin/bash
##proc/81-check.sh: TBF
##@copyright GPL-2.0+

abtrylib tests || ablibret

if bool $ABTEST_ENABLED; then
    cd "$SRCDIR" 
    abtest_${ABTEST_TYPE}_test || \
        abwarn "Test exited with non-zero status: $?"
fi
