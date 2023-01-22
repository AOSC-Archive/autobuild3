#!/bin/bash
##arch/riscv64.sh: Build definitions for riscv64.
##@copyright GPL-2.0+
LDFLAGS_COMMON_CROSS='-Wl,-rpath -Wl,/usr/lib -Wl,-rpath-link -Wl,/var/ab/cross-root/riscv64/usr/lib -L/var/ab/cross-root/riscv64/usr/lib '
