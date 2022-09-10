#!/bin/bash
##lib/builtins.sh: Built-in functions.
##@copyright GPL-2.0+

PATCHFLAGS="-Np1 -t"
RPATCHFLAGS="-Rp1 -t"

ab_apply_patches() {
	for i in "$@"; do
		if [[ -e $i ]];then
			abinfo "Applying patch $i ..."
			patch $PATCHFLAGS -i "$i" || abdie "Applying patch $i failed"
		fi
	done
}

ab_reverse_patches() {
	for i in "$@"; do
		if [[ -e $i ]];then
			abinfo "Reverting patch $i ..."
			patch $RPATCHFLAGS -i "$i" || abdie "Reverting patch $i failed"
		fi
	done
}

## ab_match_arch "match_pattern"
## Check whether current ABHOST matches the match_pattern
## Example: ab_match_arch "+(amd64|arm64)"
## See also: https://www.gnu.org/software/bash/manual/html_node/Pattern-Matching.html
ab_match_arch() {
	# Check whether the calling of function is illegal
	if [[ ! $1 ]]; then
		aberr "ab_match_arch() was called but no pattern was specified."
		abinfo "Usage: ab_match_arch \"match_pattern\""
		abdie "Misuse of ab_match_arch()! Refuse to proceed."
	fi
	if [[ ${ABHOST%%\/*} = $1 ]]; then
		abinfo "Architecture $ABHOST matches $1: taking true branch."
		return 0
	else
		abinfo "Architecture $ABHOST mismatches $1: taking false branch."
		return 1
	fi
}

## ab_match_archgroup "group_match_pattern"
## Check whether current ABHOST is in a specific arch group, using bash pattern matching.
## See /sets/arch_groups/ for group infomation
## Example: ab_match_archgroup "+(mainline|ocaml_native)"
ab_match_archgroup() {
	# Check whether the calling of function is illegal
	if [[ ! $1 ]]; then
		aberr "ab_match_archgroup() was called but no group was specified."
		abinfo "Usage: ab_match_archgroup \"group_match_pattern\""
		abdie "Misuse of ab_match_archgroup()! Refuse to proceed."
	fi
	# A little more robustness here
	if [[ ! $ABHOST_GROUP ]]; then
		abwarn "Current ABHOST $ABHOST is not belong to any arch group."
		abwarn "Taking false branch."
		return 1
	fi
	for _grp in $ABHOST_GROUP; do
		if [[ ${_grp%%\/*} = $1 ]]; then
			abinfo "Member '${_grp}' in Architecture group '${ABHOST_GROUP//$'\n'/,}' matches $1: taking true branch."
			return 0
		else 
			abdbg "Member '${_grp}' in Architecture group '${ABHOST_GROUP//$'\n'/,}' mismatches $1"
		fi
	done
	abinfo "All architecture group members '${ABHOST_GROUP//$'\n'/,}' mismatches $1: taking false branch."
	return 1
}
