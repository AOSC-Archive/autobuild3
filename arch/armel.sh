#!/bin/bash
##arch/armel.sh: Build definitions for armel.
##@copyright GPL-2.0+
CFLAGS_COMMON_ARCH='-march=armv5te -mtune=arm1176jzf-s -mfloat-abi=soft '
LDFLAGS_COMMON_CROSS='-Wl,-rpath -Wl,/usr/lib -Wl,-rpath-link -Wl,/var/ab/cross-root/armel/usr/lib -L/var/ab/cross-root/armel/usr/lib '
