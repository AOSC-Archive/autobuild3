#!/bin/bash
##arch/loongson2f.sh: Build definitions for Loongson 2F.
##@copyright GPL-2.0+

# Retro: Overriding mainline definitions, and take more interest in reducing code size.
CFLAGS_COMMON_OPTI='-Os '
# Retro: Keeping -ftree-vectorization for MMI (effective?).

CFLAGS_COMMON_ARCH='-mabi=64 -march=mips3 -mtune=loongson2f '
CFLAGS_GCC_ARCH='-mloongson-mmi -Wa,-mfix-loongson2f-nop '

CFLAGS_GCC_OPTI_LTO="${CFLAGS_COMMON_OPTI_LTO} -flto-partition=none "
LDFLAGS_GCC_OPTI_LTO="${LDFLAGS_COMMON_OPTI_LTO} -mxgot -flto-partition=none "

RUSTFLAGS_COMMON_ARCH='-Ctarget-cpu=mips3 -Ctarget-features=+xgot,-mips64r2 '
RUSTFLAGS_COMMON_OPTI_LTO="${RUSTFLAGS_COMMON_OPTI_LTO} -Clink-arg=-Wl,-z,notext "

# Position-independent executable buildmode is not available on any mips architecture.
# Removing for loongson2f target.
GOFLAGS=${GOFLAGS/-buildmode=pie/}
