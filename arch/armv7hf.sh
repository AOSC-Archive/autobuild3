#!/bin/bash
##arch/armv7hf.sh: Build definitions for ARMv7 (hard float, w/ NEON).
##@copyright GPL-2.0+

# Retro: Overriding mainline definitions, and take more interest in reducing code size.
CFLAGS_COMMON_OPTI='-Os -ffunction-sections -fdata-sections '
LDFLAGS_COMMON_OPTI='-Wl,--gc-sections '
# Retro: Keeping -ftree-vectorization for NEON.

CFLAGS_COMMON_ARCH='-march=armv7-a -mtune=cortex-a7 -mfloat-abi=hard -mfpu=neon -mthumb '
