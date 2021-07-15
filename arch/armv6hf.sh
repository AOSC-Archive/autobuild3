#!/bin/bash
##arch/armv6hf.sh: Build definitions for ARMv6 (hard float).
##@copyright GPL-2.0+

# Retro: Overriding mainline definitions, and take more interest in reducing code size.
CFLAGS_COMMON_OPTI='-Os '
# Retro: Keeping -ftree-vectorization for NEON.

CFLAGS_COMMON_ARCH='-march=armv6 -mtune=arm1176jz-s -mfloat-abi=hard -mthumb '
