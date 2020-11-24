#!/bin/bash
##15-dune.sh: Builds OCaml projects using Dune
##@copyright GPL-2.0+
abtryexe dune || ablibret

build_dune_probe(){
	[ -f dune-project ]
}

build_gomod_build(){
	BUILD_START
	abinfo "Building Dune project $PKGNAME ..."
	dune
	abinfo "Installing Dune project $PKGNAME ..."
	mkdir -pv "$PKGDIR"/$(ocamlfind printconf destdir)
	dune install \
		--prefix "$PKGDIR"/usr \
		--libdir "$PKGDIR"/$(ocamlfind printconf destdir)
}

ABBUILDS+=' dune'
