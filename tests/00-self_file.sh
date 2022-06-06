#!/bin/bash
##tests/00-self_file.sh: invoke testing function defined in `autobuild/test`
##Part of AB3 build-time package integrity check implementation.
##@copyright GPL-2.0+

abtrylib arch tests || ablibret

abtest_self_file_probe() {
    [ -f "$(arch_trymore=1 arch_findfile test)" ]
}

abtest_self_file_test() {
    . "$AB/lib/tests.sh"

    abtest() {
        abwarn "ABTEST_TYPE is set to self, but no abtest() found in autobuild{,/\$ARCH}/test"
        return 127
    }

    abtest_unprivileged() {
        abwarn "ABTEST_TYPE is set to self, but no abtest_unprivileged() found in autobuild{,/\$ARCH}/test"
        return 127
    }

    # Redefine 
    arch_loadfile "$SRCDIR"/test

    abtest || abtest_non-zero-handler $1 "$SRCDIR"/test
    abtest_unprivileged || abtest_unprivileged_non-zero-handler $1 "$SRCDIR"/test
}

ABTEST_TESTPROBES+=' self_file'
