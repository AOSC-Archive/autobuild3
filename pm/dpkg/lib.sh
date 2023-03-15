#!/bin/bash
##dpkg/lib.sh: What dpkg should provide to the abstraction as a package manager
##@copyright GPL-2.0+
abreqexe dpkg dpkg-deb dpkg-query oma apt-get

# $1 is a list of files. Do not quote.
pm_whoprov(){
	dpkg-query --admindir="$PM_ROOT/var/lib/dpkg" -S $1 2> /dev/null | cut -d: -f 1
	# This just give a nice list of formatted dependencies.
}

pm_getver(){
	dpkg-query --admindir="$PM_ROOT/var/lib/dpkg" -f '${Version}' -W "$1" 2>/dev/null
}

pm_exists(){
	for p in "$@"; do
		dpkg $PM_ROOTPARAM -l "$p" | grep ^ii >/dev/null 2>&1 || return 1
	done
}

pm_repoupdate(){
	if command -v oma > /dev/null; then
		abinfo "Omakase (oma) detected, using oma ..."
		oma refresh
	elif command -v apt-get > /dev/null; then
		abwarn "Omakase (oma) not found, using apt-get as fallback ..."
		apt-get update
	else
		aberr "No usable dpkg package management frontend!"
	fi
}

pm_repoinstall(){
	if command -v oma > /dev/null; then
		abinfo "Omakase (oma) detected, using oma ..."
		oma install "$@" -y --force-confnew
	elif command -v apt > /dev/null; then
		abwarn "Omakase (oma) not found, using apt-get as fallback ..."
		apt-get install "$@" --yes
	else
		aberr "No usable dpkg package management frontend!"
	fi
}

pm_chroot(){
	export PM_ROOT="$1"
	export PM_ROOTPARAM="--root=$1 --admindir=$1/var/lib/dpkg --force-architecture"
}
