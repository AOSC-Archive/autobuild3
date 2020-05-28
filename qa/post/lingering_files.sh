#!/bin/bash
##lingering_files: Check for lingering files.
##@copyright GPL-2.0+
FILES="$(find "$PKGDIR" "$PKGDIR/usr/" "$PKGDIR/usr/share/" -maxdepth 1 -type f -print)"
[ ! -z "$FILES" ] && \
	(abicu "QA (E321): Lingering file(s) found, incorrect install location?\n $FILES" || true) | \
		tee -a "$SRCDIR"/abqaerr.log
