#!/bin/bash
# build/00-self.sh: Invokes `build` defs.
##@copyright GPL-2.0+
abtrylib arch || ablibret

build_self_probe(){
	[ -f "$(arch_trymore=1 arch_findfile build)" ]
}

build_self_build(){
	BUILD_START
	if ! bool $ABSTAGE2; then
		arch_loadfile_strict build || \
			abdie "Failed to run self-defined build script: $?."
	else
		if arch_findfile build.stage2; then
			abwarn "ABSTAGE2 returned true, loading stage2 build script ..."
			arch_loadfile_strict build.stage2 || \
				abdie "Failed to run self-defined stage2 build script: $?."
		else
			abwarn "ABSTAGE2 returned true, loading stage2 build script ..."
			abwarn "Could not find self-defined stage2 build script, falling back to normal build script ..."
			arch_loadfile_strict build || \
				abdie "Failed to run self-defined build script: $?."
		fi
	fi

	cd "$SRCDIR"
}

ABBUILDS='self'
# Soga...
