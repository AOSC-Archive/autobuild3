#!/bin/bash
##permissions: Check for incorrect permissions.
##@copyright GPL-2.0+
FILES="$(find "$PKGDIR/usr/bin" -type f -not -executable -print 2>/dev/null)"
if [ ! -z "$FILES" ]; then
	aberr "QA (E324): non-executable file(s) found in /usr/bin:\n\n${FILES}\n" | \
		tee -a "$SRCDIR"/abqaerr.log
fi

FILES="$(find "$PKGDIR/usr/lib" -type f -name '*.so.*' -not -executable -print 2>/dev/null)"
if [ ! -z "$FILES" ]; then
	aberr "QA (E324): non-executable shared object(s) found in /usr/lib:\n\n${FILES}\n" | \
		tee -a "$SRCDIR"/abqaerr.log
fi

FILES="$(find "$PKGDIR/usr/lib" -type f -name '*.a' -executable -print 2>/dev/null)"
if [ ! -z "$FILES" ]; then
	aberr "QA (E324): executable static object(s) found in /usr/lib:\n\n${FILES}\n" | \
		tee -a "$SRCDIR"/abqaerr.log
fi

FILES="$(find "$PKGDIR/usr/lib" -type f -name '*.o' -executable -print 2>/dev/null)"
if [ ! -z "$FILES" ]; then
	aberr "QA (E324): executable binary object(s) found in /usr/lib:\n\n${FILES}\n" | \
		tee -a "$SRCDIR"/abqaerr.log
fi
