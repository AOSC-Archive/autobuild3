#!/bin/bash
##arch/loongson2_mmi.sh: Optimisation overlay for MMI-enabled Loongson2 (2F).
##@copyright GPL-2.0+
CFLAGS_COMMON_ARCH='-mabi=64 -march=loongson2f -mloongson-mmi -Wa,-mfix-loongson2f-jump,-mfix-loongson2f-nop '
