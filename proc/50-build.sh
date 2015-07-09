arch_loadfile prepare

for build_func in build_{start,ready,final}; do
	abcmdstub "$i"
	alias "${i^^}=_ret=\$PIPESTATUS
	if ((_ret)); then
		bool ABSHADOW && cd ..
		return \$_ret
	fi
	echo $i | ablog
	$i || abwarn '$i: \$?'"
done

build_${ABTYPE}_build || abicu "Build failed: $?."

[ -d "$PKGDIR" ] || abicu "50-build: Suspecting build failure due to missing PKGDIR."
[ -d "`arch_findfile overrides`" ] && cp -rla "`arch_findfile overrides`"/* "$PKGDIR/"
arch_loadfile beyond

unalias BUILD_{START,READY,FINAL}
