#!/bin/bash
# 12-meson.sh: Builds Meson sources
##@copyright GPL-2.0+
abtryexe meson

build_meson_probe(){
	[ -e "$SRCDIR"/meson.build ]
}

build_meson_build() {
	mkdir "$SRCDIR"/abbuild \
		|| abdie "Failed to create build directory: $?."
	abinfo "Running Meson ..."
	meson ${MESON_DEF} ${MESON_AFTER} "$SRCDIR" "$SRCDIR"/build \
		|| abdie "Failed to run Meson ..."
	cd "$SRCDIR"/abbuild \
		|| abdie "Failed to enter build directory: $?."
	abinfo "Building binaries ..."
	ninja \
		|| abdie "Failed to run build binaries: $?."
	abinfo "Installing binaries ..."
	DESTDIR="$PKGDIR" ninja install \
		|| abdie "Failed to install binaries: $?."
	cd "$SRCDIR" \
		|| abdie "Failed to return to source directory: $?."
}

ABBUILDS+=' meson'
