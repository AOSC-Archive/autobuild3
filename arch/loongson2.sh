#!/bin/bash
##arch/loongson2.sh: Build definitions for Loongson 2E/F.
##@copyright GPL-2.0+
CFLAGS_COMMON_ARCH='-mabi=64 -march=loongson2e -mtune=loongson2f -Wa,-mfix-loongson2f-jump,-mfix-loongson2f-nop '
LDFLAGS_COMMON_CROSS='-Wl,-rpath -Wl,/usr/lib -Wl,-rpath-link -Wl,/var/ab/cross-root/loongson2/usr/lib -L/var/ab/cross-root/loongson2/usr/lib '
