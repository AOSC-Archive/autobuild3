#!/bin/bash
##filter/elf/lib.sh: Adds dependencies according to ldd output
##@copyright GPL-2.0+
abrequire elf depset pm

filter_elf_dep(){
	bool $ABELFDEP || return 0
	echo "Looking for Dependencies on $1 ..."
	local _IFS="$IFS" IFS=$'\n'
	local lddstr="$(ldd "$1")" || return 1
	if grep "not found" <<< "$lddstr"; then
		abicu "Missing library found in $1."
		return 1
	fi
	lddstr="${lddstr//${p//(*([^)]))}}"
	filter_elf_dep_libs+=($(IFS=' '; while read -r _1 _2 _3 __; do echo "$_3"; done <<< "$lddstr"))
	IFS="$_IFS"
}

filter_elf_dep_post(){
	local i P
	# Need smarter rules.
	filter_elf_dep_libs=("${filter_elf_dep_libs[@]//\/lib64\//lib/}")
	filter_elf_dep_libs=("${filter_elf_dep_libs[@]//..\/lib}")
	# We should dedup filter_elf_dep_libs first. Saves time dealing with pm.
	# As the saying goes, I am always lazy.. So let's do it with the key of a dict.
	declare -A _exists
	for i in "${filter_elf_dep_libs[@]}"; do _exists["$i"]=1; done
	filter_elf_dep_libs=("${!_exists[@]}") # more magically it's sorted.
	# It's also possible to do it here, like ((_exists[i])) && continue.
	for i in "${filter_elf_dep_libs[@]}"
	do
		P="$(pm_whoprov $i)"
		abdbg "pm_whoprov returned ${P-null} for $i: $?"
		# Now I can make it a one-liner if I want to hahaha
		depset_add "$P"
	done
	return 0 # depset_add ret EAOSC_WRONGFMT(2) on ! [[ "$P" && "$P" != "$PKGNAME" ]], ignore it.
}

ABELFFILTERS+=("dep")
