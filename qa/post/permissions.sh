#!/bin/bash
##permissions: Check for incorrect permissions.
##@copyright GPL-2.0+
FILES="$(find "$PKGDIR/usr/bin" -type f -not -executable -print)"
[ ! -z "$FILES" ] && abicu "QA (E324): non-executable file(s) found in /usr/bin:\n$FILES"

FILES="$(find "$PKGDIR/usr/lib" -type f -name '*.so*' -not -executable -print)"
[ ! -z "$FILES" ] && abicu "QA (E324): non-executable shared object(s) found in /usr/lib:\n $FILES"
