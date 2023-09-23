#!/bin/bash
##arch.sh: archtecture support code.
##@copyright GPL-2.0+
abrequire pm

# compat 1.x.
((AB_COMPAT > 1)) || declare -gn ARCH=ABBUILD CROSS=ABHOST ARCH_GROUP=ABHOST_GROUP

# translations from dpkg representation to generic ones.
# Sorry, top level! Scoping made me do this.
declare -gA ARCH_TARGET
# Construct ARCH_FINDFILELIST
## FIXME: Find a way to handle ambiguous abhost groups
## e.g., autobuild/{mainline,ocaml-native}
ARCH_FINDFILELIST=("autobuild/$ABHOST"{-cross{-"$ABBUILD",},} \
	"autobuild/`eval echo ${ABHOST_GROUP//$'\n'/,}`" \
	autobuild)

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

# Initialise variables with architectural suffixes.
arch_loadvar(){
	local name_archvar=${1}__${ABHOST^^}
	local name_commonvar=${1}
	if abisdefined $name_archvar; then
		abdbg "Setting ${name_commonvar} from arch-specific variable $name_archvar"
		abcopyvar $name_archvar $name_commonvar
	else
		# Need to try to match group one by one
		for _GROUP in ${ABHOST_GROUP}; do
			local name_groupvar=${1}__${_GROUP^^}
			if abisdefined $name_groupvar; then
				if [[ $_assignedGroup ]]; then
					aberr "Refusing to assign $name_commonvar to group-specific variable $name_groupvar"
					aberr "... because it is already assigned to ${1}__${_assignedGroup^^}"
					abinfo "Current ABHOST ${ABHOST} belongs to the following groups:"
					abinfo "${ABHOST_GROUP//$'\n'/, }"
					abinfo "Add a more specific $name_archvar instead to suppress the conflict."
					abdie "Ambiguous architecture group variable detected! Refuse to proceed."
					break
				fi
				abdbg "Setting $name_commonvar from group-specific variable $name_groupvar"
				abcopyvar $name_groupvar $name_commonvar
				_assignedGroup=${_GROUP}
			fi
		done
		# Fixes #134
		# Need to unset it to prevent pollution
		unset _assignedGroup
	fi
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
				for var in `cat $AB/exportvars/*`; do
					arch_loadvar $var
				done
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

arch_loadfile_strict(){
	local _abarchf _arch_trymore=${arch_trymore:-1};
	_abarchf="$(arch_findfile "$1")" || return $?;
	shift;
	load_strict "${_abarchf}" "$@";
}

arch_initcross(){
	if [[ $ABBUILD == $ABHOST || $ABHOST == noarch ]]; then
		return 0
	fi
	: "${HOSTSYSROOT=/var/ab/cross-root/$ABHOST}"
	: "${HOSTTOOLPREFIX=/opt/abcross/$ABHOST/bin/$HOST}"
	"$HOSTSYSROOT"/bin/sh -c "exit 0" &>/dev/null; ((HOSTEXE = ! $?))
	pm_chroot "$HOSTSYSROOT"
	export PATH="$(dirname "$HOSTTOOLPREFIX"):$PATH"
}

# todo: make these variables I guess?
arch_lib(){ echo "$(arch_crossroot "$@")/usr/lib"; }
arch_crossroot() { echo "/var/ab/cross-root/$ABHOST"; }
