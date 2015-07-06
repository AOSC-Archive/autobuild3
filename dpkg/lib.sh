abreqexe dpkg dpkg-deb dpkg-query apt-get

pm_whoprov(){
	dpkg-query --admindir=$PM_ROOT/var/lib/dpkg -S $1 2> /dev/null | cut -d: -f 1
	# This just give a nice list of formatted dependencies.
}

pm_getver(){
	dpkg-query --admindir=$PM_ROOT/var/lib/dpkg -f '${Version}' -W $1 2>/dev/null
}

pm_exists(){
	dpkg $PM_ROOTPARAM -l "$@" &>/dev/null
}

pm_repoupdate(){
	apt-get update
}

pm_repoinstall(){
	apt-get install "$@" --yes
}
pm_chroot(){
	export PM_ROOT=$1
	export PM_ROOTPARAM="--root=$1 --admindir=$1/var/lib/dpkg --force-architecture" 
}
