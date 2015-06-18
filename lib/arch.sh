abrequire pm

# translations from dpkg representation to generic ones.
declare -A ARCH_RPM ARCH_TARGET
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
	return 127
}

# fuck you, how are you going to let the return values work properly?
arch_loadfiles(){
	local i
	for i in $ARCH_FINDFILELIST
	do
		if [ -e $i/"$1" ]; then
			. $i/"$1"
		else
			returns 127
		fi
	done
}
arch_loaddef(){ arch_loadfiles defines; }
# Making assignment in local line will cause $? capturing to fail.
arch_loadfile(){ local _abarchf; _abarchf="$(arch_findfile "$1")" || return $?; shift; . $_abarchf "$@"; }

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

arch_lib(){ echo $(arch_crossroot "$@")/usr/lib; }
arch_crossroot() { echo /var/ab/cross-root/${1:-$CROSS}/usr/lib; }
