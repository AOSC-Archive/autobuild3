#!/bin/bash
##arch/_common_switches.sh: Switches sourced after defines.
##@license GPL-2.0+
if ((AB_FLAGS_PIC)); then LDFLAGS_COMMON+='-fPIC ' CFLAGS_COMMON+='-fPIC '; fi
if ((AB_FLAGS_PIE)); then LDFLAGS_COMMON+='-fPIE -pie ' CFLAGS_COMMON+='-fPIE '; fi
if ((AB_FLAGS_SSP)); then CFLAGS_COMMON+='-fstack-protector-strong --param=ssp-buffer-size=4 '; fi
if ((AB_FLAGS_RRO)); then LDFLAGS_COMMON+='-Wl,-z,relro '; fi
if ((AB_FLAGS_NOW)); then LDFLAGS_COMMON+='-Wl,-z,now '; fi
if ((AB_FLAGS_FTF)); then CPPFLAGS_COMMON+='-D_FORTIFY_SOURCE=2 '; fi
