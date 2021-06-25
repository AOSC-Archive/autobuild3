#!/bin/bash
# 13-cmakeninja.sh: Builds cmake with Ninja
##@copyright GPL-2.0+
(abtryexe cmake && abtryexe ninja) || ablibret

build_cmakeninja_probe(){
	[ -f "$SRCDIR"/CMakeLists.txt ]
}

build_cmakeninja_build(){
	ABSHADOW=${ABSHADOW_CMAKE-$ABSHADOW}
	if bool "$ABSHADOW"
	then
		abinfo "Creating directory for shadow build ..."
		mkdir -pv "$SRCDIR"/abbuild \
			|| abdie "Failed to create shadow build directory: $?."
		cd "$SRCDIR"/abbuild \
			|| abdie "Failed to enter shadow build directory: $?."
	fi
	BUILD_START

	abinfo "Running CMakeLists.txt to generate Ninja configuration ..."
	cmake "$SRCDIR" $CMAKE_DEF $CMAKE_AFTER -GNinja \
		|| abdie "Failed to run CMakeList.txt: $?."
	BUILD_READY

	if bool "$ABUSECMAKEBUILD"; then
		abinfo "Building binaries ..."
		cmake --build . \
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

ABBUILDS+=' cmakeninja'
