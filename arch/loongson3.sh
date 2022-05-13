#!/bin/bash
##arch/loongson3.sh: Build definitions for Loongson 3A/B 1000-4000+.
##@copyright GPL-2.0+
CFLAGS_GCC_ARCH='-mabi=64 -march=gs464 -mtune=gs464e -mfix-loongson3-llsc -mxgot '
CFLAGS_CLANG_ARCH='-mabi=64 -march=mips64r2 -mtune=mips64r2 '
CFLAGS_GCC_OPTI_LTO="${CFLAGS_COMMON_OPTI_LTO} -flto-partition=none "
LDFLAGS_GCC_OPTI_LTO="${LDFLAGS_COMMON_OPTI_LTO} -mxgot -flto-partition=none "
RUSTFLAGS_COMMON_OPTI_LTO="${RUSTFLAGS_COMMON_OPTI_LTO} -Clink-arg=-Wl,-build-id=sha1 -Clink-arg=-Wl,-z,notext "

# Position-independent executable buildmode is not available on any mips architecture.
# Removing for loongson3 target.
GOFLAGS=${GOFLGAS/-buildmode=pie/}
