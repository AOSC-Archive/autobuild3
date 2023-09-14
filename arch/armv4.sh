#!/bin/bash
##arch/armv4.sh: Build definitions for ARMv4 (w/o THUMB).
##@copyright GPL-2.0+

# Retro: Overriding mainline definitions, and take more interest in reducing code size.
CFLAGS_COMMON_OPTI='-Os -ffunction-sections -fdata-sections '
LDFLAGS_COMMON_OPTI='-Wl,--gc-sections '
# Retro: Also disabling -ftree-vectorization which could potentially enlarge code size.
CFLAGS_GCC_OPTI='-fira-loop-pressure -fira-hoist-pressure '

CFLAGS_COMMON_ARCH='-march=armv4 -mtune=strongarm110 -mfloat-abi=soft '
