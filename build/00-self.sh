#!/bin/bash
# build/00-self.sh: Invokes `build` defs.
##@copyright GPL-2.0+
abtrylib arch || ablibret

build_self_probe(){
	[ -f "$(arch_trymore=1 arch_findfile build)" ]
}

build_self_build(){
	BUILD_START
	arch_loadfile_strict build \
		|| abdie "Failed to run self-defined build script: $?."
	cd "$SRCDIR"
}

ABBUILDS='self'
# Soga...
