abtryexe python2 || ablibret

build_waf_probe(){
	[ -f waf ]
}

build_cmake_build(){
	local _ret
	BUILD_START
        python2 waf ${WAF_DEF} ${WAF_AFTER}
	BUILD_READY
	python2 waf build ${ABMK} ${MAKE_AFTER}
	BUILD_FINAL
	python2 waf install --destdir=${PKGDIR} || _ret=$PIPESTATUS
	return $_ret
}
ABBUILDS+=' waf'
