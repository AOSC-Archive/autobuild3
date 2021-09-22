#!/bin/bash
##proc/licenses.sh: SPDX-compatible license processing.
##@copyright GPL-2.0+
# _license_atom: _license [ " WITH " _exception ]
# TODO: Multiple exceptions, Unknown exceptions

_license_files=( {COPYING,LICENSE,LICENCE}* )

mkdir -p "$PKGDIR/usr/share/doc/$PKGNAME"
if ((${#_license_files[@]})); then
	cp -L -r --no-preserve=mode "${_license_files[@]}" "$PKGDIR/usr/share/doc/$PKGNAME"
else
	abwarn "This package does not contain a COPYING or LICENCE file!"
fi
