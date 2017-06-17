#!/bin/bash
##arch/mipsel.sh: Build definitions for mipsel (optimized for Loongson 2F).
##@copyright GPL-2.0+
# FIXME: Loongson workaround added as suggested by biergaizi, do this break anything?
# Global -mshared flag since GCC sets -mno-shared by default when compiling non-PIC.
# Not using -fPIC globally to avoid overriding -fPIE in GCC specs.
# Adapted from Void Linux: https://github.com/voidlinux/void-packages/commit/882f23cf980d2277594b5f5c036114c0c4d9228a
CFLAGS_COMMON_ARCH='-march=mips2 -mtune=loongson2f -mabi=32 -Wa,-mfix-loongson2f-nop -mshared '
#LDFLAGS_COMMON_ARCH='-Wl,--hash-style=sysv '
