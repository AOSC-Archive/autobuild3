#!/bin/bash
##permissions: Check for incorrect permissions.
##@copyright GPL-2.0+
for i in `find "$PKGDIR"/usr/bin -type f`; do
	if [ ! -x "$i" ]; then
		abwarn "QA (E324): non-executable file $i found in /usr/bin."
	fi
done

for i in `find "$PKGDIR"/usr/lib -type f -name '*.so*'`; do
        if [ ! -x "$i" ]; then
                abwarn "QA (E324): non-executable shared object $i found in /usr/lib."
        fi
done
