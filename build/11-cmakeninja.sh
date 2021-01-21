#!/bin/bash
# 13-cmakeninja.sh: Builds cmake with Ninja
##@copyright GPL-2.0+
(abtryexe cmake && abtryexe ninja) || ablibret

build_cmakeninja_probe(){
	[ -f CMakeLists.txt ]
}

build_cmakeninja_build(){
	local _ret
	ABSHADOW=${ABSHADOW_CMAKE-$ABSHADOW}
	if bool "$ABSHADOW"
	then
		rm -rf build
		abinfo "Creating directory for shadow build ..."
		mkdir build || abdie "Failed creating \$SRCDIR/build"
		cd build || abdie "Failed to enter $SRCDIR/build"
	fi
	BUILD_START
	abinfo "Running CMakeLists.txt to generate Makefile ..."
	cmake "$SRCDIR" $CMAKE_DEF $CMAKE_AFTER -GNinja || _ret="${PIPESTATUS[0]}"
	BUILD_READY
	abinfo "Building and installing binaries ..."
	DESTDIR="$PKGDIR" cmake --install . -- $ABMK $MAKE_AFTER || _ret="${PIPESTATUS[0]}"
	BUILD_FINAL
	if bool "$ABSHADOW"
	then
		cd ..
	fi
	return $_ret
}
ABBUILDS+=' cmakeninja'
