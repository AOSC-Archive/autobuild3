#!/bin/bash
##arch/amd64.sh: Build definitions for amd64.
##@copyright GPL-2.0+
CFLAGS_COMMON_ARCH='-march=x86-64 -mtune=core2 -msse -msse2 -msse3 -ftree-vectorize '
