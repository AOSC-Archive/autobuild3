# Common archdef for all ab arches, unsettable so the flags can be erased.
AB_FLAGS_TYPES='_OPTI _ARCH _WEIRD '
AB_FLAGS_FEATURES='LTO PERMISSIVE '
# Naming, sadly. PORT_NOTICE!
ARCH_TARGET[amd64]=x86_64-unknown-linux-gnu
ARCH_TARGET[armel]=armv7a-hardfloat-linux-gnueabi
ARCH_TARGET[i386]=i686-pc-linux-gnu
ARCH_TARGET[mipsn32el]=mips64el-linux-gnuabin32
ARCH_RPM[amd64]=x86_64
ARCH_RPM[armel]=armfhp # real story: we are using neon.
ARCH_RPM[mipsn32el]=mips64el
# C Compiler Flags.
CFLAGS_COMMON='-pipe -Wno-error '
CFLAGS_COMMON_OPTI='-fomit-frame-pointer -O2 '
CFLAGS_COMMON_OPTI_LTO='-flto '
CFLAGS_COMMON_DEBUG='-O '	# not that frequently used since autotools know it.
CFLAGS_GCC_OPTI='-fira-loop-pressure -fira-hoist-pressure '
CFLAGS_GCC_DEBUG='-Og '		# note: not enabled for clang
CFLAGS_CLANG_OPTI_LTO='-O4 '
# C Specific Flags.
CFLAGS_COMMON_WEIRD=''
# What to add for C++ Compiler Flags.
CXXFLAGS_GCC_OPTI='-fdeclone-ctor-dtor '
CXXFLAGS_COMMON_WEIRD=''
CXXFLAGS_COMMON_PERMISSIVE="-fpermissive "
# Preprocesser Flags.
CPPFLAGS_COMMON='-O2 '
# OBJC Flags.
OBJCFLAGS_COMMON_WEIRD=''
# OBJCXX Flags.
OBJCXXFLAGS_COMMON_WEIRD=''
OBJCXXFLAGS_COMMON_PERMISSIVE="-fpermissive "
# Linker Flags.
# LDFLAGS writing helpers:
ld_arg(){ echo -n -Wl; local arg ABCOMMA=,; for arg; do abmkcomma; echo -n "$arg"; done; }
ld_path(){ local path=$(arch_lib "$@"); ld_arg "$path"; echo -n " -L$path"; }
LDFLAGS_COMMON='-Wl,-O1,--sort-common,--as-needed '
#LDFLAGS_COMMON_OPTI='-Wl,--relax '	# on some arches this interfere with debugging, therefore put into OPTI.
# temporarily disabled because this breaks core-devel/glibc build (-r cannot be used together with --relax).
# investigation advised.
LDFLAGS_COMMON_OPTI_LTO='-flto -fuse-linker-plugin '
LDFLAGS_COMMON_OPTI_NOLTO='-fno-lto -fno-use-linker-plugin '
LDFLAGS_COMMON_CROSS_BASE="-Wl,-rpath -Wl,/usr/lib -Wl,-rpath-link $(ld_path) "
# Switches for hardening related flags.
if ((AB_FLAGS_PIC)); then LDFLAGS_COMMON+='-fPIC ' CFLAGS_COMMON+='-fPIC '; fi
if ((AB_FLAGS_PIE)); then LDFLAGS_COMMON+='-fPIE -pie ' CFLAGS_COMMON+='-fPIE '; fi
if ((AB_FLAGS_SSP)); then CFLAGS_COMMON+='-fstack-protector-strong --param=ssp-buffer-size=4 '; fi
if ((AB_FLAGS_RRO)); then LDFLAGS_COMMON+='-Wl,-z,relro '; fi
if ((AB_FLAGS_NOW)); then LDFLAGS_COMMON+='-Wl,-z,now '; fi
if ((AB_FLAGS_FTF)); then CPPFLAGS_COMMON+='-D_FORTIFY_SOURCE=2 '; fi
