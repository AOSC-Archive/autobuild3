#!/bin/bash
##13-plainmake.sh: Build those pkgs that comes with a Makefile
##@copyright GPL-2.0+
build_plainmake_probe(){
	if ! BUILD_PLAINMAKE_CONFIG="$(arch_findfile make_dotconfig)"; then
		unset BUILD_PLAINMAKE_CONFIG
		[ -e Makefile -o -e makefile ]
	fi
}

build_plainmake_build(){
	BUILD_START
	if [ -e "$BUILD_PLAINMAKE_DOTCONFIG" ]; then
		abinfo 'Copying .config file as defined in $BUILD_PLAINMAKE_DOTCONFIG ...'
		cp "$BUILD_PLAINMAKE_DOTCONFIG" "$SRCDIR/.config"
	fi | ablog
	BUILD_READY
	abinfo "Building binaries using Makefile ..."
	make V=1 VERBOSE=1 $ABMK $MAKE_AFTER | ablog
	BUILD_FINAL
	abinfo "Installing binaries ..."
	make V=1 VERBOSE=1 install BUILDROOT=$PKGDIR DESTDIR=$PKGDIR $MAKE_INSTALL_DEF $MAKE_AFTER | ablog
}

ABBUILDS+=' plainmake'
