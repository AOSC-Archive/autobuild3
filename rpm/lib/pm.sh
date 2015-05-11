abreqexe rpm

pm_chroot(){
	export PM_ROOT=$1
	export PM_ROOTPARAM="--root=$1"
}

pm_getver(){
	rpm $PM_ROOTPARAM -qi $1 | grep 'Version' | awk '{ print $3 }' 2>/dev/null
}

pm_checkdep(){
	rpm $PM_ROOTPARAM -q $* 2>/dev/null 1>&2
}

pm_repoinstall(){
	if ! rpm $PM_ROOTPARAM -qa $BUILDDEP $PKGDEP; then
		zypper ref -f
		zypper -n install $BUILDDEP $PKGDEP
	fi
}

# pm_whoprov
# Just for testing of output.
