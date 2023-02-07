#!/bin/bash
##arch/ppc64el.sh: Build definitions for ppc64el.
##@copyright GPL-2.0+
CFLAGS_GCC_ARCH='-mcpu=power8 -mtune=power9 -msecure-plt -mvsx -mabi=ieeelongdouble'
CFLAGS_CLANG_ARCH='-mcpu=power8 -mtune=power9 -msecure-plt -mvsx -mabi=ieeelongdouble'
