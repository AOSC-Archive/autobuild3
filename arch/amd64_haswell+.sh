#!/bin/bash
##arch/amd64_avx2.sh: Build definitions for amd64 with AVX2 support.
##@copyright GPL-2.0+
CFLAGS_COMMON_ARCH='-march=x86-64 -mavx2 -mpclmul -mfsgsbase -mfma -mbmi -mbmi2 -mf16c '
