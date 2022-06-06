#!/bin/bash
##proc/81-check.sh: TBF
##@copyright GPL-2.0+

abtrylib tests || ablibret

if bool $ABTEST_ENABLED; then
    cd "$SRCDIR" 
    # FIXME: use a non-zero handler?
    abtest_${ABTEST_TYPE}_test || \
        abwarn "Test exited with non-zero status: $?"
fi
