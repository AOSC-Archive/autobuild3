#!/bin/bash
##arch/ppc64el.sh: Build definitions for ppc64el.
##@copyright GPL-2.0+
CFLAGS_GCC_ARCH='-mcpu=power8 -mtune=power9 -mpower8-vector -mpower8-fusion -maltivec -mabi=altivec -msecure-plt -mvsx'
CFLAGS_CLANG_ARCH='-mcpu=power8 -mtune=power9 -mpower8-vector -maltivec -mabi=altivec -msecure-plt -mvsx'
CPPFLAGS_COMMON_ARCH='-DNO_WARN_X86_INTRINSICS '
