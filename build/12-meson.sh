#!/bin/bash
# 12-meson.sh: Builds Meson sources
##@copyright GPL-2.0+
abtryexe meson

build_meson_probe(){
	[ -e meson.build ]
}

build_meson_build() {
	mkdir "$SRCDIR"/build
	abinfo "Running Meson ..."
	meson ${MESON_DEF} ${MESON_AFTER} "$SRCDIR" "$SRCDIR"/build || return "${PIPESTATUS[0]}"
    cd "$SRCDIR"/build || return 1
	abinfo "Building binaries ..."
	ninja || return "${PIPESTATUS[0]}"
	abinfo "Installing binaries ..."
	DESTDIR="$PKGDIR" ninja install || return "${PIPESTATUS[0]}"
	cd "$SRCDIR" || return 1
}

ABBUILDS+=' meson'
