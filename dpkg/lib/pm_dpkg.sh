abreqexe dpkg dpkg-deb dpkg-query

pm_whoprov(){
	dpkg-query -S $1 2> /dev/null | awk '{ print $1 }' | rev | cut -b 2- | rev
	# This just give a nice list of formatted dependencies.
	# This file should be renamed as pm_dpkg.sh as we need rpm support also.
}
