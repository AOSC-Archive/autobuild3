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

pm_exist(){
	dpkg -l $1 2>/dev/null 1>&2
}

pm_checkdep(){
	for i
	do
		sat=false
		if echo $i | grep \| 2>/dev/null 1>&2
		then
			while echo $i | grep \| 2>/dev/null 1>&2
			do
				pm_exist "`cut -d \| -f 1`" && (sat=true;break)
				i="`cut -d \| -f 2-`"
			done
		fi
		if bool sat
		then
			true
		else
			pm_exist "`cut -d \| -f 1`" || return 1
		fi
	done
}

pm_repoupdate(){
	apt-get update
}

pm_repoinstall(){
	apt-get install $* --yes
}
