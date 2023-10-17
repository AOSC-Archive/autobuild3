#!/bin/bash

filter_optenv_drop_share() {
	if [[ "$ABHOST" ~ optenv* ]] ; then
		abinfo "Dropping the entire share directory in the installed prefix..."
		case "$ABHOST" in
			optenv32)
				# Not enabling verbosity due to possible too many files.
				rm -r "$PKGDIR"/opt/32/share
				;;
			*)
				abdie "Not implemented yet, sorry!"
				;;
		esac
	fi
}

ABFILTERS+=" optenv_drop_share"
