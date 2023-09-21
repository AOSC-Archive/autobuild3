#!/bin/bash
##arch/loongarch64.sh: Build definitions for Loongson 3A/B 5000.
##@copyright GPL-2.0+

CFLAGS_GCC_ARCH='-mabi=lp64d -march=loongarch64 -mtune=la464 -mlsx'

# Position-independent executable buildmode is not available on the LoongArch
# architecture. Removing for the loongarch64 (loong64) target.
GOFLAGS=${GOFLAGS/-buildmode=pie/}
