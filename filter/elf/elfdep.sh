abrequire elf depset pm

filter_elf_elfdep(){
	bool $ABELFDEP || return 0
	echo "Looking for Dependencies on $1 ..."
	local OLD_LC_ALL=$LC_ALL _IFS="$IFS" IFS=$'\n' i P _libs
	export LC_ALL=C
	local lddstr="$(ldd "$1")"
	if grep -q "not a dynamic executable" <<< "$lddstr"; then
		ab_dbg "Non-dynamic executable $1 sent into elfdep."
		return 1
	fi
	if grep -q "not found" <<< "$lddstr"; then
		abwarn "↑Missing library found in $1.↑"
		return 1
	fi
	export LC_ALL=$OLD_LC_ALL
	_libs=($(awk '{print $3}' <<< "$lddstr" | grep -v "^("))
	IFS="$_IFS"
	for i in "${_libs[@]}"
	do
		i="${i//\/lib64\//lib/}"
		i="${i//..\/lib}"
		P="$(pm_whoprov $i)"
		abdbg "pm_whoprov returned ${P-null} for $i"
		if [[ "$P" && "$P" != "$PKGNAME" ]]; then depset_add "$P"; fi
	done
}

export ABELFFILTERS+=" dep"
