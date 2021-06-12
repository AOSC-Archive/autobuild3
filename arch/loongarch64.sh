#!/bin/bash
##arch/loongarch64.sh: Build definitions for Loongson 3A/B 5000.
##@copyright GPL-2.0+

CFLAGS_GCC_ARCH='-mabi=lp64 -march=loongarch64 -mtune=loongarch64 -mfix-loongson3-llsc'
