#!/bin/bash
##29-plainmake.sh: Build those pkgs that comes with a Makefile
##@copyright GPL-2.0+
build_plainmake_probe(){
	if ! BUILD_PLAINMAKE_CONFIG="$(arch_findfile make_dotconfig)"; then
		unset BUILD_PLAINMAKE_CONFIG
		[ -e "$SRCDIR"/Makefile -o -e "$SRCDIR"/makefile ]
	fi
}

build_plainmake_build(){
	BUILD_START
	if [ -e "$BUILD_PLAINMAKE_DOTCONFIG" ]; then
		abinfo 'Copying .config file as defined in $BUILD_PLAINMAKE_DOTCONFIG ...'
		cp -v "$BUILD_PLAINMAKE_DOTCONFIG" "$SRCDIR/.config" \
			|| abdie "Failed to copy .config file: $?."
	fi
	BUILD_READY
	abinfo "Building binaries using Makefile ..."
	make V=1 VERBOSE=1 $ABMK $MAKE_AFTER \
		|| abdie "Failed to build binaries: $?."
	BUILD_FINAL
	abinfo "Installing binaries ..."
	make install \
		V=1 VERBOSE=1 \
		BUILDROOT="$PKGDIR" DESTDIR="$PKGDIR" \
		$MAKE_INSTALL_DEF $MAKE_AFTER \
		|| abdie "Failed to install binaries: $?."
}

ABBUILDS+=' plainmake'
