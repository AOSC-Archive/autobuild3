#!/bin/bash
##proc/tests_pre: scan for tests in $ABTESTS and construct $TESTDEPS
##@copyright GPL-2.0+

if bool $NOTEST; then
    ABTESTS=""
    TESTDEPS="" # Empty TESTDEPS by explicitly override it
else
    abinfo "Currently enabled tests are: $ABTESTS"
fi

if [[ -n "$ABTESTS" ]]; then
    abrequire tests

    _IFS="$IFS" IFS=$' '
    for test in $ABTESTS; do
        if [[ "default" == "$test" ]]; then
            ABTEST_USEDEFAULT=yes
            continue
        fi
        abtest_scanner_load "$test"
        
        local _testdeps="ABTEST_${test}_TESTDEPS"
        local _testtype="ABTEST_${test}_TESTTYPE"
        local _testtypedeps="ABTESTTYPE_${!_testtype}_DEPS"
        TESTDEPS="${TESTDEPS} ${!_testdeps} ${!_testtypedeps}"
    done
    IFS="$_IFS"
    unset _IFS
fi
