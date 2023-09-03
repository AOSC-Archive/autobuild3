#!/bin/bash
##proc/tests_postbuild: run tests at post install stage
##@copyright GPL-2.0+

for testcase in $ABTESTS; do
    abtest_run postinst "${testcase}"
done

unset testcase
