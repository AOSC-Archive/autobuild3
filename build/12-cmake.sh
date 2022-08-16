#!/bin/bash
# 12-cmake.sh: Builds cmake stuff
##@copyright GPL-2.0+
abtryexe cmake || ablibret

build_cmake_probe(){
	[ -f "$SRCDIR"/CMakeLists.txt ]
}

build_cmake_build(){
	ABSHADOW=${ABSHADOW_CMAKE-$ABSHADOW}
	if bool "$ABSHADOW"; then
		abinfo "Creating directory for shadow build ..."
		mkdir -pv "$BLDDIR" \
			|| abdie "Failed to create shadow build directory: $?."
		cd "$BLDDIR" \
			|| abdie "Failed to enter shadow build directory: $?."
	fi
	BUILD_START

	abinfo "Running CMakeLists.txt to generate Makefile ..."
	if abisarray CMAKE_AFTER; then
		cmake "$SRCDIR" $CMAKE_DEF "${CMAKE_AFTER[@]}" \
			|| abdie "Failed to run CMakeLists.txt: $?."
	else
		cmake "$SRCDIR" $CMAKE_DEF $CMAKE_AFTER \
			|| abdie "Failed to run CMakeLists.txt: $?."
	fi
	BUILD_READY

	if bool "$ABUSECMAKEBUILD"; then
	abinfo "Building binaries ..."
	cmake --build . -- $ABMK $MAKE_AFTER \
		|| abdie "Failed to build binaries: $?."
	BUILD_FINAL
	abinfo "Installing binaries ..."
	DESTDIR="$PKGDIR" cmake --install . \
		|| abdie "Failed to install binaries: $?."
	else
	abinfo "Building binaries ..."
	make $ABMK $MAKE_AFTER \
		|| abdie "Failed to build binaries: $?."
	abinfo "Installing binaries ..."
	make install \
		DESTDIR="$PKGDIR" $ABMK $MAKE_AFTER \
		|| abdie "Failed to install binaries: $?."
	fi

	if bool "$ABSHADOW"; then
		cd "$SRCDIR" \
			|| abdie "Failed to return to source directory: $?."
	fi
}

ABBUILDS+=' cmake'
