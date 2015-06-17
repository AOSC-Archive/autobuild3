arch_loadfile prepare
build_${ABTYPE}_build || abicu "Build failed: $?."

_ret=$?

[ -d `arch_findfile overrides` ] && cp -r `arch_findfile overrides`/* $PKGDIR/
arch_loadfile beyond

returns $_ret
