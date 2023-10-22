#!/bin/bash
#proc/tests_probe.sh: probe and generate default tests

if bool $ABTEST_AUTO_DETECT; then
    abtest_gen_default
    if [[ $? -eq 0 ]]; then
        ABTESTS="$ABTESTS default"
    fi
fi

if ! bool $NOTEST; then
    abinfo "Currently enabled tests are: $ABTESTS"
fi
