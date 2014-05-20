abreqexe dpkg dpkg-deb dpkg-query

pm_whoprov(){
	printf "\033[36m>>>\033[0m Finding which package dependencies belongs...	"
	dpkg-query -S $1 2> /dev/null | awk '{ print $1 }' | rev | cut -b 2- | rev
	printf "\033[32m[OK]\n\033[0m"
	# This just give a nice list of formatted dependencies.
}

# pm_whoprov
# Just for testing of output.