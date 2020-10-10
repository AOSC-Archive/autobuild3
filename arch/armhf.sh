#!/bin/bash
##arch/armhf.sh: Build definitions for armhf.
##@copyright GPL-2.0+

# Retro: Overriding mainline definitions, and take more interest in reducing code size.
CFLAGS_COMMON_OPTI='-Os '
# Retro: Keeping -ftree-vectorization for NEON.

CFLAGS_COMMON_ARCH='-march=armv7-a -mtune=cortex-a7 -mfloat-abi=hard -mfpu=neon -mthumb '
