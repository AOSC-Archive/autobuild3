#!/bin/bash
##arch/mips64el.sh: Build definitions for mip64el (optimized for Loongson 2F).
##@copyright GPL-2.0+
CFLAGS_COMMON_ARCH='-EL -mabi=64 -march=mips3 -mtune=loongson2e '
LDFLAGS_COMMON_CROSS='-Wl,-rpath -Wl,/usr/lib -Wl,-rpath-link -Wl,/var/ab/cross-root/mips64el/usr/lib -L/var/ab/cross-root/mips64el/usr/lib '
