abreqexe rpm

pm_getver(){
	for dep in $PKGDEP; do
	    rpm -qi $dep | grep 'Version' | awk '{ print $3 }' 2>/dev/null
	done
}

# pm_whoprov
# Just for testing of output.
