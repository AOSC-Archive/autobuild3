arch_loadfile prepare
build_${ABTYPE}_build || abicu "Build failed: $?."

[ -d "$PKGDIR" ] || abicu "50-build: Suspecting build failure due to missing PKGDIR."
[ -d "`arch_findfile overrides`" ] && cp -rla "`arch_findfile overrides`"/* "$PKGDIR/"
arch_loadfile beyond
