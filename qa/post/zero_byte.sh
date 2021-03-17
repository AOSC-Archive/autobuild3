#!/bin/bash
##zero_byte: Check for zero-byte files.
##@copyright GPL-2.0+
FILES="$(find "$PKGDIR" -type f -size 0 -print)"
if [ ! -z "$FILES" ]; then
	abwarn "QA (W322): Zero-byte files found:\n $FILES." | \
		tee -a "$SRCDIR"/abqawarn.log
fi
