#!/bin/bash
##arch/loongson2.sh: Build definitions for Loongson 2F.
##@copyright GPL-2.0+
CFLAGS_COMMON_ARCH='-mabi=64 -march=loongson2f -mloongson-mmi -Wa,-mfix-loongson2f-nop '
