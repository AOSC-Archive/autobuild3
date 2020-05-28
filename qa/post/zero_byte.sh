#!/bin/bash
##zero_byte: Check for zero-byte files.
##@copyright GPL-2.0+
for i in `find "$PKGDIR" -type f`; do
	if [ ! -s "$i" ]; then
		abwarn "QA (W322): Zero-byte file found at $i."
	fi
done
