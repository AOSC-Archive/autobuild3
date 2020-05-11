#!/bin/bash
##arch/arm64.sh: Build definitions for arm64.
##@copyright GPL-2.0+
CFLAGS_COMMON_ARCH='-march=armv8-a -mtune=cortex-a53'
RUSTFLAGS_COMMON_ARCH='-Ctarget-cpu=generic '
LDFLAGS_COMMON_CROSS='-Wl,-rpath -Wl,/usr/lib -Wl,-rpath-link -Wl,/var/ab/cross-root/arm64/usr/lib -L/var/ab/cross-root/arm64/usr/lib '
