#!/bin/bash
##arch.sh: archtecture support code.
##@copyright GPL-2.0+
abrequire pm

# translations from dpkg representation to generic ones.
declare -A ARCH_RPM ARCH_TARGET
ARCH_FINDFILELIST=("autobuild/cross-$ARCH-$CROSS" "autobuild/cross-$CROSS" "autobuild/$ARCH" "autobuild")
ARCH_SUFFIX=('' .sh .bash .bsh)
arch_findfile(){
	local i j _arch_suf
	((_arch_trymore)) && _arch_suf=("${ARCH_SUFFIX[@]}") || _arch_suf=('')
	for i in "${ARCH_FINDFILELIST[@]}"
	do
		for j in "${_arch_suf[@]}"; do
			if [ -e "$i/$1$j" ]
			then
				printf '%s\n' "$i/$1$j"
				return 0
			fi
		done
	done
	printf '%s\n' "autobuild/$1"
	return 127
}

# FIXME: We need to figure out a way of handling multiple return vals!
arch_loadfiles(){
	local _archpath _archpidx j _archokay=0
	local _arch_suf _arch_trymore=${arch_trymore:-1}
	((_arch_trymore)) && _arch_suf=("${ARCH_SUFFIX[@]}") || _arch_suf=('')
	for (( _archpidx = "${#ARCH_FINDFILELIST[@]}"; _archpidx; --_archpidx ))
	do
		_archpath="${ARCH_FINDFILELIST[$_archpidx]}"
		for j in "${_arch_suf[@]}"; do
			if [ -e "$_archpath/$1$j" ]; then
				. "$_archpath/$1$j"
				_archokay=1
				break
			fi
		done
	done
	(( _archokay )) || return 127
}

# Making assignment in local line will cause $? capturing to fail.
arch_loadfile(){
	local _abarchf _arch_trymore=${arch_trymore:-1};
	_abarchf="$(arch_findfile "$1")" || return $?;
	shift;
	. "$_abarchf" "$@";
}

arch_initcross(){
	if [ -z "$CROSS" ]; then
		unset "${!BUILD@}" "${!HOST@}"
		return 0
	fi
	[ "$HOSTSYSROOT" ] || HOSTSYSROOT=/var/ab/cross-root/$CROSS
	"$HOSTSYSROOT"/bin/sh -c "exit 0" &>/dev/null; HOSTEXE=((! $?))
	pm_chroot "$HOSTSYSROOT"
	export PATH="$(dirname "$HOSTTOOLPREFIX"):$PATH"
}

arch_lib(){ echo "$(arch_crossroot "$@")/usr/lib"; }
arch_crossroot() { echo "/var/ab/cross-root/${1:-$CROSS}"; }
