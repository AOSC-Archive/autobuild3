#!/bin/bash
##arch/amd64_avx.sh: Build definitions for amd64 with AVX support.
##                   Intel SandyBridge and AMD Bulldozer or later processors.
##@copyright GPL-2.0+
CFLAGS_COMMON_ARCH=' -fomit-frame-pointer -march=sandybridge '
RUSTFLAGS_COMMON_ARCH='-Ctarget-cpu=sandybridge '
