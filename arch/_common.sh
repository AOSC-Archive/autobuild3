#!/bin/bash
##arch/_common.sh: Common arch defs for all ab arches, defines-mutable.
##@copyright GPL-2.0+
AB_FLAGS_TYPES='_OPTI _ARCH _WEIRD '
AB_FLAGS_FEATURES='LTO PERMISSIVE '
# Naming, sadly. PORT_NOTICE!
ARCH_TARGET['amd64']=x86_64-aosc-linux-gnu
ARCH_TARGET['amd64/avx+']=x86_64-aosc-linux-gnu
ARCH_TARGET['amd64/avx2+']=x86_64-aosc-linux-gnu
ARCH_TARGET['arm64']=aarch64-aosc-linux-gnu
ARCH_TARGET['armel']=arm-aosc-linux-gnueabi
ARCH_TARGET['armhf']=arm-aosc-linux-gnueabihf
ARCH_TARGET['i386']=i686-aosc-linux-gnu
ARCH_TARGET['i486']=i486-aosc-linux-gnu
ARCH_TARGET['loongson2']=mips64el-aosc-linux-gnuabi64
ARCH_TARGET['mips64r2el']=mipsisa64r2el-aosc-linux-gnuabi64
ARCH_TARGET['powerpc']=powerpc-aosc-linux-gnu
ARCH_TARGET['ppc64']=powerpc64-aosc-linux-gnu
ARCH_TARGET['ppc64el']=powerpc64le-aosc-linux-gnu
ARCH_TARGET['riscv64']=riscv64-aosc-linux-gnu
# C Compiler Flags.
CFLAGS_COMMON='-pipe -Wno-error '
CFLAGS_COMMON_OPTI='-O2 '
CFLAGS_COMMON_DEBUG='-O0 '	# not that frequently used since autotools know it.
CFLAGS_GCC=' '
CFLAGS_GCC_OPTI="-fira-loop-pressure -fira-hoist-pressure -ftree-vectorize "
CFLAGS_GCC_OPTI_LTO="-flto=$ABTHREADS "
CFLAGS_GCC_DEBUG='-Og '		# note: not enabled for clang
# CFLAGS_CLANG='-fno-integrated-as ' # GNU as has compatibility issue with clang on ARMv8.[01]
CFLAGS_CLANG_OPTI_LTO='-flto '
# C Specific Flags.
CFLAGS_COMMON_WEIRD=''
# What to add for C++ Compiler Flags.
CXXFLAGS_GCC_OPTI="-fdeclone-ctor-dtor -ftree-vectorize "
CXXFLAGS_COMMON_WEIRD=''
CXXFLAGS_COMMON_PERMISSIVE="-fpermissive "
# Preprocesser Flags.
CPPFLAGS_COMMON="-D_GLIBCXX_ASSERTIONS "
# OBJC Flags.
OBJCFLAGS_COMMON_WEIRD=''
# OBJCXX Flags.
OBJCXXFLAGS_COMMON_WEIRD=''
OBJCXXFLAGS_COMMON_PERMISSIVE="-fpermissive "
# RUST Flags.
RUSTFLAGS_COMMON=''
RUSTFLAGS_COMMON_OPTI='-Ccodegen-units=1 -Copt-level=3 '
RUSTFLAGS_COMMON_WEIRD=''
# LLVMGold is specified here otherwise it will try to find lld for lto
RUSTFLAGS_COMMON_OPTI_LTO='-Clinker-plugin-lto="/usr/lib/LLVMgold.so" '
# Linker Flags. (actually passed to your CC, just FYI)
# LDFLAGS writing helpers:
ld_arg(){ printf %s '-Wl'; local IFS=,; printf %s "$*"; }
ld_path(){ local path=$(arch_lib "$@"); ld_arg "$path"; echo -n " -L$path"; }
LDFLAGS_COMMON="-Wl,-O1,--sort-common,--as-needed "
#LDFLAGS_COMMON_OPTI='-Wl,--relax '	# on some arches this interfere with debugging, therefore put into OPTI.
# temporarily disabled because this breaks core-devel/glibc build (-r cannot be used together with --relax).
# investigation advised.
LDFLAGS_COMMON_OPTI_LTO="-flto -fuse-linker-plugin "
LDFLAGS_COMMON_OPTI_NOLTO='-fno-lto -fuse-linker-plugin '
LDFLAGS_COMMON_CROSS_BASE="-Wl,-rpath -Wl,/usr/lib -Wl,-rpath-link $(ld_path) "
