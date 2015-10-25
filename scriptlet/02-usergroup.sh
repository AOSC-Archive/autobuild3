#!/bin/bash
##usergroup: functions with a creepy syntax to define package's user and groups
##@copyright GPL-2.0+
# user LOGIN UID GID HOME COMMENT SHELL [GROUPS..]
user(){
	echo "grep -q '^$1:' /etc/passwd || useradd $(argprint -u "$2" -g "$3" -d "$4"  -c "$5" -s "$6" "$1" -m)" >> abscripts/preinst
	local N=$1
	shift 6
	for i; do echo "usermod -a -G $(argprint "$i" "$N")" >> abscripts/preinst; done
}

# group NAME GID
group(){
	echo "grep -q '^$1:' /etc/group || groupadd $(argprint -g "$2" "$1")" >> abscripts/preinst
}
if [ -e autobuild/usergroup ]
then
	echo '# usergroup' >> abscripts/preinst
	. autobuild/usergroup
fi

unset user group
