#!/bin/bash
##arch/armel.sh: Build definitions for armel.
##@copyright GPL-2.0+

# Retro: Overriding mainline definitions, and take more interest in reducing code size.
CFLAGS_COMMON_OPTI='-Os '
# Retro: Also disabling -ftree-vectorization which could potentially enlarge code size.
CFLAGS_GCC_OPTI='-fira-loop-pressure -fira-hoist-pressure '

CFLAGS_COMMON_ARCH='-march=armv5te -mtune=arm1176jzf-s -mfloat-abi=soft '
