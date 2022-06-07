#!/bin/bash
##lib/tests.sh: Functions for test modules.
##Part of AB3 integrated package test module
##@copyright GPL-2.0+

abtest_non-zero-handler() {
    case $1 in
        0) return 0;;
        127) abwarn "No abtest() available in file ${2}";;
        *) abwarn "Non-zero returned: ${1}!";;
    esac
}

abtest_unprivileged_non-zero-handler() {
    case $1 in
        127) abwarn "No abtest_unprivileged() available in file ${2}";;
        *) abtest_non-zero-handler $1 $2;;
    esac
}
