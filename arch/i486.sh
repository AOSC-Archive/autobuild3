#!/bin/bash
##arch/i486.sh: Build definitions for i486.
##@copyright GPL-2.0+

# Retro: Overriding mainline definitions, and take more interest in reducing code size.
CFLAGS_COMMON_OPTI='-Os -ffunction-sections -fdata-sections '
LDFLAGS_COMMON_OPTI='-Wl,--gc-sections '
# Retro: Also disabling -ftree-vectorization which could potentially enlarge code size.
CFLAGS_GCC_OPTI='-fira-loop-pressure -fira-hoist-pressure '

CFLAGS_COMMON_ARCH='-march=i486 -mtune=bonnell '

RUSTFLAGS_COMMON_ARCH='-Ctarget-cpu=i486 -Clink-args=-latomic '
