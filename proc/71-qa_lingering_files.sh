#!/bin/bash
##71-qa_lingering_files: Check for lingering files.
##@copyright GPL-2.0+
bool "$ABQA" || return
for i in "$PKGDIR"/* "$PKGDIR"/usr/* "$PKGDIR"/usr/share/*; do
	if test -f "$i"; then
		abicu "QA: Possible lingering file found at $i, incorrect install location?"
	fi
done
