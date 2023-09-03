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

    if [[ "$testname" == "default" ]]; then
        local isdefault=yes
    else
        local isdefault=no
    fi

    if bool $isdefault; then
        local _testtype="TESTTYPE"
    else
        local _testtype="ABTEST_${testname}_TESTTYPE"
    fi

    if [[ "${!_testtype}" == "custom" ]]; then
        if bool $isdefault; then
            local _testcustomstage=ABTEST_CUSTOM_STAGE
        else
            local _testcustomstage="ABTEST_${testname}_CUSTOM_STAGE"
        fi

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
    if bool $isdefault; then
        local _testexec=TESTEXEC
    else
        local _testexec="ABTEST_${testname}_TESTEXEC"
    fi

    case ${!_testexec} in
        plain)
            pushd "$SRCDIR" > /dev/null
            autobuild test $testname
            local exitcode=$?
            popd > /dev/null
            ;;
        sdrun)
            abinfo "Invoking systemd-run"
            systemd-run \
                --wait --pipe --service-type=exec \
                --working-directory=${SRCDIR} \
                -- autobuild test $testname
            local exitcode=$?
            ;;
        *)
            abdie "Invalid test execution environment for ${testname}"
    esac

    if [[ $exitcode -eq 255 ]]; then
        abdie "Test $testname failed with fatal error!"
    elif [[ $exitcode -eq 1 ]] && bool $ABTEST_ABORT_BUILD; then
        abdie "Test $testname failed, aborting build ..."
    fi
}

abtest_gen_default() {
    TESTEXEC=$ABTEST_TESTEXEC
    TESTDESC="Automatically generated tests for $ABTYPE"
    case $ABTYPE in
        *)
            abwarn "No default test found for $ABTYPE builds, add TESTS=\"\" to suppress this warning."
            ;;
    esac
}
