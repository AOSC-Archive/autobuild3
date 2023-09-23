#!/bin/bash
##Testing framework related functions

abtest_scanner_extract(){
    local testname="$1"

    if ! . "$SRCDIR/autobuild/tests/${testname}"; then 
        aberr "Failed to source $SRCDIR/autobuild/tests/${testname}"
        exit 1
    fi

    if [[ -z "${TESTDESC}" ]]; then
        abwarn "Test case ${testname} has no description!"
    fi

    if [[ -z "${TESTTYPE}" ]]; then
        aberr "Test case ${testname} has no TESTTYPE defined!"
        exit 1
    fi

    if [[ -z "${TESTEXEC}" ]]; then
        TESTEXEC=$ABTEST_TESTEXEC
    fi

    if [[ "${TESTTYPE}" == "custom" ]]; then
        if [[ -z "${ABTEST_CUSTOM_STAGE}" ]]; then
            aberr "Custom test case ${testname} has no stage configured!"
            exit 1
        fi
    fi

    local _IFS="$IFS" IFS=$'\n'
    local _var
    for _var in `cat $AB/sets/testspec_exports`; do
        local value=${!_var}
        if [[ "${value}" ]]; then
            echo "ABTEST_${testname}_${_var}=\"${value}\""
        fi
    done
    IFS="$_IFS"
}

abtest_scanner_load(){
    local testname="$1"
    local extracted_variables
    extracted_variables=$(abtest_scanner_extract ${testname})
    if [[ $? -ne 0 ]]; then
        echo "${extracted_variables}" # The error messagees from scanner, acturally
        abdie "Test case ${testname} cannot be loaded, exiting ..."
    fi

    local _IFS="$IFS" IFS=$'\n'
    local varname varvalue
    for varentry in ${extracted_variables[@]}; do
        eval "${varentry}"
    done
    IFS="$_IFS"
}

abtest_run(){
    local stage="$1"
    local testname="$2"

    local _testtype="ABTEST_${testname}_TESTTYPE"

    if [[ "${!_testtype}" == "custom" ]]; then
        local _testcustomstage="ABTEST_${testname}_CUSTOM_STAGE"

        if [[ "${!_testcustomstage}" != "${stage}" ]]; then
            return 0
        fi
    else 
        local _testtypestage="ABTESTTYPE_${!_testtype}_STAGE"
        if [[ "${!_testtypestage}" != "${stage}" ]]; then
            return 0
        fi
    fi

    abinfo "Running test $testname ..."
    local _testexec="ABTEST_${testname}_TESTEXEC"

    case ${!_testexec} in
        plain)
            pushd "$SRCDIR" > /dev/null
            autobuild test $testname
            local exitcode=$?
            popd > /dev/null
            ;;
        sdrun)
            abinfo "Invoking systemd-run ..."
            systemd-run \
                --wait --pipe --service-type=exec \
                --working-directory=${SRCDIR} \
                -- autobuild test $testname
            local exitcode=$?
            ;;
        *)
            abdie "Invalid test execution environment for ${testname}!"
    esac

    case "$exitcode" in
        1)
            if bool $ABTEST_ABORT_BUILD; then
                abdie "Test $testname failed, aborting build ..."
            fi
            aberr "Test $testname failed, but build continues ..."
            ;;
        2)
            abwarn "Test $testname soft-failed, the build continues ..."
            ;;
        255)
            abdie "Test $testname failed with fatal error!"
            ;;
        *)
            abinfo "Test $testname passed."
            ;;
    esac
}

abtest_gen_default() {
    ABTEST_default_TESTEXEC=$ABTEST_TESTEXEC
    ABTEST_default_TESTDESC="Automatically generated tests for $ABTYPE"
    case $ABTYPE in
        *)
            local checkscript="$(arch_findfile check)"
            if [[ $? -eq 0 ]]; then
                abinfo "Found check script file, using it as default test ..."
                ABTEST_default_TESTTYPE=custom
                ABTEST_default_TESTDEPS=$TESTDEPS
                ABTEST_default_CUSTOM_STAGE=$ABTEST_AUTO_DETECT_STAGE
                ABTEST_default_CUSTOM_SCRIPT=$SRCDIR/autobuild/check
                ABTEST_default_CUSTOM_IS_BASHSCRIPT=yes
            else
                abwarn "No default test found for $ABTYPE builds, use NOTEST=yes to suppress this warning."
                return 1
            fi
            ;;
    esac
}
