#!/bin/bash
##proc/preproc: pre-process "$SRCDIR" for packaging.
##@copyright GPL-2.0+

if (( EUID == 0 )); then
	# Fixing up ownership in "$SRCDIR"
	chown -R 0:0 "$SRCDIR" \
		|| echo "Cannot change source ownership to root:root: $?."

	# Removing SGID bit from "$SRCDIR"
	chmod a-s "$SRCDIR" \
		|| echo "Failed to remove SGID bit: $?."
fi

