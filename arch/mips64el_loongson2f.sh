#!/bin/bash
##arch/mips64el_loongson2f.sh: Optimisation overlay for Loongson 2F.
##@copyright GPL-2.0+
CFLAGS_COMMON_ARCH='-mabi=64 -march=loongson2f -mloongson-mmi -Wa,-mfix-loongson2f-jump,-mfix-loongson2f-nop '
