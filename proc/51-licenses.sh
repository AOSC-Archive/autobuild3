#!/bin/bash
##proc/licenses.sh: SPDX-compatible license processing.
##@copyright GPL-2.0+
# _license_atom: _license [ " WITH " _exception ]
# TODO: Multiple exceptions, Unknown exceptions

_license_files=( {COPYING,LICENSE}* )

mkdir -p "$PKGDIR/usr/share/doc/$PKGNAME"
((${#_license_files[@]})) && cp -r --no-preserve=mode "${_license_files[@]}" "$PKGDIR/usr/share/doc/$PKGNAME"
