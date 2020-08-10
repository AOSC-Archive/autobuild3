#!/bin/bash
# 12-cmake.sh: Builds cmake stuffs
##@copyright GPL-2.0+
abtryexe cmake || ablibret

build_cmake_probe(){
	[ -f CMakeLists.txt ]
}

build_cmake_build(){
	local _ret
	ABSHADOW=${ABSHADOW_CMAKE-$ABSHADOW}
	if bool $ABSHADOW
	then
		rm -rf build
		abinfo "Creating directory for shadow build ..."
		mkdir build || abdie "Failed creating \$SRCDIR/build"
		cd build
	fi
	BUILD_START
	abinfo "Running CMakeLists.txt to generate Makefile ..."
	cmake $SRCDIR $CMAKE_DEF $CMAKE_AFTER
	BUILD_READY
	abinfo "Building binaries ..."
	make $ABMK $MAKE_AFTER
	BUILD_FINAL
	abinfo "Installing binaries ..."
	make DESTDIR=$PKGDIR $MAKE_AFTER install || _ret=$PIPESTATUS
	if bool $ABSHADOW
	then
		cd ..
	fi
	return $_ret
}
ABBUILDS+=' cmake'
