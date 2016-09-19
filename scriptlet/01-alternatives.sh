#!/bin/bash
##alternatives: that update-alternatives stuff
##@copyright CC0
# a more precise one
# addalt link name path prio
addalt(){
	echo "update-alternatives --install $(argprint "$@")" >> abscripts/postinst
	echo "update-alternatives --remove $(argprint "$2" "$3")" >> abscripts/prerm
}

# alternative path link prio [path2 link2 prio2 ..]
alternative(){ while (($#)); do addalt "$1" "$(basename "$1")-$PKGNAME" "$2" "$3"; shift 3 || break; done; }

if [ -e autobuild/alternatives ]
then
	echo "#>start 01-alternatives" >> abscripts/postinst
	echo "#>start 01-alternatives" >> abscripts/prerm
	. autobuild/alternatives
	echo "#>end 01-alternatives" >> abscripts/postinst
	echo "#>end 01-alternatives" >> abscripts/prerm
fi

unset alternative addalt
