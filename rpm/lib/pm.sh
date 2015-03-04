abreqexe rpm

pm_getver(){
	rpm -qi $1 | grep 'Version' | awk '{ print $3 }' 2>/dev/null
}

if ! rpm -qa $BUILDDEP $PKGDEP; then
    zypper ref -f
    zypper install $BUILDDEP $PKGDEP
fi

# pm_whoprov
# Just for testing of output.
