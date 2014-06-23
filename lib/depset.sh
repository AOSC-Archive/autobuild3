#abreqexe grep

depset_chk(){
	(echo $PKGDEP | grep "^[\=><]$1 " > /dev/null) && return 0
	(echo $PKGDEP | grep " [|\=><]$1\$" > /dev/null) && return 0
	(echo $PKGDEP | grep " [|\=><]$1 " > /dev/null) && return 0
	(echo $PKGDEP | grep "^$1 " > /dev/null) && return 0
	(echo $PKGDEP | grep " $1\$" > /dev/null) && return 0
	(echo $PKGDEP | grep "|$1|" > /dev/null) && return 0
	(echo $PKGDEP | grep "|$1 " > /dev/null) && return 0
	(echo $PKGDEP | grep "|$1\$" > /dev/null) && return 0
	(echo $PKGDEP | grep " $1|" > /dev/null) && return 0
	(echo $PKGDEP | grep " $1 " > /dev/null) && return 0
	return 1
}

depset_add(){
	depset_chk $1 && return 0
	export PKGDEP="$PKGDEP $1"
	echo "Added dependency $1"
}

