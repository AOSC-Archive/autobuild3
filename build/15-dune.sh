#!/bin/bash
##15-dune.sh: Builds OCaml projects using Dune
##@copyright GPL-2.0+
abtryexe dune || ablibret

build_dune_probe(){
	[ -f "$SRCDIR"/dune-project ]
}

build_dune_build(){
	BUILD_START
	if ! ab_match_archgroup ocaml_native; then
		abinfo "OCaml has no native code generation for $ABHOST. Disabling ABSPLITDBG and ABSTRIP ..."
		export ABSPLITDBG=0 ABSTRIP=0
	fi

	BUILD_READY
	abinfo "Building Dune project $PKGNAME ..."
	if [[ -n $DUNE_PACKAGES ]]; then
		abinfo "Setting dune build target packages to: $DUNE_PACKAGES"
		_DUNE_BUILD_PACKAGES="-p ${DUNE_PACKAGES// /,}"
	fi
	dune build \
		$_DUNE_BUILD_PACKAGES \
		$DUNE_BUILD_AFTER \
		|| abdie "Failed to build Dune project $PKGNAME: $?."
	abinfo "Installing Dune project $PKGNAME ..."
	mkdir -pv "$PKGDIR"/"$(ocamlfind printconf destdir)"

	BUILD_FINAL
	if [[ -n $DUNE_PACKAGES ]]; then
		# Install all components one by one
		for _pkg in $DUNE_PACKAGES; do
			abinfo "Installing component $_pkg ..."
			dune install "$_pkg" \
			--prefix "$PKGDIR"/usr \
			--libdir "$PKGDIR"/"$(ocamlfind printconf destdir)" \
			$DUNE_INSTALL_AFTER \
			|| abdie "Failed to install Dune project $PKGNAME component $_pkg: $?."
		done
	else
		dune install \
			--prefix "$PKGDIR"/usr \
			--libdir "$PKGDIR"/"$(ocamlfind printconf destdir)" \
			$DUNE_INSTALL_AFTER \
			|| abdie "Failed to install Dune project $PKGNAME: $?."
	fi
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
