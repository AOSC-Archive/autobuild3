#!/bin/bash
##arch/ppc64.sh: Build definitions for PowerPC64 (PowerPC G5+)
##@copyright GPL-2.0+

# Retro: Overriding mainline definitions, and take more interest in reducing code size.
CFLAGS_COMMON_OPTI='-Os '
# Retro: Keeping -ftree-vectorization for AltiVec.
CFLAGS_GCC_OPTI='-fira-loop-pressure -fira-hoist-pressure '

CFLAGS_COMMON_ARCH=' -m64 -mcpu=G5 -maltivec -mabi=altivec -msecure-plt -mhard-float '
