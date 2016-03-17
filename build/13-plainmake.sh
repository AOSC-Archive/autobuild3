#!/bin/bash
##13-plainmake.sh: Build those pkgs that comes with a Makefile
##@copyright GPL-2.0+
build_plainmake_probe(){
	local mk
	if ! BUILD_PLAINMAKE_CONFIG="$(arch_findfile make_dotconfig)"; then
		unset BUILD_PLAINMAKE_CONFIG
		# GNUMakefile, blah, blah .. TODO
		for mk in Makefile makefile; do
			[[ -e $mk ]] && break
		done
		false
	fi
}

build_plainmake_build(){
	BUILD_START
	if [ -e "$BUILD_PLAINMAKE_DOTCONFIG" ]; then
	       cp "$BUILD_PLAINMAKE_DOTCONFIG" "$SRCDIR/.config"
	fi | ablog
	BUILD_READY
	make "${ABMK[@]}" "${MAKE_AFTER[@]}" | ablog
	BUILD_FINAL
	make install "BUILDROOT=$PKGDIR" "DESTDIR=$PKGDIR" "${MAKE_INSTALL_DEF[@]}" "${MAKE_AFTER[@]}"	| ablog
}

ABBUILDS+=('plainmake')
