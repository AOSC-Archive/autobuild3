#!/bin/bash
##tests/99-notest.sh: Dummy file indicates that test is not available.
##Part of AB3 build-time package integrity check implementation.
##@copyright GPL-2.0+

abtest_notest_probe() {
    true
}

abtest_notest_test(){
    abinfo "ABTEST_TYPE is set to 'notest'. Skipping..."
}

ABTEST_TESTPROBES+=' notest'
