#!/bin/bash
##arch/mips64r6el.sh: Build definitions for mips64r6el.
##@copyright GPL-2.0+
CFLAGS_COMMON_ARCH='-march=mips64r6 -mtune=mips64r6 -mcompact-branches=always -mmsa '

# FIXME: -Cdebuginfo=0 enables rustc to build programs on mips64r6el,
# overriding all project configuration and build profile settings.
# Generating debuginfo crashes LLVM (as of 15.0.7).
#
# FIXME: --cfg=rustix_use_libc works around an issue where a crate named
# rustix contains MIPS64 R2 assembly, without being able to distinguish between
# R2 and R6 assemblies. Enabling this options instructs rustix to use the libc
# backend instead.
RUSTFLAGS_COMMON_ARCH='-Ctarget-cpu=mips64r6 -Cdebuginfo=0 -Ctarget-feature=+msa -Cllvm-args=--mips-compact-branches=always --cfg=rustix_use_libc '
