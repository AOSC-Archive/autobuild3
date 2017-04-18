#!/bin/bash
# 12-meson.sh: Builds Meson sources
##@copyright GPL-2.0+
abtryexe meson

build_autotools_probe(){
	[ -e meson.build ]
}

build_autotools_build() {
	meson ${MESON_DEF} ${MESON_AFTER}
	ninja
	DESTDIR="$PKGDIR" ninja install
}

ABBUILDS+=' meson'
