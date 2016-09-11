#!/bin/bash
##arch/_common_switches.sh: Switches sourced after defines.
##@copyright GPL-2.0+
if ((AB_FLAGS_SSP)); then CFLAGS_COMMON+='-fstack-protector-strong --param=ssp-buffer-size=4 '; fi
if ((AB_FLAGS_RRO)); then LDFLAGS_COMMON+='-Wl,-z,relro '; fi
if ((AB_FLAGS_NOW)); then LDFLAGS_COMMON+='-Wl,-z,now '; fi
if ((AB_FLAGS_FTF)); then CPPFLAGS_COMMON+='-D_FORTIFY_SOURCE=2 '; fi
if ((AB_FLAGS_SPECS)); then LDFLAGS_COMMON+=" -specs=$AB/specs/hardened-ld "; CFLAGS_COMMON+=" -specs=$AB/specs/hardened-cc1 "; CXXFLAGS_COMMON+=" -specs=$AB/specs/hardened-cc1 "; fi

# Clang can handle PIE and PIC properly, let it do the old job.
if bool $USECLANG; then
	if ((AB_FLAGS_PIC)); then LDFLAGS_COMMON+='-fPIC ' CFLAGS_COMMON+='-fPIC '; fi
	if ((AB_FLAGS_PIE)); then LDFLAGS_COMMON+='-fPIE -pie ' CFLAGS_COMMON+='-fPIE '; fi
fi
