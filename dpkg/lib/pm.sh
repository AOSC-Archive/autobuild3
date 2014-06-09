abreqexe dpkg dpkg-deb dpkg-query

pm_whoprov(){
	dpkg-query -S $1 2> /dev/null | awk '{ print $1 }' | rev | cut -b 2- | rev
	# This just give a nice list of formatted dependencies.
}

pm_getver(){
	dpkg-query -f '${Version}' -W $1 2>/dev/null
}

# pm_whoprov
# Just for testing of output.
