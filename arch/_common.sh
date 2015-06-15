# Common archdef for all ab arches, unsettable so the flags can be erased.
AB_FLAGS_TYPES='_OPTI _ARCH '
AB_FLAGS_FEATURES='LTO '
AB_FLAGS_PIC=1
# C Compiler Flags.
CFLAGS_COMMON='-pipe -fstack-protector-strong --param=ssp-buffer-size=4 -Wno-error '
CFLAGS_COMMON_OPTI='-fomit-frame-pointer -O2 '
CFLAGS_COMMON_OPTI_LTO='-flto '
CFLAGS_COMMON_DEBUG='-O '	# not that frequently used since autotools know it.
CFLAGS_GCC_OPTI='-fira-loop-pressure -fira-hoist-pressure '
CFLAGS_GCC_DEBUG='-Og '		# note: not enabled for clang
CFLAGS_CLANG_OPTI_LTO='-O4 '
# C Specific Flags.
CFLAGS_WEIRD=''
# What to add for C++ Compiler Flags.
CXXFLAGS_GCC_OPTI='-fdeclone-ctor-dtor '
# Preprocesser Flags.
CPPFLAGS_COMMON='-D_FORTIFY_SOURCE=2 '
# Linker Flags.
LDFLAGS_COMMON='-Wl,-O1,--sort-common,--as-needed,-z,relro '
LDFLAGS_COMMON_OPTI='--relax '	# on some arches this interfere with debugging, therefore put into OPTI.
LDFLAGS_COMMON_OPTI_LTO='-flto -fuse-linker-plugin '
LDFLAGS_COMMON_OPTI_NOLTO='-fno-lto -fno-use-linker-plugin '

if ((AB_FLAGS_PIC)); then LDFLAGS_COMMON+='-fPIC ' CFLAGS_COMMON+='-fPIC '; fi 
