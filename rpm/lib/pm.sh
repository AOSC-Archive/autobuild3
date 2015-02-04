abreqexe rpm

pm_getver(){
	rpm -qi $1 | grep 'Version' | awk '{ print $3 }' 2>/dev/null
}

# pm_whoprov
# Just for testing of output.
