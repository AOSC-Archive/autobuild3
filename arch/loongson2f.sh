#!/bin/bash
##arch/loongson2f.sh: Build definitions for Loongson 2F.
##@copyright GPL-2.0+

# Retro: Overriding mainline definitions, and take more interest in reducing code size.
CFLAGS_COMMON_OPTI='-Os '
# Retro: Keeping -ftree-vectorization for MMI (effective?).

CFLAGS_COMMON_ARCH='-mabi=64 -march=mips3 -mtune=loongson2f -mloongson-mmi -Wa,-mfix-loongson2f-nop '
