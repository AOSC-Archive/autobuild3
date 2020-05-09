#!/bin/bash
##arch/loongson2.sh: Build definitions for Loongson 2E/F.
##@copyright GPL-2.0+
CFLAGS_COMMON_ARCH='-EL -mabi=64 -march=loongson2e -mtune=loongson2f '
LDFLAGS_COMMON_CROSS='-Wl,-rpath -Wl,/usr/lib -Wl,-rpath-link -Wl,/var/ab/cross-root/loongson2/usr/lib -L/var/ab/cross-root/loongson2/usr/lib '
