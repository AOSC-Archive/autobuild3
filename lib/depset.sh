#abreqexe grep

depset_chk(){
	printf "\033[36m>>>\033[0m Querying package dependencies...	 \033[0m\033[35m[INFO]\n\033[0m"
	(echo $PKGDEP | grep "^[\=><]$1 " > /dev/null) && return 0
	(echo $PKGDEP | grep " [|\=><]$1\$" > /dev/null) && return 0
	(echo $PKGDEP | grep " [|\=><]$1 " > /dev/null) && return 0
	(echo $PKGDEP | grep "^$1 " > /dev/null) && return 0
	(echo $PKGDEP | grep " $1\$" > /dev/null) && return 0
	(echo $PKGDEP | grep "|$1|" > /dev/null) && return 0
	(echo $PKGDEP | grep "|$1 " > /dev/null) && return 0
	(echo $PKGDEP | grep "|$1\$" > /dev/null) && return 0
	(echo $PKGDEP | grep " $1|" > /dev/null) && return 0
	return 1
	# printf "\033[32m[OK]\n\033[0m"
}

depset_add(){
	depset_chk $1 && return 0
	export PKGDEP="$PKGDEP $1"
	echo "Added dependency $1"
	# printf "\033[32m[OK]\n\033[0m"
}

