#!/bin/bash
##arch/mips64r2el.sh: Build definitions for mips64el, MIPS64r2 ISA.
##@copyright GPL-2.0+
# Configuration of old mips64el originally confirmed in #41@aosc-os-core.
# Suggested, discussed by:
#   - Junde Yhi <lmy441900@aosc.xyz>
#   - Artoria Wang <arthur2e5@aosc.xyz>
#   - Bob Cao <bobcao3@aosc.xyz>
#   - Mingcong Bai <jeffbai@aosc.xyz>
# Switched to mips64r2el by:
#   - Jiaxun Yang <jiaxun.yang@flygoat.com>

# `-mno-madd4` disable the MIPS multiply-add instructions, since Loongson chips
# implement them as fused multiply-add, which is different from what is
# specified in the MIPS64r2 specification.

CFLAGS_COMMON_ARCH='-mabi=64 -march=mips64r2 -mtune=gs464e -mno-madd4 -Wa,-mfix-loongson3-llsc '
