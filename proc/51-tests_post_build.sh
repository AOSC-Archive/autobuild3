#!/bin/bash
##proc/tests_postbuild: run tests at post build stage
##@copyright GPL-2.0+

for testcase in $ABTESTS; do
    abtest_run postbuild "${testcase}"
done

unset testcase
