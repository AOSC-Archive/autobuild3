#!/bin/bash
##arch/mips64r2el_gs464e.sh: Optimisation overlay for Loongson GS464e.
##@copyright GPL-2.0+
CFLAGS_COMMON_ARCH='-mabi=64 -march=gs464e -mloongson-mmi -mloongson-ext -Wa,-mfix-loongson3-llsc '
