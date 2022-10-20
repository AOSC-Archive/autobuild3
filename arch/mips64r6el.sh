#!/bin/bash
##arch/mips64r6el.sh: Build definitions for mips64r6el.
##@copyright GPL-2.0+
CFLAGS_COMMON_ARCH='-march=mips64r6 -mtune=mips64r6 '
RUSTFLAGS_COMMON_ARCH='-Ctarget-cpu=mips64r6 '
