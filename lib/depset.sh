abreqexe grep

# Checks if the current string contains the dep argv[1]
# old eregex: grep -E "(^| )[\=><]?$1( |\$)" <<< "$PKGDEP"
depset_contains(){
	grep -E "(^| )[\=><]?$1( |\$)" <<< "$PKGDEP"
}

depset_add(){
	[[ "$1" && "$1" != "$PKGNAME" ]] || return 2
	depset_contains $1 && return 0
	PKGDEP+=" $1"
	abinfo "Added dependency $1$([ "$2" ] && echo from $2)."
}
