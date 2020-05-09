#!/bin/bash
##arch/armel.sh: Build definitions for armel.
##@copyright GPL-2.0+
CFLAGS_COMMON_ARCH='-march=armv5te -mtune=armv6k -mfloat-abi=soft '
LDFLAGS_COMMON_CROSS='-Wl,-rpath -Wl,/usr/lib -Wl,-rpath-link -Wl,/var/ab/cross-root/armel/usr/lib -L/var/ab/cross-root/armel/usr/lib '
