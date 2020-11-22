#!/bin/bash
##arch/loongson3.sh: Build definitions for Loongson 3A/B 1000-4000+.
##@copyright GPL-2.0+
CFLAGS_GCC_ARCH='-mabi=64 -march=gs464 -mtune=gs464e -mfix-loongson3-llsc '
CFLAGS_CLANG_ARCH='-mabi=64 -march=mips64r2 -mtune=mips64r2 '
# Disable full LTO on loongson3 (Rust will use scoped/local LTO)
# Reason why bfd isn't working: https://bugs.llvm.org/show_bug.cgi?id=47872
RUSTFLAGS_COMMON_OPTI_LTO='-Clink-arg=-flto -Clinker=clang -Clink-arg=-fuse-ld=gold '
