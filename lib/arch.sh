abrequire pm

ARCH_FINDFILELIST="autobuild/cross-$ARCH-$CROSS autobuild/cross-$CROSS autobuild/$ARCH autobuild"

arch_findfile(){
	local i
	for i in $ARCH_FINDFILELIST
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

# fuck you, how are you going to let the return values work properly?
arch_loaddef(){
	local rev i
	for i in $ARCH_FINDFILELIST
	do
		if [ -e $i/defines ]; then
			. $i/defines
		else
			returns 127
		fi
	done
}

arch_initcross(){
	if [ -z "$CROSS" ]; then
		unset ${!BUILD@} ${!HOST@}
		return 0
	fi
	[ "$HOSTSYSROOT" ] || HOSTSYSROOT=/var/ab/cross-root/$CROSS
	$HOSTSYSROOT/bin/sh -c "exit 0" >/dev/null 1>&2 && HOSTEXE=1 || HOSTEXE=0
	pm_chroot $HOSTSYSROOT
	export PATH="$(dirname $HOSTTOOLPREFIX):$PATH"
}
