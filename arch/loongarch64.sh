#!/bin/bash
##arch/loongarch64.sh: Build definitions for Loongson 3A/B 5000.
##@copyright GPL-2.0+

CFLAGS_GCC_ARCH='-mabi=lp64 -march=loongarch64 -mtune=loongarch64'

# Position-independent executable buildmode is not available on loong64 architecture.
# Removing for loongarch64 target.
GOFLAGS=${GOFLGAS/-buildmode=pie/}
