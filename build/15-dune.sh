#!/bin/bash
##15-dune.sh: Builds OCaml projects using Dune
##@copyright GPL-2.0+
abtryexe dune || ablibret

build_dune_probe(){
	[ -f "$SRCDIR"/dune-project ]
}

build_dune_build(){
	BUILD_START
	abinfo "Building Dune project $PKGNAME ..."
	dune build \
		|| abdie "Failed to build Dune project $PKGNAME: $?."
	abinfo "Installing Dune project $PKGNAME ..."
	mkdir -pv "$PKGDIR"/"$(ocamlfind printconf destdir)"
	dune install \
		--prefix "$PKGDIR"/usr \
		--libdir "$PKGDIR"/"$(ocamlfind printconf destdir)" \
		|| abdie "Failed to install Dune project $PKGNAME: $?."
	abinfo "Correcting directories ..."
	if [ -d "$PKGDIR"/usr/doc ]; then
		mkdir -pv "$PKGDIR"/usr/share
		mv -v "$PKGDIR"/usr/{,share/}doc
	fi
	if [ -d "$PKGDIR"/usr/man ]; then
		mkdir -pv "$PKGDIR"/usr/share
		mv -v "$PKGDIR"/usr/{,share/}man
	fi
}

ABBUILDS+=' dune'
