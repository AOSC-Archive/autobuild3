#!/bin/bash
##zero_byte: Check for zero-byte files.
##@copyright GPL-2.0+
FILES="$(find "$PKGDIR" -type f -size 0 -print)"
[ ! -z "$FILES" ] && abwarn "QA (W322): Zero-byte files found:\n $FILES."
