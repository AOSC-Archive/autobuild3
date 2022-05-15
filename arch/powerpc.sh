#!/bin/bash
##arch/powerpc.sh: Build definitions for PPC (PowerPC G3+)
##@copyright GPL-2.0+

# Retro: Overriding mainline definitions, and take more interest in reducing code size.
CFLAGS_COMMON_OPTI='-Os '
# Retro: Also disabling -ftree-vectorization which could potentially enlarge code size.
CFLAGS_GCC_OPTI='-fira-loop-pressure -fira-hoist-pressure '

CFLAGS_COMMON_ARCH=' -m32 -mcpu=G3 -mtune=G4 -mno-altivec -msecure-plt -mhard-float '

# Position-independent executable buildmode is not available on PowerPC 32-bit architecture.
# Removing for powerpc target.
GOFLAGS=${GOFLAGS/-buildmode=pie/}
