#!/bin/bash
# 12-cmake.sh: Builds cmake stuff
##@copyright GPL-2.0+
abtryexe cmake || ablibret

build_cmake_probe(){
	[ -f CMakeLists.txt ]
}

build_cmake_build(){
	local _ret
	ABSHADOW=${ABSHADOW_CMAKE-$ABSHADOW}
	if bool "$ABSHADOW"
	then
		rm -rf build
		abinfo "Creating directory for shadow build ..."
		mkdir build || abdie "Failed creating \$SRCDIR/build"
		cd build || _ret=1
	fi
	BUILD_START
	abinfo "Running CMakeLists.txt to generate Makefile ..."
	cmake "$SRCDIR" $CMAKE_DEF $CMAKE_AFTER || _ret="${PIPESTATUS[0]}"
	BUILD_READY
	abinfo "Building binaries ..."
	cmake --build . -- $ABMK $MAKE_AFTER || _ret="${PIPESTATUS[0]}"
	BUILD_FINAL
	abinfo "Installing binaries ..."
	DESTDIR="$PKGDIR" cmake --install . || _ret="${PIPESTATUS[0]}"
	if bool "$ABSHADOW"
	then
		cd ..
	fi
	return $_ret
}
ABBUILDS+=' cmake'
