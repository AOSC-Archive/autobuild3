#!/bin/bash
#proc/tests_probe.sh: probe and generate default tests

if bool $ABTEST_USEDEFAULT; then
    abtest_gen_default
fi
