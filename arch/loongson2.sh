#!/bin/bash
##arch/loongson2.sh: Build definitions for Loongson 2E/F.
##@copyright GPL-2.0+
CFLAGS_COMMON_ARCH='-mabi=64 -march=mips3 -mtune=loongson2f -Wa,-mfix-loongson2f-jump,-mfix-loongson2f-nop '
