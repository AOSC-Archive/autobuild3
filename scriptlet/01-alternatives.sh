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

if [ -f "$SRCDIR"/autobuild/alternatives ]; then
	abdbg "Found general alternatives file: ${SRCDIR}/autobuild/alternatives"
	_hasAlternative=1
fi

## More specific per-arch alternatives file always take precedence over per-group ones
if [ -f "$SRCDIR"/autobuild/${ABHOST}/alternatives ]; then
	abdbg "Found per-arch alternatives file: ${SRCDIR}/autobuild/${ABHOST}/alternatives"
	_hasAlternative=1
	_archTarget="/${ABHOST}"
else
	for _grp in ${ABHOST_GROUP}; do
		if [ -f "$SRCDIR"/autobuild/${_grp}/alternatives ]; then
			if [ $_assignedGroup ]; then
				aberr "Refusing to use autobuild/${_grp}/alternatives for group-specific alternatives"
				aberr "... because another file autobuild/${_assignedGroup}/alternatives is also valid for target architecture"
				abinfo "Current ABHOST ${ABHOST} belongs to the following groups:"
				abinfo "${ABHOST_GROUP//$'\n'/, }"
				abinfo "Create per-arch autobuild/${ABHOST}/alternatives instead to resolve the conflict"
				abdie "Multiple per-group alternative files for target architecture detected! Refuse to proceed."
			fi
			abdbg "Found per-group alternatives file: ${SRCDIR}/autobuild/${_grp}/alternatives"
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
