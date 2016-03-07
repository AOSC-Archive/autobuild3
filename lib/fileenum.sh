#!/bin/bash
##fileenum.sh: A files.foreach routine that sucks.
##@copyright GPL-2.0+
abreqexe find

# Not sure how to make this suck less.
fileenum_fromstdin() {
	local a
	while IFS='' read -r a; do
		[ "$a" = ":EXIT" ] && return
		[ "$a" ] || continue
		eval "${1//\{\}/$(argprint $a)}"
	done
}

# Well I can make this one make some sense.
fileenum() {
	local IFS=$'\n' a
	while IFS='' read -d -r a
	do
		eval "${1//\{\}/$(argprint $a)}"
	done < <(find . -print0)
	# find . | fileenum_fromstdin "$@"
}
