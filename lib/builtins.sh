#!/bin/bash
##lib/builtins.sh: Built-in functions.
##@copyright GPL-2.0+

PATCHFLAGS="-Np1 -t"
RPATCHFLAGS="-Rp1 -t"

ab_apply_patches() {
	for i in "$@"; do
		abinfo "Applying patch $i ..."
		patch $PATCHFLAGS -i "$i" || abdie "Applying patch $i failed"
	done
}

ab_reverse_patches() {
	for i in "$@"; do
		abinfo "Reverting patch $i ..."
		patch $RPATCHFLAGS -i "$i" || abdie "Reverting patch $i failed"
	done
}

ab_match_arch() {
	if [[ ${ABHOST%%\/*} = $1 ]]; then
		abinfo "Architecture '$ABHOST' matches '$1': taking true branch."
		return 0
	elif [[ ${ABHOST_GROUP%%\/*} = $1 ]]; then
		abinfo "Architecture group '$ABHOST_GROUP' matches '$1': taking true branch."
		return 0
	else
		abinfo "Architecture '$ABHOST' mismatches '$1': taking false branch."
		return 1
	fi
}
