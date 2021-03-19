#!/bin/bash
##proc/archive: archives the package.
##@copyright GPL-2.0+
if [ "$ABARCHIVE" ]; then
	abinfo "Archiving package(s) ..."
	abinfo "Using $ABARCHIVE as autobuild archiver ..."
	$ABARCHIVE "$PKGNAME" "$PKGVER" "$PKGREL" "$ABHOST"
	# FIXME: should consult ABPACKAGE for the actual list of package to copy.
	#   ~cth
	if bool $ABSPLITDBG; then
		$ABARCHIVE "$PKGNAME"-dbg "$PKGVER" "$PKGREL" "$ABHOST"
	fi
else
	abinfo "Not using an archiver, skipping ..."
fi
