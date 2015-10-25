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
	       cp "$BUILD_PLAINMAKE_DOTCONFIG" "$SRCDIR/.config"
	fi | ablog
	BUILD_READY
	make $ABMK $MAKE_AFTER | ablog
	BUILD_FINAL
	make install BUILDROOT=$PKGDIR DESTDIR=$PKGDIR PREFIX=/usr BINDIR=/usr/bin SBINDIR=/usr/bin LIBDIR=/usr/lib $MAKE_AFTER | ablog
}

ABBUILDS+=' plainmake'
