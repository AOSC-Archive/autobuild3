ARCH_FILEFINDLIST="autobuild/cross-$ARCH-$CROSS autobuild/cross-$CROSS autobuild/$ARCH autobuild"
arch_filefind(){
	for i in $ARCH_FILEFINDLIST
	do
		if [ -e $i/$1 ]
		then
			echo $i/$1
			return 0
		fi
	done
	echo autobuild/$1
	return 1
}
arch_loaddef(){
	local rev
	for i in $ARCH_FILEFINDLIST
	do
		rev="$i $rev"
	done
	for i in $rev
	do
		[ -e $i/defines ] && source $i/defines
	done
}
arch_initcross(){
	[ "x$CROSS" = "x" ] && return 0
	. $AB/arch/build/$ARCH
	. $AB/arch/host/$CROSS
	[ "x$HOSTSYSROOT" = "x" ] && HOSTSYSROOT=/vra/ab/cross-root/$CROSS
	$HOSTSYSROOT/bin/bash -c "exit 0" >/dev/null 1>&2 && HOSTEXE=1 || HOSTEXE=0
}
