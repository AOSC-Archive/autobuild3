#!/bin/bash
##proc/tests_post_install: run tests at post install stage
##@copyright GPL-2.0+

for testcase in $ABTESTS; do
    abtest_run post-install "${testcase}"
done

unset testcase
