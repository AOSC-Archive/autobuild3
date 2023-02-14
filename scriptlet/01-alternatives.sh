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

ABALTDEFINES=alternatives

if bool $ABSTAGE2; then
	if [ -f "$SRCDIR"/autobuild/${ABALTDEFINES}.stage2 ]; then
		abdbg "stage2: Found stage2 alternatives file, using ${ABALTDEFINES}.stage2 ..."
		ABALTDEFINES=alternatives.stage2
		_hasAlternative=1
	elif [ -f "$SRCDIR"/autobuild/${ABALTDEFINES} ]; then
		abdbg "stage2: Found general alternatives file: ${SRCDIR}/autobuild/${ABALTDEFINES}"
		_hasAlternative=1
	fi
else
	if [ -f "$SRCDIR"/autobuild/${ABALTDEFINES} ]; then
		abdbg "Found general alternatives file: ${SRCDIR}/autobuild/${ABALTDEFINES}"
		_hasAlternative=1
	fi
fi

## More specific per-arch alternatives file always take precedence over per-group ones
if bool $ABSTAGE2; then
	if [ -f "$SRCDIR"/autobuild/${ABHOST}/${ABALTDEFINES}.stage2 ]; then
		abdbg "Found per-arch stage2 alternatives file: ${SRCDIR}/autobuild/${ABHOST}/${ABALTDEFINES}.stage2"
		ABALTDEFINES=alternatives.stage2
		_hasAlternative=1
		_archTarget="/${ABHOST}"
	elif [ -f "$SRCDIR"/autobuild/${ABHOST}/${ABALTDEFINES} ]; then
		abdbg "Found per-arch alternatives file: ${SRCDIR}/autobuild/${ABHOST}/${ABALTDEFINES}.stage2"
		ABALTDEFINES=alternatives.stage2
		_hasAlternative=1
		_archTarget="/${ABHOST}"
	else
		for _grp in ${ABHOST_GROUP}; do
			if [ -f "$SRCDIR"/autobuild/${_grp}/${ABALTDEFINES}.stage2 ]; then
				if [ $_assignedGroup ]; then
					aberr "Refusing to use autobuild/${_grp}/${ABALTDEFINES} for group-specific alternatives"
					aberr "... because another file autobuild/${_assignedGroup}/${ABALTDEFINES} is also valid for target architecture"
					abinfo "Current ABHOST ${ABHOST} belongs to the following groups:"
					abinfo "${ABHOST_GROUP//$'\n'/, }"
					abinfo "Create per-arch autobuild/${ABHOST}/${ABALTDEFINES} instead to resolve the conflict"
					abdie "Multiple per-group alternative files for target architecture detected! Refuse to proceed."
				fi
				abdbg "Found per-group stage2 alternatives file: ${SRCDIR}/autobuild/${_grp}/${ABALTDEFINES}"
				ABALTDEFINES=alternatives.stage2
				_hasAlternative=1
				_archTarget="/${_grp}"
				_assignedGroup=${_grp}
			elif [ -f "$SRCDIR"/autobuild/${_grp}/${ABALTDEFINES} ]; then
				if [ $_assignedGroup ]; then
					aberr "Refusing to use autobuild/${_grp}/${ABALTDEFINES} for group-specific alternatives"
					aberr "... because another file autobuild/${_assignedGroup}/${ABALTDEFINES} is also valid for target architecture"
					abinfo "Current ABHOST ${ABHOST} belongs to the following groups:"
					abinfo "${ABHOST_GROUP//$'\n'/, }"
					abinfo "Create per-arch autobuild/${ABHOST}/${ABALTDEFINES} instead to resolve the conflict"
					abdie "Multiple per-group alternative files for target architecture detected! Refuse to proceed."
				fi
				abdbg "Found per-group alternatives file: ${SRCDIR}/autobuild/${_grp}/${ABALTDEFINES}"
				_hasAlternative=1
				_archTarget="/${_grp}"
				_assignedGroup=${_grp}
			fi
		done
	fi
else
	if [ -f "$SRCDIR"/autobuild/${ABHOST}/${ABALTDEFINES} ]; then
		abdbg "Found per-arch alternatives file: ${SRCDIR}/autobuild/${ABHOST}/${ABALTDEFINES}"
		_hasAlternative=1
		_archTarget="/${ABHOST}"
	else
		for _grp in ${ABHOST_GROUP}; do
			if [ -f "$SRCDIR"/autobuild/${_grp}/${ABALTDEFINES} ]; then
				if [ $_assignedGroup ]; then
					aberr "Refusing to use autobuild/${_grp}/${ABALTDEFINES} for group-specific alternatives"
					aberr "... because another file autobuild/${_assignedGroup}/${ABALTDEFINES} is also valid for target architecture"
					abinfo "Current ABHOST ${ABHOST} belongs to the following groups:"
					abinfo "${ABHOST_GROUP//$'\n'/, }"
					abinfo "Create per-arch autobuild/${ABHOST}/${ABALTDEFINES} instead to resolve the conflict"
					abdie "Multiple per-group alternative files for target architecture detected! Refuse to proceed."
				fi
				abdbg "Found per-group alternatives file: ${SRCDIR}/autobuild/${_grp}/${ABALTDEFINES}"
				_hasAlternative=1
				_archTarget="/${_grp}"
				_assignedGroup=${_grp}
			fi
		done
	fi
fi

if bool "$_hasAlternative"; then
	abinfo "Taking alternatives file: ${SRCDIR}/autobuild${_archTarget}/${ABALTDEFINES}"
	echo "#>start 01-alternatives" >> abscripts/postinst
	echo "#>start 01-alternatives" >> abscripts/prerm
	. "$SRCDIR"/autobuild"$_archTarget"/${ABALTDEFINES}
	echo "#>end 01-alternatives" >> abscripts/postinst
	echo "#>end 01-alternatives" >> abscripts/prerm
else
	abinfo "No alternatives file found."
fi

unset alternative addalt _archTarget _assignedGroup _grp _hasAlternative
