#!/bin/bash
##proc/tests_pre: scan for tests in $ABTESTS and construct $TESTDEP
##@copyright GPL-2.0+

if bool $NOTEST; then
    ABTESTS=""
    TESTDEP="" # Empty TESTDEPS by explicitly override it
else
    abrequire tests
    export ABTEST_RESULT_OUTPUT="$SRCDIR/abtestoutput.txt"
    echo -n "" > "$ABTEST_RESULT_OUTPUT"
fi

if [[ -n "$ABTESTS" ]]; then
    _IFS="$IFS" IFS=$' '
    for test in $ABTESTS; do
        abtest_scanner_load "$test"
        
        local _testdep="ABTEST_${test}_TESTDEP"
        local _testtype="ABTEST_${test}_TESTTYPE"
        local _testtypedep="ABTESTTYPE_${!_testtype}_DEP"
        TESTDEP="${TESTDEP} ${!_testdep} ${!_testtypedep}"
    done
    IFS="$_IFS"
    unset _IFS
fi
