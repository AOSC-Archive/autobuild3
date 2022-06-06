#!/bin/bash
##tests/01-self_files.sh: invoke testing function defined in `autobuild/tests/T*.sh`
##Part of AB3 build-time package integrity check implementation.
##@copyright GPL-2.0+

. "$AB/tests"/_base.sh

for i in "$SRCDIR"/tests/T*.sh
do
    arch_loadfile $i
    abtest || abtest_non-zero-handler $? $i
    abtest_unprivileged || abtest_non-zero-handler $? $i
    unset abtest abtest_unprivileged
done
