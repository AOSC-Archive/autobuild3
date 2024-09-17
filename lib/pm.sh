#!/bin/bash
##pm.sh: Shared PM Abstraction Functions
##@copyright GPL-2.0+
# The great common package manager library for everyone!
# From the wisdom of the ancient, ab2.
# Magic book: ab2:PAKMGR.md
_ab_pm='' # package manager spec variables
# genver <pkgspec> -> pkgname[<ver_s><op>verstr<ver_e>]
_ab_pm+="OP_{EQ,LE,GE,LT,GT} VER_{S,E} "
pm_genver(){
	local store IFS ver name       # IFS is also used for holding OP.
	: "${OP_EQ== } ${OP_LE=<= } ${OP_GE=>= } ${OP_LT=<< } ${OP_GT=>> } ${VER_S= (} ${VER_E=)}"
	if ((VER_NONE_ALL)); then			# name-only
		name="${1/%_}"
		echo "${name/[<>=]=*}"; return
	elif [[ "$1" =~ [\<\>=]=|\<\<|\>\> ]]; then		# nameOP[ver] -> name OP_ ver
		IFS="$BASH_REMATCH"	# split string using each char in OP
		read -ra store <<< "$1" 
		name=${store[0]} ver=${store[2]}	# constexpr store[${#IFS}]
		IFS=${IFS/==/$OP_EQ}	# translate to package manager notation
		IFS=${IFS/<=/$OP_LE}
		IFS=${IFS/>=/$OP_GE}
		IFS=${IFS/<</$OP_LT}
		IFS=${IFS/>>/$OP_GT}
	elif ((VER_NONE)) || [[ "$1" =~ _$ ]]; then	# name{,_} -> name (e.g. conflicts, ..)
		echo -n "${1%_}"; return;
	else
		name=$1 IFS="$OP_GE"			# name -> name OP_GE getver
	fi
	echo -n "$name$VER_S$IFS${ver=$(pm_getver "$1")}$VER_E"
}
# depcom: Turns "$@" into a comma seperated list of deps.
_ab_pm+="PM_{ALT,DELIM,COMMA} VER_NONE "
pm_depcom(){
	: "${PM_ALT=1} ${PM_DELIM= | } ${PM_COMMA=, }"
	local IFS='|' dep pkg i cnt=0	# cnt_depcom: dep comma pos
	for i; do
		read -ra dep <<< "$i"
		ABCOMMA="$PM_COMMA" abmkcomma
		pm_deparse
	done
}
# deparse: turns dep[] into a member of the list.
pm_deparse(){
	local cnt=0			# cnt_deparse: dep delim pos
	if (( !PM_ALT && ${#dep[@]}>1 )); then
		abwarn "$ABPM doesn't support dependency alternative listing.\n\t" \
			"Using first dependency: $dep."
		pm_genver "${dep[0]}"; return;
	fi
	for pkg in "${dep[@]}"; do
		ABCOMMA="$PM_DELIM" abmkcomma
		pm_genver "$pkg"
	done
}
# flattens "$@" to a simple list of package names, just like an otokonoko's..
pm_deflat(){ ABPM=dummy VER_NONE_ALL=1 VER_NONE=1 PM_ALT=0 PM_COMMA=' ' PM_DELIM=' ' pm_depcom "$@"; }
# dumpver: dumps a dpkg-ab-lish verstring.
pm_dumpver(){ ((PKGEPOCH)) && echo -n $PKGEPOCH:; echo -n $PKGVER; ((PKGREL)) && echo -n -$PKGREL; }

declare -gi PKGEPOCH

. "$AB"/pm/"$ABMPM"/lib.sh
abtrycmd pm_{whoprov,getver,exists,repoupdate,repoinstall,chroot,getver,exists}
