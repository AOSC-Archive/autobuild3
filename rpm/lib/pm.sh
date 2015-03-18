abreqexe rpm

pm_getver(){
	rpm -qi $1 | grep 'Version' | awk '{ print $3 }' 2>/dev/null
}

pm_checkdep(){
	rpm -q $* 2>/dev/null 1>&2
}

pm_repoinstall(){
	if ! rpm -qa $BUILDDEP $PKGDEP; then
	    zypper ref -f
	    zypper -n install $BUILDDEP $PKGDEP
	fi
}

# pm_whoprov
# Just for testing of output.
