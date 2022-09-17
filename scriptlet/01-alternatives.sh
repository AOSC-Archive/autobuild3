#!/bin/bash
##alternatives: that update-alternatives stuff
##@copyright CC0
# a more precise one
# addalt link name path prio
addalt(){
	echo "update-alternatives --install $(argprint "$@")" >> abscripts/postinst
	echo 'if [ "$1" != "upgrade" ]; then' >> abscripts/prerm
	echo "	update-alternatives --remove $(argprint "$2" "$3")" >> abscripts/prerm
	echo "fi" >> abscripts/prerm
}

# alternative path link prio [path2 link2 prio2 ..]
alternative(){ while (($#)); do addalt "$1" "$(basename "$1")" "$2" "$3"; shift 3 || break; done; }

_hasAlternative=0

if [ -e "$SRCDIR"/autobuild/alternatives ]; then
	abdbg "Found common alternatives file: ${SRCDIR}/autobuild/alternatives"
	_hasAlternative=1
fi

## ${CROSS:-$ARCH} or $ABHOST is always prior than arch groups
if [ -e "$SRCDIR"/autobuild/${CROSS:-$ARCH}/alternatives ]; then
	abdbg "Found arch-specific alternatives file: ${SRCDIR}/autobuild/${CROSS:-$ARCH}/alternatives"
	_hasAlternative=1
	_archTarget="/${CROSS:-$ARCH}"
else
	for _grp in ${ABHOST_GROUP}; do
		if [ -e "$SRCDIR"/autobuild/${_grp}/alternatives ]; then
			if [ $_assignedGroup ]; then
				aberr "Refusing to treat autobuild/${_grp}/alternatives as the group-specific alternative file"
				aberr "... because there is another file: autobuild/${_assignedGroup}/alternatives"
				abinfo "Current ABHOST ${ABHOST} belongs to the following groups:"
				abinfo "${ABHOST_GROUP//$'\n'/, }"
				abinfo "Create autobuild/${CROSS:-$ARCH}/alternatives instead to suppress the conflict"
				abdie "Ambiguous group-specific alternative file detected! Refuse to proceed."
			fi
			abdbg "Found arch-group-specific alternatives file: ${SRCDIR}/autobuild/${_grp}/alternatives"
			_hasAlternative=1
			_archTarget="/${_grp}"
			_assignedGroup=${_grp}
		fi
	done
fi
if bool "$_hasAlternative"; then
	abinfo "Taking alternatives file: ${SRCDIR}/autobuild${_archTarget}/alternatives"
	echo "#>start 01-alternatives" >> abscripts/postinst
	echo "#>start 01-alternatives" >> abscripts/prerm
	. "$SRCDIR"/autobuild"$_archTarget"/alternatives
	echo "#>end 01-alternatives" >> abscripts/postinst
	echo "#>end 01-alternatives" >> abscripts/prerm
else
	abinfo "No alternatives file found."
fi

unset alternative addalt _archTarget _assignedGroup _grp _hasAlternative
