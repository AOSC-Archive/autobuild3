#!/bin/bash
##20-lingering_files: Check for lingering files.
##@copyright GPL-2.0+
for i in "$PKGDIR"/* "$PKGDIR"/usr/* "$PKGDIR"/usr/share/*; do
	if test -f "$i"; then
		abicu "QA: Lingering file found at $i, incorrect install location?"
	fi
done
