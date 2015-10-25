#!/bin/bash
##depset.sh: The dependency set (unique unordered array)
##@copyright GPL-2.0+
# Checks if the current string contains the dep argv[1]
# Pollutes: BASH_REMATCH, consider rewrite in extglob.
depset_contains(){
	[[ "$PKGDEP" =~ (^| )$1(_|[<>=]=[^ ]*)?( |$) ]]
}
depset_add(){
	[[ "$1" && "$1" != "$PKGNAME" ]] || return 2
	depset_contains $1 && return 0
	PKGDEP+=" $1"
	abinfo "Added dependency $1$([ "$2" ] && echo from $2)."
}
