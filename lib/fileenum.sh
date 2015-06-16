abreqexe find

fileenum_fromstdin() {
	local a
	while read -r a; do
		[ "$a" = ":EXIT" ] && return
		[ "$a" ] || continue
		eval "${1//{}/$(argprint $a)}"
	done
}

fileenum() {
	local _IFS=$"IFS" IFS=$'\n' a
	for a in $(find .)
	do
		IFS="$_IFS" eval "${1//{}/$(argprint $a)}"
	done
	# find . | fileenum_fromstdin "$@"
}
