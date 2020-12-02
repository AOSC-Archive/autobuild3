#!/bin/bash
##arch/amd64.sh: Build definitions for amd64.
##@copyright GPL-2.0+
CFLAGS_COMMON_ARCH='-fomit-frame-pointer -march=x86-64 -mtune=sandybridge -msse2 '
RUSTFLAGS_COMMON_ARCH='-Ctarget-cpu=x86-64 '
