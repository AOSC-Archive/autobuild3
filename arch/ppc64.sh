#!/bin/bash
##arch/ppc64.sh: Build definitions for PowerPC64 (PowerPC G5+)
##@copyright GPL-2.0+
CFLAGS_COMMON_ARCH=' -m64 -mtune=G5 -maltivec -maltivec=be -mabi=altivec -msecure-plt -mhard-float '
