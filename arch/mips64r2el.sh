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


CFLAGS_COMMON_ARCH='-EL  -mabi=64 -march=mips64r2 -mtune=loongson3a  -mllsc -without-madd4'

# Loongson binutils fixes -mfix-loongson3-llsc, -mfix-loongson3-load is disableed. And should
# be enabled in binutils patch.
# Disable madd4 instructions beacuse Loongson have madd4 implementation that is different
# from standard mips64r2. 
