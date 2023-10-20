#!/bin/bash
##proc/tests_post_build: run tests at post build stage
##@copyright GPL-2.0+

for testcase in $ABTESTS; do
    abtest_run post-build "${testcase}"
done

unset testcase
