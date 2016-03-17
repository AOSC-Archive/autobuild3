#!/bin/bash
##12-waf.sh: Builds WAF stuffs
##@copyright GPL-2.0+
abtryexe python2 || ablibret

build_waf_probe(){
	[ -f waf ]
}

build_waf_build(){
	local _ret
	BUILD_START
	python2 waf configure "${WAF_DEF[@]}" "${WAF_AFTER[@]}"
	BUILD_READY
	python2 waf build "${ABMK[@]}" "${MAKE_AFTER[@]}" ${MAKEFLAGS}
	BUILD_FINAL
	python2 waf install "--destdir=${PKGDIR}" || _ret=$PIPESTATUS
	return $_ret
}
ABBUILDS+=('waf')
