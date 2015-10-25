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
alternative(){ while [ "$1" ]; do addalt "$1" "$(basename "$1")" "$2" "$3"; shift 3 || break; done; }

if [ -e autobuild/alternatives ]
then
	echo "# alternatives" >> abscripts/postinst
	echo "# alternatives" >> abscripts/prerm
	. autobuild/alternatives
fi

unset alternative addalt
