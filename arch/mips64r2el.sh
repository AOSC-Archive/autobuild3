#!/bin/bash
##arch/mips64el.sh: Build definitions for mip64r2el (optimized for Loongson 3A).
##@copyright GPL-2.0+

# Configuration of old mips64el originally confirmed in #41@aosc-os-core.
# Suggested, discussed by:
#   - Junde Yhi <lmy441900@aosc.xyz>
#   - Artoria Wang <arthur2e5@aosc.xyz>
#   - Bob Cao <bobcao3@aosc.xyz>
#   - Mingcong Bai <jeffbai@aosc.xyz>
# Switched to mips64r2el by:
#   - Jiaxun Yang <jiaxun.yang@flygoat.com>
# Refactor modification by:
#   - Junde Yhi <lmy441900@aosc.xyz>

# '-mabi=64 -march=mips64r2 -mtune=loongson3a' are configured to be the default for GCC
# '-mno-madd4' is configured to be the default for GCC

# Loongson 3 workaround added to fix faulty design that may cause deadlocks
CFLAGS_COMMON_ARCH='-Wa,-mfix-loongson3-llsc,-mfix-loongson3-load '

LDFLAGS_COMMON_CROSS='-Wl,-rpath -Wl,/usr/lib -Wl,-rpath-link -Wl,/var/ab/cross-root/mips64r2el/usr/lib -L/var/ab/cross-root/mips64r2el/usr/lib '
