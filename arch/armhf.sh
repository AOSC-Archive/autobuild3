#!/bin/bash
##arch/armhf.sh: Build definitions for armhf.
##@copyright GPL-2.0+
CFLAGS_COMMON_ARCH='-march=armv7-a -mtune=cortex-a7 -mfloat-abi=hard -mfpu=neon -mthumb '
LDFLAGS_COMMON_CROSS='-Wl,-rpath -Wl,/usr/lib -Wl,-rpath-link -Wl,/var/ab/cross-root/armhf/usr/lib -L/var/ab/cross-root/armhf/usr/lib '
