#!/bin/bash
##12-waf.sh: Builds WAF stuff
##@copyright GPL-2.0+
abtryexe python2 || ablibret

build_waf_probe(){
	[ -f "$SRCDIR"/waf ]
}

build_waf_build(){
	BUILD_START
	abinfo "Running Waf script(s) ..."
	python2 waf configure ${WAF_DEF} ${WAF_AFTER} \
		|| abdie "Failed to run Waf script(s): $?."
	BUILD_READY
	abinfo "Building binaries ..."
	python2 waf build ${ABMK} ${MAKE_AFTER} ${MAKEFLAGS} \
		|| abdie "Failed to build binaries: $?."
	BUILD_FINAL
	abinfo "Installing binaries ..."
	python2 waf install --destdir=${PKGDIR} \
		|| abdie "Failed to install binaries: $?."
}

ABBUILDS+=' waf'
