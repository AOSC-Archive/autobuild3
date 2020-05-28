#!/bin/bash
##lingering_files: Check for lingering files.
##@copyright GPL-2.0+
for i in "$PKGDIR"/* "$PKGDIR"/usr/* "$PKGDIR"/usr/share/*; do
	if test -f "$i"; then
		abicu "QA (E321): Lingering file found at $i, incorrect install location?"
	fi
done
