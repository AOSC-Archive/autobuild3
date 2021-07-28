#!/bin/bash
##arch/ppc64.sh: Build definitions for PowerPC64 (PowerPC G5+)
##@copyright GPL-2.0+

# Retro: Overriding mainline definitions, and take more interest in reducing code size.
CFLAGS_COMMON_OPTI='-Os '
# Retro: Keeping -ftree-vectorization for AltiVec.
CFLAGS_COMMON_ARCH=' -m64 -mcpu=G5 -maltivec -mabi=altivec -msecure-plt -mhard-float '

CFLAGS_GCC_OPTI_LTO="${CFLAGS_COMMON_OPTI_LTO} -flto-partition=none "
LDFLAGS_GCC_OPTI_LTO="${LDFLAGS_COMMON_OPTI_LTO} -flto-partition=none "

# LLD does not support POWER ABI v1.
RUSTFLAGS_COMMON_OPTI_LTO='-Clink-arg=-fuse-ld=bfd -Clink-arg=-Wl,-build-id=sha1'
