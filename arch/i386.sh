#!/bin/bash
##arch/i386.sh: Build definitions for i386 (subsystem only).
##@license GPL-2.0+
[ "$CROSS" ] || aberr "The i386 arch is cross-only, for multilib purposes."
CFLAGS_COMMON_ARCH='-march=pentium4 -mtune=core2 -msse -msse2 -msse3 '
HOSTTOOLPREFIX=/opt/32/bin/i686-pc-linux-gnu
export PKG_CONFIG_DIR=/opt/32/lib/pkgconfig
unset LDFLAGS_COMMON_CROSS_BASE
