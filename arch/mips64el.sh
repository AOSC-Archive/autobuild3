#!/bin/bash
##arch/mips64el.sh: Build definitions for mips64el (optimized for Loongson 2F).
##@copyright GPL-2.0+

# '-mabi=64 -march=mips3 -mtune=loongson2f' are configured to be the default for GCC

# Loongson 2F workaround added (as suggested by biergaizi) to fix bugs in early batches (1 and 2)
CFLAGS_COMMON_ARCH='-Wa,-mfix-loongson2f-nop,-mfix-loongson2f-jump '
