# Common archdef for all ab arches, unsettable so the flags can be erased.
AB_FLAGS_TYPES='_OPTI _ARCH '
AB_FLAGS_FEATURES='LTO '
AB_FLAGS_PIC=1
# C Compiler Flags.
CFLAGS_COMMON='-pipe -fstack-protector-strong --param=ssp-buffer-size=4 -Wno-error '
CFLAGS_COMMON_OPTI='-fomit-frame-pointer '
CFLAGS_COMMON_OPTI_LTO='-O3 -flto ' # eq. clang -O4
CFLAGS_COMMON_OPTI_NOLTO='-O2 '
CFLAGS_COMMON_DEBUG='-O '	# not that frequently used since autotools know it.
CFLAGS_GCC_DEBUG='-Og '		# note: not enabled for clang
# C Specific Flags.
CFLAGS_WEIRD=''
# What to add for C++ Compiler Flags.
CXXFLAGS_COMMON=''
# Preprocesser Flags.
CPPFLAGS_COMMON='-D_FORTIFY_SOURCE=2 '
# Linker Flags.
LDFLAGS_COMMON='-Wl,-O1,--sort-common,--as-needed,-z,relro '
LDFLAGS_COMMON_OPTI='--relax '	# on some arches this interfere with debugging, therefore put into OPTI.
LDFLAGS_COMMON_OPTI_LTO='-flto -fuse-linker-plugin '
LDFLAGS_COMMON_OPTI_NOLTO='-flto -fnouse-linker-plugin '

if ((AB_FLAGS_PIC)); then LDFLAGS_COMMON+='-fPIC ' CFLAGS_COMMON+='-fPIC '; fi 
