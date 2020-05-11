#!/bin/bash
##arch/mips64el.sh: Build definitions for mips64el, MIPS-III ISA.
##@copyright GPL-2.0+
CFLAGS_COMMON_ARCH='-mabi=64 -march=mips3 -mtune=loongson2f -Wa,-mfix-loongson2f-jump,-mfix-loongson2f-nop '
