#!/bin/bash
##arch/i386.sh: Build definitions for i386 (the subsystem that runs on amd64 cpus)
##@copyright GPL-2.0+
[[ $ABBUILD != $ABHOST ]] || abdie "The i386 arch is cross-only, for multilib purposes."
CFLAGS_COMMON_ARCH='-fomit-frame-pointer -march=pentium4 -mtune=core2 -msse -msse2 -msse3 '
HOSTTOOLPREFIX=/opt/32/bin/i686-pc-linux-gnu
export PKG_CONFIG_DIR=/opt/32/lib/pkgconfig
unset LDFLAGS_COMMON_CROSS_BASE
