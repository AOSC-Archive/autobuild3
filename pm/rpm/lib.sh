#!/bin/bash
##rpm/lib.sh: What rpm should provide to the abstraction as a package manager
##@copyright GPL-2.0+
abreqexe rpm zypper
ABSTRICT=0 abrequire arch || abwarn RPM archname translation disabled. Expect errors with names.

pm_chroot(){
	PM_ROOT=$1
	PM_ROOTPARAM=("--root=$1")
}

pm_getver(){
	rpm "${PM_ROOTPARAM[@]}" -q "$1" --qf '%{EPOCH}:%{VERSION}-${RELEASE}' 2>/dev/null
}

pm_exists(){
	rpm "${PM_ROOTPARAM[@]}" -q "$@" &>/dev/null
}

pm_repoupdate(){ zypper ref -f; }

pm_repoinstall(){
	zypper -n install "$@"
}

pm_whoprov(){ rpm "${PM_ROOTPARAM[@]}" -q --whatprovides "$1" --qf '%{NAME}'; }
# Just for testing of output.
