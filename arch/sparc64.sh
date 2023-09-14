#!/bin/bash
##arch/sparc64.sh: Build definitions for i486.
##@copyright GPL-2.0+

# Retro: Overriding mainline definitions, and take more interest in reducing code size.
CFLAGS_COMMON_OPTI='-Os -ffunction-sections -fdata-sections '
LDFLAGS_COMMON_OPTI='-Wl,--gc-sections '
# Retro: Also disabling -ftree-vectorization which could potentially enlarge code size.
CFLAGS_GCC_OPTI='-fira-loop-pressure -fira-hoist-pressure '

CFLAGS_COMMON_ARCH='-march=v9 -mv8plus -mvis -m64 -mcmodel=medany '

RUSTFLAGS_COMMON_ARCH='-Ctarget-cpu=v9 -Ctarget-feature=+vis -Ccode-model=medium'
